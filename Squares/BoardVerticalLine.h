//
//  BoardVerticalLine.h
//  Squares
//
//  Created by Michael Coomey on 3/5/14.
//  Copyright (c) 2014 Michael Coomey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineState.h"

@interface BoardVerticalLine : UIButton 
@property (nonatomic) NSUInteger row;
@property (nonatomic) NSUInteger column;
@property (nonatomic) LineState stateOfLine;

- (id)initWithFrame:(CGRect)frame Column:(NSInteger)column andRow:(NSInteger)row;

@end
