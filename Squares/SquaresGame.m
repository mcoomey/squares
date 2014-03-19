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


- (void) togglePlayer {
    self.currentPlayer = (self.currentPlayer == LineStateRed) ? LineStateBlue : LineStateRed;
}

- (void) incrementScore {
    if (self.currentPlayer == LineStateRed) {
        self.player1Score++;
    }
    else {
        self.player2Score++;
    }
    
}

-(BOOL)selectHorizontalLine:(BoardHorizontalLine*)bhl {
    
    if ([bhl stateOfLine] == LineStateFree) {   // if line is not yet selected
        [bhl setStateOfLine:self.currentPlayer];
        [self.board setHLineAtRow:(int)bhl.row andColumn:(int)bhl.column toState:self.currentPlayer];
        [bhl setNeedsDisplay];
        
        if (![self hLineDidCompleteSquare:bhl]) {
             [self togglePlayer];
        }
        self.linesRemaining--;
        return YES;             // return YES to update the display
    }
    
    return NO;                  // nothing has changed - no update necessary
}

-(BOOL)selectVerticalLine:(BoardVerticalLine*)bvl {
    
    if ([bvl stateOfLine] == LineStateFree) {
        [bvl setStateOfLine:self.currentPlayer];
        [self.board setVLineAtRow:(int)bvl.row andColumn:(int)bvl.column toState:self.currentPlayer];
        [bvl setNeedsDisplay];

        if ([self vLineDidCompleteSquare:bvl]==YES) {
            [self incrementScore];
        }
        else {
            [self togglePlayer];
        }
        self.linesRemaining--;
        return YES;             // return YES to update the display
    }
    return NO;                  // nothing has changed - no update necessary
}


- (BOOL) hLineDidCompleteSquare:(BoardHorizontalLine*)bhl {
    
    BOOL squareCompleted = NO;       // flag to indicated completed square above or below hLine
    
    if (bhl.row > 0) {          // check square above the hline
        
        int x = [self.board getHLineStateAtRow:(int)(bhl.row-1) andColumn:(int)bhl.column];
        if ((x!=LineStateFree))
//            &&
//            ([self.board getVLineStateAtRow:(int)(bhl.row-1) andColumn:(int)bhl.column]!=0)&&
//            ([self.board getVLineStateAtRow:(int)(bhl.row-1) andColumn:(int)bhl.column+1]!=0))
        {
            NSLog(@"**** Horizontal Line State at (%i, %i) is not free. ****", (int)bhl.row-1, (int)bhl.column);
            [self.board setSquareAtRow:(int)(bhl.row-1) andColumn:(int)bhl.column toState:self.currentPlayer];
            [self incrementScore];
            squareCompleted = YES;
        }
    }
    
//    if (bhl.row < 8) {          // check square below the hline
//        if (([self.board getHLineStateAtRow:(int)(bhl.row+1) andColumn:(int)bhl.column]!=0)&&
//            ([self.board getVLineStateAtRow:(int)(bhl.row) andColumn:(int)bhl.column]!=0)&&
//            ([self.board getVLineStateAtRow:(int)(bhl.row) andColumn:(int)bhl.column+1]!=0))
//        {
//            [self.board setSquareAtRow:(int)(bhl.row) andColumn:(int)bhl.column toState:self.currentPlayer];
//            [self incrementScore];
//            squareCompleted = YES;
//        }
//    }
   return squareCompleted;
}


- (BOOL) vLineDidCompleteSquare:(BoardVerticalLine*)bvl {
    
    BOOL squareCompleted = NO;       // flag to indicated completed square above or below hLine

    return squareCompleted;
}

@end
