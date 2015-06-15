
//
//  GameObject.m
//  Glicko2
//
//  Created by Timur Kuchkarov on 28.04.15.
//  Copyright (c) 2015 Timur Kuchkarov. All rights reserved.
//

#import "GameObject.h"

@interface GameObject ()

@property (nonatomic, readwrite, strong) id<Player> player1;
@property (nonatomic, readwrite, strong) id<Player> player2;

@property (nonatomic, readwrite, assign) double p1score;
@property (nonatomic, readwrite, assign) double p2score;

@end

@implementation GameObject

+ (instancetype)gameWithPlayer1:(id<Player>)p1
						player2:(id<Player>)p2
				   player1Score:(double)p1score
				   player2Score:(double)p2score
{
	GameObject *obj = [[GameObject alloc] init];
	if (obj != nil) {
		obj.player1 = p1;
		obj.player2 = p2;
		obj.p1score = p1score;
		obj.p2score = p2score;
	}
	return obj;
}

@end
