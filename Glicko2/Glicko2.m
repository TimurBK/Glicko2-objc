//
//  Glicko2.m
//  Glicko2
//
//  Created by Timur Kuchkarov on 14.04.15.
//  Copyright (c) 2015 Timur Kuchkarov. All rights reserved.
//

#import "Glicko2.h"
#import "PlayerFactory.h"

static double const PI_SQUARED = M_PI * M_PI;
static double const kGlickoVolatilityConstraint = 0.5;
static double const kGlickoVolatilityConstraintSquared = kGlickoVolatilityConstraint * kGlickoVolatilityConstraint;
static double const kGlickoScaleConst = 173.7178;
static double const kGlicko2DefaultCalcRating = 1500.;
static double const kGlickoEpsilon = 0.000001;

@interface GlickoRange : NSObject

@end

@interface GlickoRange () <GlickoRange>

- (instancetype)initWithMinimumRating:(double)minRating
						maximumRating:(double)maximumRating
						   confidence:(double)confidence;

@end

@implementation GlickoRange

@synthesize maximumRating = _maximumRating;
@synthesize minimumRating = _minimumRating;
@synthesize confidence = _confidence;

- (instancetype)init
{
	return [self initWithMinimumRating:0 maximumRating:0 confidence:0];
}

- (instancetype)initWithMinimumRating:(double)minRating
						maximumRating:(double)maximumRating
						   confidence:(double)confidence
{
	self = [super init];
	if (self != nil) {
		;
	}
	return self;
}

@end

double glicko2PointsFromResult(GlickoGameResult result)
{
	switch (result) {
		case GlickoGameResultDraw: {
			return 0.5;
		} break;

		case GlickoGameResultLoss: {
			return 0.0;
		} break;

		case GlickoGameResultVictory: {
			return 1.0;
		} break;

		default:
			break;
	};
}

// Scaling from step 2
double glicko2ScaledRatingFromRating(double rating)
{
	return (rating - kGlicko2DefaultCalcRating) / kGlickoScaleConst;
}

// Scaling from step 2
double glicko2ScaledDeviationFromDeviation(double deviation)
{
	return deviation / kGlickoScaleConst;
}

// g from step 3
double glicko2GWithDeviation(double deviation)
{
	return 1 / sqrt(1 + ((3 * deviation * deviation) / PI_SQUARED));
}

// E from step 3
double glicko2E(double playerRating2, double opponentRating2, double opponentDeviation2)
{
	return 1 / (1 + exp(-glicko2GWithDeviation(opponentDeviation2) * (playerRating2 - opponentRating2)));
}

// F from step 5
double glicko2F(double x, double a, double estimatedImprovement, double estimatedVariance, double playerVolatility,
				double playerDeviation2)
{
	double epowx = pow(M_E, x);
	double pDeviationSquared = playerDeviation2 * playerDeviation2;
	return ((epowx * (estimatedImprovement * estimatedImprovement - pDeviationSquared - estimatedVariance - epowx)) /
			(2 * pow(pDeviationSquared + estimatedVariance + epowx, 2))) -
		   ((x - a) / kGlickoVolatilityConstraintSquared);
}

// Step 3
double glicko2EstimatedVariance(double playerRating2, NSArray *gamesArray, id<Player> currentPlayer)
{
	double sum = 0;

	for (id<Game> game in gamesArray) {
		id<Player> opponent = ([[game player1] playerID] != [currentPlayer playerID]) ? [game player1] : [game player2];
		double opponentRating2 = glicko2ScaledRatingFromRating([opponent rating]);
		double opponentDeviation2 = glicko2ScaledDeviationFromDeviation([opponent ratingDeviation]);
		double opponentG = glicko2GWithDeviation(opponentDeviation2);
		double eValue = glicko2E(playerRating2, opponentRating2, opponentDeviation2);
		double val = opponentG * opponentG * eValue * (1 - eValue);
		sum += val;
	}

	return 1 / sum;
}

// Step 4
double glicko2EstimatedImprovement(double estimatedVariance, double playerRating2, NSArray *gamesArray,
								   id<Player> currentPlayer)
{
	double sum = 0;

	for (id<Game> game in gamesArray) {
		id<Player> opponent = nil;
		double playerScore = 0;

		if ([[game player1] playerID] != [currentPlayer playerID]) {
			opponent = [game player1];
			playerScore = [game p2score];
		} else {
			opponent = [game player2];
			playerScore = [game p1score];
		}

		double opponentRating2 = glicko2ScaledRatingFromRating([opponent rating]);
		double opponentDeviation2 = glicko2ScaledDeviationFromDeviation([opponent ratingDeviation]);
		double opponentG = glicko2GWithDeviation(opponentDeviation2);
		double eValue = glicko2E(playerRating2, opponentRating2, opponentDeviation2);
		double val = opponentG * (playerScore - eValue);
		sum += val;
	}

	return estimatedVariance * sum;
}

// Step 5
double glicko2UpdatedVolatility(double estimatedImprovement, double estimatedVariance, double playerVolatility,
								double playerDeviation2)
{
	double a = log(playerVolatility * playerVolatility);
	double A = log(playerVolatility * playerVolatility);
	double estImprovementSquared = estimatedImprovement * estimatedImprovement;
	double deviationSquared = playerDeviation2 * playerDeviation2;

	double B;
	if (estImprovementSquared > deviationSquared + estimatedVariance) {
		B = log(estImprovementSquared - deviationSquared - estimatedVariance);
	} else {
		long k = 1;
		while (glicko2F((a - k * kGlickoVolatilityConstraint), a, estimatedImprovement, estimatedVariance,
						playerVolatility, playerDeviation2) < 0) {
			k++;
		}
		B = a - k * kGlickoVolatilityConstraint;
	}

	double fa = glicko2F(A, a, estimatedImprovement, estimatedVariance, playerVolatility, playerDeviation2);
	double fb = glicko2F(B, a, estimatedImprovement, estimatedVariance, playerVolatility, playerDeviation2);

	while (fabs(B - A) > kGlickoEpsilon) {
		double C = A + ((A - B) * fa / (fb - fa));
		double fc = glicko2F(C, a, estimatedImprovement, estimatedVariance, playerVolatility, playerDeviation2);
		if (fc * fb < 0) {
			A = B;
			fa = fb;
		} else {
			fa = fa * 0.5;
		}
		B = C;
		fb = fc;
	}

	return pow(M_E, 0.5 * A);
}

// Step 6

double glicko2UpdatedRatingDeviationPreRating(double ratingDeviation2, double updatedVolatility)
{
	return sqrt(ratingDeviation2 * ratingDeviation2 + updatedVolatility * updatedVolatility);
}

// Step 7
double glicko2UpdatedRatingDeviation(double preratingRD, double estimatedVariance)
{
	return 1 / sqrt(1 / (preratingRD * preratingRD) + 1 / estimatedVariance);
}

// step 7
double glicko2UpdatedRating(double playerRating2, double updatedDeviation2, NSArray *gamesArray,
							id<Player> currentPlayer)
{
	double sum = 0;

	// ------- Consider vvv reuse -------
	for (id<Game> game in gamesArray) {
		id<Player> opponent = nil;
		double playerScore = 0;

		if ([[game player1] playerID] != [currentPlayer playerID]) {
			opponent = [game player1];
			playerScore = [game p2score];
		} else {
			opponent = [game player2];
			playerScore = [game p1score];
		}

		double opponentRating2 = glicko2ScaledRatingFromRating([opponent rating]);
		double opponentDeviation2 = glicko2ScaledDeviationFromDeviation([opponent ratingDeviation]);
		double opponentG = glicko2GWithDeviation(opponentDeviation2);
		double eValue = glicko2E(playerRating2, opponentRating2, opponentDeviation2);
		double val = opponentG * (playerScore - eValue);
		sum += val;
	}
	// ------- Consider ^^^ reuse -------

	return playerRating2 + sum * updatedDeviation2 * updatedDeviation2;
}

// step 8

double glicko2UnscaleRating2(double rating2)
{
	return kGlickoScaleConst * rating2 + kGlicko2DefaultCalcRating;
}

double glicko2UnscaleRD2(double RD2)
{
	return kGlickoScaleConst * RD2;
}

@interface Glicko2 ()

@end

@implementation Glicko2

+ (id<GlickoRange>)ratingWith95PercentConfidenceForPlayer:(id<Player>)player
{
	double min = [player rating] - 2 * [player ratingDeviation];
	double max = [player rating] + 2 * [player ratingDeviation];
	return [[GlickoRange alloc] initWithMinimumRating:min maximumRating:max confidence:0.95];
}

+ (id<Player>)updatedDataForPlayer:(id<Player>)player afterGames:(NSArray *)games
{
	double rating2 = glicko2ScaledRatingFromRating([player rating]);
	double deviation2 = glicko2ScaledDeviationFromDeviation([player ratingDeviation]);
	double estVariance = glicko2EstimatedVariance(rating2, games, player);
	double estImp = glicko2EstimatedImprovement(estVariance, rating2, games, player);
	double updVolatility = glicko2UpdatedVolatility(estImp, estVariance, [player ratingVolatility], deviation2);
	double preratedDev = glicko2UpdatedRatingDeviationPreRating(deviation2, updVolatility);
	double rd2 = glicko2UpdatedRatingDeviation(preratedDev, estVariance);
	double updRat2 = glicko2UpdatedRating(rating2, rd2, games, player);

	double resRating = glicko2UnscaleRating2(updRat2);
	double resRD = glicko2UnscaleRD2(rd2);

	return [PlayerFactory updatePlayer:player withRating:resRating volatility:updVolatility deviation:resRD];
}

#pragma mark - Singleton protocol

+ (instancetype)sharedInstance
{
	static Glicko2 *sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	  sharedInstance = [[[self class] alloc] init];
	  [sharedInstance initialConfiguration];
	});
	return sharedInstance;
}

- (void)initialConfiguration
{
	;
}

@end
