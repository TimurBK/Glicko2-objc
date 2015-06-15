//
//  Game.h
//  Glicko2
//
//  Created by Timur Kuchkarov on 26.04.15.
//  Copyright (c) 2015 Timur Kuchkarov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Player;

@protocol Game<NSObject>

@property (nonatomic, readonly, strong) id<Player> player1;
@property (nonatomic, readonly, strong) id<Player> player2;

@property (nonatomic, readonly, assign) double p1score;
@property (nonatomic, readonly, assign) double p2score;

@end
