//
//  GameBoard.h
//  Squares
//
//  Created by Michael Coomey on 3/10/14.
//  Copyright (c) 2014 Michael Coomey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameConstants.h"
#import "LineState.h"


@interface GameBoard : NSObject

@property (nonatomic, strong) NSMutableArray *squares;
@property (nonatomic, strong) NSMutableArray *vLines;
@property (nonatomic, strong) NSMutableArray *hLines;
- (void) setVLineAtRow:(int)row andColumn:(int)col toState:(LineState)lstate;
- (void) setHLineAtRow:(int)row andColumn:(int)col toState:(LineState)lstate;
- (void) setSquareAtRow:(int)row andColumn:(int)col toState:(LineState)lstate;
//- (LineState) getVLineStateAtRow:(int)row andColumn:(int)col;
//- (LineState) getHLineStateAtRow:(int)row andColumn:(int)col;
//- (LineState) getSquareStateAtRow:(int)row andColumn:(int)col;
@end
