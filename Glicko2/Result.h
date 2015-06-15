//
//  Result.h
//  Glicko2
//
//  Created by Timur Kuchkarov on 26.04.15.
//  Copyright (c) 2015 Timur Kuchkarov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Team;

@protocol Result<NSObject>

@property (nonatomic, readonly, strong) id<Team> team1;
@property (nonatomic, readonly, strong) id<Team> team2;

@end
