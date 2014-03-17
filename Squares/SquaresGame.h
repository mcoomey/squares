//
//  SquaresGame.h
//  Squares
//
//  Created by Michael Coomey on 3/5/14.
//  Copyright (c) 2014 Michael Coomey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameBoard.h"
#import "BoardHorizontalLine.h"
#import "BoardVerticalLine.h"

@interface SquaresGame : NSObject

@property (nonatomic, readwrite) int player1Score;
@property (nonatomic, readwrite) int player2Score;
@property (nonatomic, strong) GameBoard *board;
@property (nonatomic, readwrite) LineState currentPlayer;
@property (nonatomic, readwrite) NSUInteger linesRemaining;

- (BOOL)selectHorizontalLine:(BoardHorizontalLine*)bhl;
- (BOOL)selectVerticalLine:(BoardVerticalLine*)bvl;
- (void) resetGameValues;
@end
