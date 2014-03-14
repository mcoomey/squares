//
//  GameBoard.m
//  Squares
//
//  Created by Michael Coomey on 3/10/14.
//  Copyright (c) 2014 Michael Coomey. All rights reserved.
//

#import "GameBoard.h"
#import "BoardVerticalLine.h"
#import "BoardHorizontalLine.h"

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
        NSLog(@"vLines has been instantiated.");
    }
    return _vLines;
}

- (NSMutableArray *) hLines
{
    if (!_hLines) {
        _hLines = [[NSMutableArray alloc]init];
        NSLog(@"hLines has been instantiated.");
    }
    return _hLines;
}

- (void) setVLineAtRow:(int)row andColumn:(int)col toState:(LineState)lstate {
    int idx = row*9+col;
    BoardVerticalLine *bvl = [[BoardVerticalLine alloc]init];
    bvl.row = row;
    bvl.column = col;
    bvl.stateOfLine = lstate;
    [self.vLines replaceObjectAtIndex:idx withObject:bvl];

}

- (void) setHLineAtRow:(int)row andColumn:(int)col toState:(LineState)lstate {
    int idx = col*9+row;
    BoardHorizontalLine *bhl = [[BoardHorizontalLine alloc]init];
    bhl.row = row;
    bhl.column = col;
    bhl.stateOfLine = lstate;
    [self.hLines replaceObjectAtIndex:idx withObject:bhl];
}

- (void) setSquareAtRow:(int)row andColumn:(int)col toState:(LineState)state {
}

@end
