//
//  Player.h
//  Glicko2
//
//  Created by Timur Kuchkarov on 26.04.15.
//  Copyright (c) 2015 Timur Kuchkarov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface PlayerObject : NSObject<Player>

- (instancetype)initWithRating:(double)rating deviation:(double)deviation volatility:(double)volatility;

@property (nonatomic, readwrite, strong) NSString *playerID;

@end
