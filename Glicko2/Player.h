//
//  Player.h
//  Glicko2
//
//  Created by Timur Kuchkarov on 26.04.15.
//  Copyright (c) 2015 Timur Kuchkarov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Player<NSObject>

@property (nonatomic, readonly, assign) double rating;
@property (nonatomic, readonly, assign) double ratingDeviation;
@property (nonatomic, readonly, assign) double ratingVolatility;
@property (nonatomic, readonly, strong) NSString *playerID;

@end
