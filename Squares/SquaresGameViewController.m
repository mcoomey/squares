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
#import "GameBoard.h"

@interface SquaresGameViewController ()
@property (nonatomic, strong) SquaresGame *game;
@property (nonatomic, strong) GameBoard *board;
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
    }
    return _game;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.horizontalLines = [[NSMutableArray alloc] init];
    self.verticalLines = [[NSMutableArray alloc] init];
    
    // Set action for buttons added by SquaresBoardView
    
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
    
    // reset scores to zero
    
    [_game setPlayer1Score:0];
    [_game setPlayer2Score:0];
    
    // instantiate and initialize game board
    
    _board = [[GameBoard alloc] init];
    
}

- (void)hLineTapped: (id) sender
{
    BoardHorizontalLine *bhl = (BoardHorizontalLine *) sender;
    [self.game selectHorizontalLine:bhl];
    NSUInteger val= [self.game player1Score] + 1;
    [self.game setPlayer1Score:val];
    NSString *score = [NSString stringWithFormat:@"%i", self.game.player1Score];
    [self.RedPlayerScore setText:score];
}

- (void)vLineTapped: (id) sender
{
    BoardVerticalLine *bvl = (BoardVerticalLine *) sender;
    [self.game selectVerticalLine:bvl];
    [self.game setPlayer2Score:self.game.player2Score++];
    NSString *score = [NSString stringWithFormat:@"%i", self.game.player2Score];
    [self.BluePlayerScore setText:score];
}



@end
