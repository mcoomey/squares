//
//  SquaresGame.m
//  Squares
//
//  Created by Michael Coomey on 3/5/14.
//  Copyright (c) 2014 Michael Coomey. All rights reserved.
//

#import "SquaresGame.h"
#import "GameBoard.h"


@implementation SquaresGame



// initialize the game
-(SquaresGame*) init {

    self = [super init];
    if (self) {
        self.player1Score = 0;
        self.player2Score = 0;
        self.currentPlayer = LineStateRed;
        NSLog(@"Game has been instantiated.");
        self.board = [[GameBoard alloc] init];
    }
    return self;
}

-(void)selectHorizontalLine:(BoardHorizontalLine*)bhl {
    if ([bhl stateOfLine] == (LineState)LineStateFree) {
        [bhl setStateOfLine:self.currentPlayer];
        [self.board setHLineAtRow:(int)bhl.row andColumn:(int)bhl.column toState:self.currentPlayer];
        NSLog(@"hLine tapped at row= %lu and column = %lu ", (unsigned long)bhl.row, (unsigned long)bhl.column);
        [bhl setNeedsDisplay];
        
        [self togglePlayer];
    }

}

-(void)selectVerticalLine:(BoardVerticalLine*)bvl {
    if ([bvl stateOfLine] == (LineState)LineStateFree) {
        [bvl setStateOfLine:self.currentPlayer];
        [self.board setVLineAtRow:(int)bvl.row andColumn:(int)bvl.column toState:self.currentPlayer];
        NSLog(@"vLine tapped at row= %lu and column = %lu ", (unsigned long)bvl.row, (unsigned long)bvl.column);
        [bvl setNeedsDisplay];

        [self togglePlayer];
    }

}

- (void) togglePlayer {
    self.currentPlayer = (self.currentPlayer == LineStateRed) ? LineStateBlue : LineStateRed;
}

@end
