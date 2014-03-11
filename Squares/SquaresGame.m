//
//  SquaresGame.m
//  Squares
//
//  Created by Michael Coomey on 3/5/14.
//  Copyright (c) 2014 Michael Coomey. All rights reserved.
//

#import "SquaresGame.h"


@interface SquaresGame()

@end

@implementation SquaresGame

-(SquaresGame*) init {

    self = [super init];
    if (self) {
        
        NSLog(@"Game has been instantiated.");

    }
    return self;
}

-(void)selectHorizontalLine:(BoardHorizontalLine*)bhl {
    if ([bhl stateOfLine] == (LineState)LineStateFree) {
        NSLog(@"hLine tapped at row= %lu and column = %lu ", (unsigned long)bhl.row, (unsigned long)bhl.column);
        [bhl setStateOfLine:(LineState) LineStateRed];
        [bhl setNeedsDisplay];
    }

}

-(void)selectVerticalLine:(BoardVerticalLine*)bvl {
    if ([bvl stateOfLine] == (LineState)LineStateFree) {
        NSLog(@"vLine tapped at row= %lu and column = %lu ", (unsigned long)bvl.row, (unsigned long)bvl.column);
        [bvl setStateOfLine:(LineState) LineStateBlue];
        [bvl setNeedsDisplay];
    }

}


@end
