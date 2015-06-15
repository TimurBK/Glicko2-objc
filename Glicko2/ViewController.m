//
//  ViewController.m
//  Glicko2
//
//  Created by Timur Kuchkarov on 14.04.15.
//  Copyright (c) 2015 Timur Kuchkarov. All rights reserved.
//

#import "ViewController.h"
#import "Glicko2.h"
#import "PlayerFactory.h"
#import "Player.h"
#import "Game.h"
#import "GameFactory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	NSLog(@"GO");
	id<Player> current = [PlayerFactory playerWithRating:1500 volatility:0.06 deviation:350];

	id<Player> opponent1 = [PlayerFactory playerWithRating:1400 volatility:0.06 deviation:30];
	id<Player> opponent2 = [PlayerFactory playerWithRating:1550 volatility:0.06 deviation:100];
	id<Player> opponent3 = [PlayerFactory playerWithRating:1700 volatility:0.06 deviation:300];
	id<Player> opponent4 = [PlayerFactory playerWithRating:1480 volatility:0.06 deviation:12];
	id<Player> opponent5 = [PlayerFactory playerWithRating:1235 volatility:0.06 deviation:432];
	id<Player> opponent6 = [PlayerFactory playerWithRating:2134 volatility:0.06 deviation:412];
	id<Player> opponent7 = [PlayerFactory playerWithRating:1797 volatility:0.06 deviation:124];
	id<Player> opponent8 = [PlayerFactory playerWithRating:1336 volatility:0.06 deviation:63];
	id<Player> opponent9 = [PlayerFactory playerWithRating:1975 volatility:0.06 deviation:12];
	id<Player> opponent10 = [PlayerFactory playerWithRating:2099 volatility:0.06 deviation:64];
	id<Player> opponent11 = [PlayerFactory playerWithRating:1644 volatility:0.06 deviation:366];
	id<Player> opponent12 = [PlayerFactory playerWithRating:2124 volatility:0.06 deviation:321];

	NSMutableArray *arr = [NSMutableArray array];
	id<Game> game1 = [GameFactory gameWithPlayer1:current
										  player2:opponent1
									 player1Score:glicko2PointsFromResult(GlickoGameResultVictory)
									 player2Score:glicko2PointsFromResult(GlickoGameResultLoss)];

	[arr addObject:game1];

	id<Game> game2 = [GameFactory gameWithPlayer1:current
										  player2:opponent2
									 player1Score:glicko2PointsFromResult(GlickoGameResultVictory)
									 player2Score:glicko2PointsFromResult(GlickoGameResultLoss)];

	[arr addObject:game2];

	id<Game> game3 = [GameFactory gameWithPlayer1:current
										  player2:opponent3
									 player1Score:glicko2PointsFromResult(GlickoGameResultVictory)
									 player2Score:glicko2PointsFromResult(GlickoGameResultLoss)];

	[arr addObject:game3];

	id<Game> game4 = [GameFactory gameWithPlayer1:current
										  player2:opponent4
									 player1Score:glicko2PointsFromResult(GlickoGameResultVictory)
									 player2Score:glicko2PointsFromResult(GlickoGameResultLoss)];

	[arr addObject:game4];

	id<Game> game5 = [GameFactory gameWithPlayer1:current
										  player2:opponent5
									 player1Score:glicko2PointsFromResult(GlickoGameResultVictory)
									 player2Score:glicko2PointsFromResult(GlickoGameResultLoss)];

	[arr addObject:game5];

	id<Game> game6 = [GameFactory gameWithPlayer1:current
										  player2:opponent6
									 player1Score:glicko2PointsFromResult(GlickoGameResultVictory)
									 player2Score:glicko2PointsFromResult(GlickoGameResultLoss)];

	[arr addObject:game6];

	id<Game> game7 = [GameFactory gameWithPlayer1:current
										  player2:opponent7
									 player1Score:glicko2PointsFromResult(GlickoGameResultVictory)
									 player2Score:glicko2PointsFromResult(GlickoGameResultLoss)];

	[arr addObject:game7];

	id<Game> game8 = [GameFactory gameWithPlayer1:current
										  player2:opponent8
									 player1Score:glicko2PointsFromResult(GlickoGameResultVictory)
									 player2Score:glicko2PointsFromResult(GlickoGameResultLoss)];

	[arr addObject:game8];

	id<Game> game9 = [GameFactory gameWithPlayer1:current
										  player2:opponent9
									 player1Score:glicko2PointsFromResult(GlickoGameResultVictory)
									 player2Score:glicko2PointsFromResult(GlickoGameResultLoss)];

	[arr addObject:game9];

	id<Game> game10 = [GameFactory gameWithPlayer1:current
										   player2:opponent10
									  player1Score:glicko2PointsFromResult(GlickoGameResultVictory)
									  player2Score:glicko2PointsFromResult(GlickoGameResultLoss)];

	[arr addObject:game10];

	id<Game> game11 = [GameFactory gameWithPlayer1:current
										   player2:opponent11
									  player1Score:glicko2PointsFromResult(GlickoGameResultVictory)
									  player2Score:glicko2PointsFromResult(GlickoGameResultLoss)];

	[arr addObject:game11];

	id<Game> game12 = [GameFactory gameWithPlayer1:current
										   player2:opponent12
									  player1Score:glicko2PointsFromResult(GlickoGameResultVictory)
									  player2Score:glicko2PointsFromResult(GlickoGameResultLoss)];

	[arr addObject:game12];

	current = [Glicko2 updatedDataForPlayer:current afterGames:arr];
	NSLog(@"res = %@", current);
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
