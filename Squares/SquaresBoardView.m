//
//  SquaresBoardView.m
//  Squares
//
//  Created by Michael Coomey on 3/5/14.
//  Copyright (c) 2014 Michael Coomey. All rights reserved.
//

#import "SquaresGameViewController.h"
#import "SquaresBoardView.h"

#import "BoardHorizontalLine.h"
#import "BoardVerticalLine.h"
#import "BoardSquare.h"


@implementation SquaresBoardView

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        // Initialization code
        float rowHeight = (self.frame.size.height-20) / 8.0;
        float columnWidth = (self.frame.size.width-20) / 8.0;
        int tag = 100;
        
        for (int col = 0; col < 8; col++)
        {
            for (int row = 0; row < 9; row++)
            {
                // add the 8 x 8 grid of squares
                if (row < 8) {
                    BoardSquare *bSquare = [[BoardSquare alloc]initWithFrame:CGRectMake(col*columnWidth+10, row*rowHeight+10, columnWidth, rowHeight)
                                                                      Column:col
                                                                      andRow:row ];
                    [self addSubview:bSquare];
                }
                
                // add the horizontal lines
                BoardHorizontalLine *hLine = [[BoardHorizontalLine alloc]initWithFrame:CGRectMake(col*columnWidth+10, row*rowHeight, columnWidth, 20)
                                                                                Column:col
                                                                                andRow:row  ];
                [hLine setTag:tag];
                [self addSubview:hLine];
                tag++;
                
                // add the vertical lines
                BoardVerticalLine *vLine = [[BoardVerticalLine alloc]initWithFrame:CGRectMake(row*columnWidth, col*rowHeight+10, 20, rowHeight)
                                                                            Column:row
                                                                            andRow:col ];
                [vLine setTag:tag];
                [self addSubview:vLine];
                tag++;
                
            }
        }
    }
    
    return self;
    
}

@end
