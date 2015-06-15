//
//  Player.m
//  Glicko2
//
//  Created by Timur Kuchkarov on 26.04.15.
//  Copyright (c) 2015 Timur Kuchkarov. All rights reserved.
//

#import "PlayerObject.h"

static double const kGlickoDefaultRating = 1500.;
static double const kGlickoDefaultDeviation = 350.;
static double const kGlickoDefaultVolatility = 0.06;

@interface PlayerObject ()

@end

@implementation PlayerObject

@synthesize rating = _rating;
@synthesize ratingDeviation = _ratingDeviation;
@synthesize ratingVolatility = _ratingVolatility;

- (instancetype)init
{
	return [self initWithRating:kGlickoDefaultRating
					  deviation:kGlickoDefaultDeviation
					 volatility:kGlickoDefaultVolatility];
}

- (instancetype)initWithRating:(double)rating deviation:(double)deviation volatility:(double)volatility
{
	self = [super init];
	if (self) {
		_rating = rating;
		_ratingDeviation = deviation;
		_ratingVolatility = volatility;
		_playerID = [[NSUUID UUID] UUIDString];
	}
	return self;
}

- (NSString *)description
{
	return [@{
		@"rating" : @(self.rating),
		@"ratingDeviation" : @(self.ratingDeviation),
		@"ratingVolatility" : @(self.ratingVolatility),
		@"playerID" : self.playerID
	} description];
}

@end
