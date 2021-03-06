//
//  SquaresGame.m
//  Squares
//
//  Created by Michael Coomey on 3/5/14.
//  Copyright (c) 2014 Michael Coomey. All rights reserved.
//

#import "SquaresGame.h"
#import "GameBoard.h"
#import "SquaresGameViewController.h"
#import "BoardSquare.h"

@interface SquaresGame()

@property NSNumber *boardRows;
@property NSNumber *boardCols;

@end

@implementation SquaresGame


- (SquaresGame *)initWithNumRows:(int)rows andNumCols:(int)cols {
    
    self = [super init];
    if (self) {
        self.board = [[GameBoard alloc] initWithNumRows:rows andNumCols:cols];
        self.boardRows = [NSNumber numberWithInt:rows];
        self.boardCols = [NSNumber numberWithInt:cols];
        self.linesRemaining = [self.boardRows intValue] * ([self.boardCols intValue] + 1) + [self.boardCols intValue] * ([self.boardRows intValue] + 1);
    }
    return self;
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

        if (![self vLineDidCompleteSquare:bvl]) {
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
        
        if (([self.board getHLineStateAtRow:(int)(bhl.row-1) andColumn:(int)bhl.column] != LineStateFree) &&
            ([self.board getVLineStateAtRow:(int)(bhl.row-1) andColumn:(int)bhl.column] != LineStateFree) &&
            ([self.board getVLineStateAtRow:(int)(bhl.row-1) andColumn:(int)bhl.column+1] != LineStateFree))
        {
            [self.board setSquareAtRow:(int)(bhl.row-1) andColumn:(int)bhl.column toState:self.currentPlayer];
            [self incrementScore];
            squareCompleted = YES;
        }
    }
    
    if (bhl.row < [self.boardRows intValue]) {          // check square below the hline
        if (([self.board getHLineStateAtRow:(int)(bhl.row+1) andColumn:(int)bhl.column] != LineStateFree)&&
            ([self.board getVLineStateAtRow:(int)(bhl.row) andColumn:(int)bhl.column] != LineStateFree)&&
            ([self.board getVLineStateAtRow:(int)(bhl.row) andColumn:(int)bhl.column+1] != LineStateFree))
        {
            [self.board setSquareAtRow:(int)(bhl.row) andColumn:(int)bhl.column toState:self.currentPlayer];
            [self incrementScore];
            squareCompleted = YES;
        }
    }
   return squareCompleted;
}


- (BOOL) vLineDidCompleteSquare:(BoardVerticalLine*)bvl {
    
    BOOL squareCompleted = NO;       // flag to indicated completed square above or below hLine
    
    if (bvl.column > 0) {          // check square left of vline
        
        if (([self.board getHLineStateAtRow:(int)(bvl.row) andColumn:(int)bvl.column-1] != LineStateFree) &&
            ([self.board getHLineStateAtRow:(int)(bvl.row+1) andColumn:(int)bvl.column-1] != LineStateFree) &&
            ([self.board getVLineStateAtRow:(int)(bvl.row) andColumn:(int)bvl.column-1] != LineStateFree))
        {
            [self.board setSquareAtRow:(int)(bvl.row) andColumn:(int)bvl.column-1 toState:self.currentPlayer];
            [self incrementScore];
            squareCompleted = YES;
        }
    }
    
    if (bvl.column < [self.boardCols intValue]) {          // check square right of vline
        if (([self.board getHLineStateAtRow:(int)(bvl.row) andColumn:(int)bvl.column] != LineStateFree)&&
            ([self.board getHLineStateAtRow:(int)(bvl.row+1) andColumn:(int)bvl.column] != LineStateFree)&&
            ([self.board getVLineStateAtRow:(int)(bvl.row) andColumn:(int)bvl.column+1] != LineStateFree))
        {
            [self.board setSquareAtRow:(int)(bvl.row) andColumn:(int)bvl.column toState:self.currentPlayer];
            [self incrementScore];
            squareCompleted = YES;
        }
    }

    return squareCompleted;
}

@end
