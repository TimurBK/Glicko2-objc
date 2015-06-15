//
//  PlayerFactory.h
//  Glicko2
//
//  Created by Timur Kuchkarov on 26.04.15.
//  Copyright (c) 2015 Timur Kuchkarov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface PlayerFactory : NSObject

+ (id<Player>)playerWithParameters:(NSDictionary *)parameters;
+ (id<Player>)playerWithRating:(double)rating volatility:(double)volatility deviation:(double)deviation;
+ (id<Player>)updatePlayer:(id<Player>)player
				withRating:(double)rating
				volatility:(double)volatility
				 deviation:(double)deviation;

@end
