//
//  GameBoard.h
//  Squares
//
//  Created by Michael Coomey on 3/10/14.
//  Copyright (c) 2014 Michael Coomey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LineState.h"


@interface GameBoard : NSObject

@property (nonatomic, strong) NSMutableArray *squares;
@property (nonatomic, strong) NSMutableArray *vLines;
@property (nonatomic, strong) NSMutableArray *hLines;
- (GameBoard *) initWithNumRows:(int)rows andNumCols:(int)cols;

- (void) setVLineAtRow:(int)row andColumn:(int)col toState:(LineState)lstate;
- (void) setHLineAtRow:(int)row andColumn:(int)col toState:(LineState)lstate;
- (void) setSquareAtRow:(int)row andColumn:(int)col toState:(LineState)lstate;
- (int) getVLineStateAtRow:(int)row andColumn:(int)col;
- (int) getHLineStateAtRow:(int)row andColumn:(int)col;
@end
