//
//  GlickoRange.h
//  Glicko2
//
//  Created by Timur Kuchkarov on 26.04.15.
//  Copyright (c) 2015 Timur Kuchkarov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GlickoRange<NSObject>

@property (nonatomic, readonly, assign) double minimumRating;
@property (nonatomic, readonly, assign) double maximumRating;
@property (nonatomic, readonly, assign) double confidence;

@end
