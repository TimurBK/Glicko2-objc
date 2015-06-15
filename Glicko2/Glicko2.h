//
//  Glicko2.h
//  Glicko2
//
//  Created by Timur Kuchkarov on 14.04.15.
//  Copyright (c) 2015 Timur Kuchkarov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlickoRange.h"
#import "Player.h"
#import "Game.h"
#import "Team.h"
#import "Result.h"

typedef NS_ENUM(NSInteger, GlickoGameResult) {
	GlickoGameResultVictory = 1,
	GlickoGameResultDraw = 2,
	GlickoGameResultLoss = 3
};

@interface Glicko2 : NSObject

+ (id<GlickoRange>)ratingWith95PercentConfidenceForPlayer:(id<Player>)player;
+ (id<Player>)updatedDataForPlayer:(id<Player>)player afterGames:(NSArray *)games;

double glicko2PointsFromResult(GlickoGameResult result);

@end
