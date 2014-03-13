//
//  BoardSquare.m
//  Squares
//
//  Created by Michael Coomey on 3/12/14.
//  Copyright (c) 2014 Michael Coomey. All rights reserved.
//

#import "BoardSquare.h"

@implementation BoardSquare

#define reduction 20

- (id)initWithFrame:(CGRect)frame Column:(NSInteger)column andRow:(NSInteger)row
{
    CGRect reducedFrame = {frame.origin.x+reduction, frame.origin.y+reduction, frame.size.width-2*reduction, frame.size.height-2*reduction};
    self = [super initWithFrame:reducedFrame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
//    CGRect theSquare = {rect.origin.x+20, rect.origin.y+20, rect.size.width-40, rect.size.height-40};
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
//    UIColor * lightGray = [UIColor redColor];
    UIColor * clear = [UIColor clearColor];
    UIColor * red = [UIColor redColor];
    UIColor * blue = [UIColor blueColor];
    
    if (self.stateOfSquare == (LineState) LineStateFree) {
        CGContextSetFillColorWithColor(context, clear.CGColor);
    }
    
    else if (self.stateOfSquare == (LineState) LineStateRed) {
        CGContextSetFillColorWithColor(context, red.CGColor);
    }
    
    else if (self.stateOfSquare == (LineState) LineStateBlue) {
        CGContextSetFillColorWithColor(context, blue.CGColor);
    }
    
    else {
        NSLog(@"Illegal LineState detected");
    }
    
    CGContextFillRect(context, rect);
    
    CGContextRestoreGState(context);
    
}

@end
