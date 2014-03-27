//
//  GameBoard.m
//  Squares
//
//  Created by Michael Coomey on 3/10/14.
//  Copyright (c) 2014 Michael Coomey. All rights reserved.
//

#import "LineState.h"
#import "GameBoard.h"
#import "BoardSquare.h"
#import "BoardHorizontalLine.h"
#import "BoardVerticalLine.h"

@interface GameBoard()

@property NSNumber *boardRows;
@property NSNumber *boardCols;

@end

@implementation GameBoard

- (id)init
{
    self = [super init];
    if (self) {
        
        NSLog(@"GameBoard has been instantiated.");
    }
    return self;
}

- (GameBoard *) initWithNumRows:(int)rows andNumCols:(int)cols{
    self = [super init];
    if (self) {
        self.boardRows = [NSNumber numberWithInt:rows];
        self.boardCols = [NSNumber numberWithInt:cols];
        NSLog(@"GameBoard has been instantiated.");
    }
    return self;
}


- (void) setVLineAtRow:(int)row andColumn:(int)col toState:(LineState)lstate
{
    int idx = row * ([self.boardCols intValue]+1) + col;
    [self.vLines replaceObjectAtIndex:idx withObject:[NSNumber numberWithInt:lstate]];
}

- (void) setHLineAtRow:(int)row andColumn:(int)col toState:(LineState)lstate
{
    int idx = row * [self.boardCols intValue] + col;
    [self.hLines replaceObjectAtIndex:idx withObject:[NSNumber numberWithInt:lstate]];
}


- (int) getVLineStateAtRow:(int)row andColumn:(int)col
{
    int idx = row * ([self.boardCols intValue]+1) + col;
    int value = [[self.vLines objectAtIndex:idx] intValue];
    return value;
}


- (int) getHLineStateAtRow:(int)row andColumn:(int)col
{
    int idx = row * [self.boardCols intValue] + col;
    int value = [[self.hLines objectAtIndex:idx] intValue];
    return value;
    
}


- (void) setSquareAtRow:(int)row andColumn:(int)col toState:(LineState)state
{
    unsigned long idx = row * [self.boardCols intValue] + col;
    BoardSquare *bsq = [self.squares objectAtIndex:idx];
    [bsq setStateOfSquare:state];
    [bsq setNeedsDisplay];
    [self.squares replaceObjectAtIndex:idx withObject:bsq];

}


@end
