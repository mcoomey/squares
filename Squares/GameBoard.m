//
//  GameBoard.m
//  Squares
//
//  Created by Michael Coomey on 3/10/14.
//  Copyright (c) 2014 Michael Coomey. All rights reserved.
//

#import "GameBoard.h"

@implementation GameBoard
{
    LineState _vLineState[9][8];
    LineState _hLineState[8][9];
    LineState _gridState[8][8];
}

- (id)init
{
    self = [super init];
    if (self) {
        [self clearBoard];
    }
    return self;
}

- (void) clearBoard {
    for (int r=0; r<9; r++) {
        for (int c=0; c<8; c++) {
            _vLineState[r][c] = (LineState)LineStateFree;
        }
    }
    for (int r=0; r<8; r++) {
        for (int c=0; c<9; c++) {
            _hLineState[r][c] = (LineState)LineStateFree;
        }
    }
    for (int r=0; r<8; r++) {
        for (int c=0; c<8; c++) {
            _gridState[r][c] = (LineState)LineStateFree;
        }
    }
}
@end
