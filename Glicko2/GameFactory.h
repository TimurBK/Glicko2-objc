//
//  GameFactory.h
//  Glicko2
//
//  Created by Timur Kuchkarov on 28.04.15.
//  Copyright (c) 2015 Timur Kuchkarov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Game;
@protocol Player;

@interface GameFactory : NSObject

+ (id<Game>)gameWithPlayer1:(id<Player>)p1
					player2:(id<Player>)p2
			   player1Score:(double)p1score
			   player2Score:(double)p2score;

@end
