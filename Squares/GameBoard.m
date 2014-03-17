//
//  GameBoard.m
//  Squares
//
//  Created by Michael Coomey on 3/10/14.
//  Copyright (c) 2014 Michael Coomey. All rights reserved.
//

#import "GameConstants.h"
#import "LineState.h"
#import "GameBoard.h"
#import "BoardSquare.h"

@implementation GameBoard

- (id)init
{
    self = [super init];
    if (self) {
        
        NSLog(@"GameBoard has been instantiated.");
    }
    return self;
}

- (NSMutableArray *) squares
{
    if (!_squares) {
        _squares = [[NSMutableArray alloc]init];
       NSLog(@"squares has been instantiated.");
    }
    return _squares;
}

- (NSMutableArray *) vLines
{
    if (!_vLines) {
        _vLines = [[NSMutableArray alloc]init];
        LineState ls = LineStateFree;
        // init the vLines array with the correct number of vals to hold all the vertical lines
        for (int idx=0; idx < (NUM_COLS+1)*NUM_ROWS; idx++) {
            [_vLines addObject:[NSNumber numberWithInt:ls]];
        }
        NSLog(@"vLines has been instantiated.");
    }
    return _vLines;
}

- (NSMutableArray *) hLines
{
    if (!_hLines) {
        _hLines = [[NSMutableArray alloc]init];
        LineState ls = LineStateFree;
        // init the hLines array with the correct number of vals to hold all the horizontal lines
        for (int idx=0; idx < (NUM_ROWS+1)*NUM_COLS; idx++) {
            [_hLines addObject:[NSNumber numberWithInt:ls]];
        }
        NSLog(@"hLines has been instantiated.");
    }
    return _hLines;
}

// reset the hLines
-(void) resetHLines {
    LineState ls = LineStateFree;
    for (int idx=0; idx < (NUM_ROWS+1)*NUM_COLS; idx++) {
        [self.hLines replaceObjectAtIndex:idx withObject:[NSNumber numberWithInt:ls]];
    }
}

// reset the vLines
-(void) resetVLines {
    LineState ls = LineStateFree;
    for (int idx=0; idx < (NUM_COLS+1)*NUM_ROWS; idx++){
        [self.vLines replaceObjectAtIndex:idx withObject:[NSNumber numberWithInt:ls]];
    }
}

// reset the squares
-(void) resetSquares {
    BoardSquare *bsq = [[BoardSquare alloc]init];
    [bsq setStateOfSquare:LineStateFree];
    for (int idx=0; idx < (NUM_COLS * NUM_ROWS); idx++) {
        [self.squares replaceObjectAtIndex:idx withObject:bsq];
    }
}


- (void) setVLineAtRow:(int)row andColumn:(int)col toState:(LineState)lstate
{
}

- (void) setHLineAtRow:(int)row andColumn:(int)col toState:(LineState)lstate
{
}

- (void) setSquareAtRow:(int)row andColumn:(int)col toState:(LineState)state
{
}
- (LineState) getVLineStateAtRow:(int)row andColumn:(int)col
{
    return LineStateFree;   // debug *******
}
- (LineState) getHLineStateAtRow:(int)row andColumn:(int)col
{
    return LineStateFree;   // debug *******
}
- (LineState) getSquareStateAtRow:(int)row andColumn:(int)col
{
    return LineStateFree;   // debug *******
}

@end
