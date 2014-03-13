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

- (void) setVLineAtRow:(int)row andColumn:(int)col toState:(LineState)state;
- (void) setHLineAtRow:(int)row andColumn:(int)col toState:(LineState)state;
- (void) setSquareAtRos:(int)row andColumn:(int)col toState:(LineState)state;

@end
