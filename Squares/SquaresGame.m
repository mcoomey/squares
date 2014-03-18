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
        NSLog(@"hLine tapped at row= %lu and column = %lu ", (unsigned long)bhl.row, (unsigned long)bhl.column);
        [bhl setNeedsDisplay];
        
        // debug ************
        if (bhl.row < NUM_ROWS) {
            unsigned long idx = (unsigned long) bhl.row * NUM_COLS + (unsigned long) bhl.column;
            BoardSquare *bsq = [self.board.squares objectAtIndex:idx];
            [bsq setStateOfSquare:self.currentPlayer];
            [bsq setNeedsDisplay];
            [self.board.squares replaceObjectAtIndex:idx withObject:bsq];
            self.player1Score++;
        }
        // debug ************

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
        NSLog(@"vLine tapped at row= %lu and column = %lu ", (unsigned long)bvl.row, (unsigned long)bvl.column);
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
