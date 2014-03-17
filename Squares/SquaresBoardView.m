//
//  SquaresBoardView.m
//  Squares
//
//  Created by Michael Coomey on 3/5/14.
//  Copyright (c) 2014 Michael Coomey. All rights reserved.
//

#import "GameConstants.h"
#import "SquaresBoardView.h"


@implementation SquaresBoardView


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        // Initialization code
        float rowHeight = (self.frame.size.height-20) / (float)NUM_ROWS;
        float columnWidth = (self.frame.size.width-20) / (float)NUM_COLS;
        
        for (int row = 0; row < NUM_ROWS+1; row++)
        {
            for (int col = 0; col < NUM_COLS; col++)
            {
                // add the horizontal lines
                BoardHorizontalLine *hLine = [[BoardHorizontalLine alloc]initWithFrame:CGRectMake(col*columnWidth+10, row*rowHeight, columnWidth, 20)
                                                                                Column:col
                                                                                andRow:row  ];
                [self addSubview:hLine];
            }
        }
        
        for (int row = 0; row < NUM_ROWS; row++)
        {
            for (int col = 0; col < NUM_COLS+1; col++)
            {
                // add the vertical lines
                BoardVerticalLine *vLine = [[BoardVerticalLine alloc]initWithFrame:CGRectMake(col*columnWidth, row*rowHeight+10, 20, rowHeight)
                                                                            Column:col
                                                                            andRow:row ];
                [self addSubview:vLine];
            }
        }
        
        NSUInteger tagidx=100;
        
        for (int row = 0; row < NUM_ROWS; row++)
        {
            for (int col = 0; col < NUM_COLS; col++)
            {
                // add the grid of squares
                BoardSquare *bSquare = [[BoardSquare alloc]initWithFrame:CGRectMake(col*columnWidth+10, row*rowHeight+10, columnWidth, rowHeight)
                                                                  Column:col
                                                                  andRow:row ];
                [bSquare setTag: tagidx++];
                [self addSubview:bSquare];
            }
        }
        
    }
    
    return self;
    
}

@end
