//
//  BoardSquare.h
//  Squares
//
//  Created by Michael Coomey on 3/12/14.
//  Copyright (c) 2014 Michael Coomey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineState.h"

@interface BoardSquare : UIView
@property (nonatomic) LineState stateOfSquare;

- (id)initWithFrame:(CGRect)frame Column:(NSInteger)column andRow:(NSInteger)row;

@end
