//
//  SquaresGameViewController.m
//  Squares
//
//  Created by Michael Coomey on 3/4/14.
//  Copyright (c) 2014 Michael Coomey. All rights reserved.
//

#import "SquaresGameViewController.h"
#import "SquaresBoardView.h"
#import "BoardVerticalLine.h"
#import "BoardHorizontalLine.h"
#import "SquaresGame.h"

@interface SquaresGameViewController ()
@property (nonatomic, strong) SquaresGame *game;
@property (strong, nonatomic) NSMutableArray *verticalLines;
@property (strong, nonatomic) NSMutableArray *horizontalLines;
@property (weak, nonatomic) IBOutlet UILabel *RedPlayerScore;
@property (weak, nonatomic) IBOutlet UILabel *BluePlayerScore;

@end

@implementation SquaresGameViewController

- (SquaresGame *) game
{
    if (!_game) {
        _game = [[SquaresGame alloc] init];
        NSLog(@"Game has been instantiated.");
    }
    return _game;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.horizontalLines = [[NSMutableArray alloc] init];
    self.verticalLines = [[NSMutableArray alloc] init];
    
    for (UIView *vw in [self.view subviews]){
        if ([vw isKindOfClass:[SquaresBoardView class]]) {
            for (UIButton *btn in [vw subviews]){
                if ([btn isKindOfClass:[BoardHorizontalLine class]]) {
                    [btn addTarget:self action:@selector(hLineTapped:) forControlEvents:UIControlEventTouchUpInside];
                    [self.horizontalLines addObject:btn];
                }
                else if ([btn isKindOfClass:[BoardVerticalLine class]]) {
                    [btn addTarget:self action:@selector(vLineTapped:) forControlEvents:UIControlEventTouchUpInside];
                    [self.verticalLines addObject:btn];

                }
            }

        }
    }
}

- (void)hLineTapped: (id) sender
{
    BoardHorizontalLine *bhl = (BoardHorizontalLine *) sender;
    if ([bhl stateOfLine] == (LineState)LineStateFree) {
        NSLog(@"hLine tapped at row= %lu and column = %lu ", (unsigned long)bhl.row, (unsigned long)bhl.column);
        [bhl setStateOfLine:(LineState) LineStateRed];
        [bhl setNeedsDisplay];
    }
}

- (void)vLineTapped: (id) sender
{
    BoardVerticalLine *bvl = (BoardVerticalLine *) sender;
    if ([bvl stateOfLine] == (LineState)LineStateFree) {
        NSLog(@"vLine tapped at row= %lu and column = %lu ", (unsigned long)bvl.row, (unsigned long)bvl.column);
       [bvl setStateOfLine:(LineState) LineStateBlue];
        [bvl setNeedsDisplay];
    }
}



@end
