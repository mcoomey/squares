//
//  BoardHorizontalLine.m
//  Squares
//
//  Created by Michael Coomey on 3/5/14.
//  Copyright (c) 2014 Michael Coomey. All rights reserved.
//

#import "BoardHorizontalLine.h"
#import "SquaresGameViewController.h"

@implementation BoardHorizontalLine


- (id)initWithFrame:(CGRect)frame Column:(NSInteger)column andRow:(NSInteger)row
{
    _row = row;
    _column = column;
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{
    
    CGPoint point;
    point.x = rect.origin.x;
    point.y = rect.origin.y+10;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor * lightGray = [UIColor lightGrayColor];
    UIColor * red = [UIColor redColor];
    UIColor * blue = [UIColor blueColor];
    
    if (self.stateOfLine == (LineState) LineStateFree) {
        CGContextSetStrokeColorWithColor(context, lightGray.CGColor);
        CGContextSetLineWidth(context, 2.0);
    }
    
    else if (self.stateOfLine == (LineState) LineStateRed) {
        CGContextSetStrokeColorWithColor(context, red.CGColor);
        CGContextSetLineWidth(context, 4.0);
    }
    
    else if (self.stateOfLine == (LineState) LineStateBlue) {
        CGContextSetStrokeColorWithColor(context, blue.CGColor);
        CGContextSetLineWidth(context, 4.0);
    }
    
    else {
        NSLog(@"Illegal LineState detected");
    }
    
    CGContextSetLineCap(context, kCGLineCapRound);
    
    
    CGContextMoveToPoint(context, point.x, point.y);
    CGContextAddLineToPoint(context, rect.size.width, point.y);
    CGContextStrokePath(context);
}


@end
