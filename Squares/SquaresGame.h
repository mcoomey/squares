//
//  SquaresGame.h
//  Squares
//
//  Created by Michael Coomey on 3/5/14.
//  Copyright (c) 2014 Michael Coomey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoardHorizontalLine.h"
#import "BoardVerticalLine.h"

@interface SquaresGame : NSObject

@property (nonatomic, readwrite) NSUInteger player1Score;
@property (nonatomic, readwrite) NSUInteger player2Score;

-(void)selectHorizontalLine:(BoardHorizontalLine*)bhl;
-(void)selectVerticalLine:(BoardVerticalLine*)bvl;
@end
