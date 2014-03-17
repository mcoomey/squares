//
//  SquaresGame.m
//  Squares
//
//  Created by Michael Coomey on 3/5/14.
//  Copyright (c) 2014 Michael Coomey. All rights reserved.
//

#import "SquaresGame.h"
#import "GameBoard.h"
#import "GameConstants.h"
#import "SquaresGameViewController.h"
#import "BoardSquare.h"

@implementation SquaresGame



// initialize the game
-(SquaresGame*) init {

    self = [super init];
    if (self) {
        [self resetGameValues];
        NSLog(@"Game has been instantiated.");
        self.board = [[GameBoard alloc] init];
    }
    return self;
}

- (void) resetGameValues {
    self.player1Score = 0;
    self.player2Score = 0;
    self.currentPlayer = LineStateRed;
    self.linesRemaining = NUM_ROWS * (NUM_COLS + 1) + NUM_COLS * (NUM_ROWS + 1);
    [self.board resetHLines];
    [self.board resetVLines];
    [self.board resetSquares];
}

-(BOOL)selectHorizontalLine:(BoardHorizontalLine*)bhl {
    if ([bhl stateOfLine] == LineStateFree) {
        [bhl setStateOfLine:self.currentPlayer];
        [self.board setHLineAtRow:(int)bhl.row andColumn:(int)bhl.column toState:self.currentPlayer];
        NSLog(@"hLine(%ld) tapped at row= %lu and column = %lu ", (long)bhl.tag, (unsigned long)bhl.row, (unsigned long)bhl.column);
        [bhl setNeedsDisplay];
        
        if (bhl.row > 0) {
            [self.board setSquareAtRow:(int)bhl.row-1 andColumn:(int)bhl.column toState:self.currentPlayer];
        }
        
        [self togglePlayer];
        self.linesRemaining--;
        return YES;             // return YES to update the display
    }
    
    return NO;                  // nothing has changed - no update necessary
}

-(BOOL)selectVerticalLine:(BoardVerticalLine*)bvl {
    if ([bvl stateOfLine] == LineStateFree) {
        [bvl setStateOfLine:self.currentPlayer];
        [self.board setVLineAtRow:(int)bvl.row andColumn:(int)bvl.column toState:self.currentPlayer];
        NSLog(@"vLine(%ld) tapped at row= %lu and column = %lu ", (long)bvl.tag, (unsigned long)bvl.row, (unsigned long)bvl.column);
        [bvl setNeedsDisplay];

        [self togglePlayer];
        self.linesRemaining--;
        return YES;             // return YES to update the display
    }
    return NO;                  // nothing has changed - no update necessary
}

- (void) togglePlayer {
    self.currentPlayer = (self.currentPlayer == LineStateRed) ? LineStateBlue : LineStateRed;
}

@end
