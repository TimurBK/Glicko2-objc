//
//  GameFactory.m
//  Glicko2
//
//  Created by Timur Kuchkarov on 28.04.15.
//  Copyright (c) 2015 Timur Kuchkarov. All rights reserved.
//

#import "GameFactory.h"
#import "GameObject.h"

@implementation GameFactory

+ (id<Game>)gameWithPlayer1:(id<Player>)p1
					player2:(id<Player>)p2
			   player1Score:(double)p1score
			   player2Score:(double)p2score
{
	return [GameObject gameWithPlayer1:p1 player2:p2 player1Score:p1score player2Score:p2score];
}

@end
