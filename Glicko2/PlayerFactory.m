//
//  PlayerFactory.m
//  Glicko2
//
//  Created by Timur Kuchkarov on 26.04.15.
//  Copyright (c) 2015 Timur Kuchkarov. All rights reserved.
//

#import "PlayerFactory.h"
#import "PlayerObject.h"

@interface PlayerFactory ()

@end

@implementation PlayerFactory

+ (id<Player>)playerWithParameters:(NSDictionary *)parameters
{
	double rating = 0;
	double volatility = 0;
	double deviation = 0;
	return [PlayerFactory playerWithRating:rating volatility:volatility deviation:deviation];
}

+ (id<Player>)playerWithRating:(double)rating volatility:(double)volatility deviation:(double)deviation
{
	return [[PlayerObject alloc] initWithRating:rating deviation:deviation volatility:volatility];
}

+ (id<Player>)updatePlayer:(id<Player>)player
				withRating:(double)rating
				volatility:(double)volatility
				 deviation:(double)deviation
{
	id<Player> updated = [PlayerFactory playerWithRating:rating volatility:volatility deviation:deviation];
	((PlayerObject *)updated).playerID = [player playerID];
	return updated;
}

@end
