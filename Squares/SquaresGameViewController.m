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
#import "BoardSquare.h"
#import "SquaresGame.h"
#import "GameBoard.h"

@interface SquaresGameViewController ()
@property (nonatomic, strong) SquaresGame *game;
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
    
    // Set action for buttons added by SquaresBoardView
    
    for (UIView *vw in [self.view subviews]){
        if ([vw isKindOfClass:[SquaresBoardView class]]) {
            for (BoardHorizontalLine *btn in [vw subviews]){
                if ([btn isKindOfClass:[BoardHorizontalLine class]]) {
                    [btn addTarget:self action:@selector(hLineTapped:) forControlEvents:UIControlEventTouchUpInside];
                    [self.game.board.hLines addObject:btn];
                }
                else if ([btn isKindOfClass:[BoardVerticalLine class]]) {
                    [btn addTarget:self action:@selector(vLineTapped:) forControlEvents:UIControlEventTouchUpInside];
                    [self.game.board.vLines addObject:btn];

                }
            }
            for (UIView *bsv in [vw subviews]){
                if ([bsv isKindOfClass:[BoardSquare class]]) {
                    [self.game.board.squares addObject:bsv];
                }
            }

        }
    }
    [self updateScores];
    
}

- (void)hLineTapped: (id) sender
{
    BoardHorizontalLine *bhl = (BoardHorizontalLine *) sender;
    if ([self.game selectHorizontalLine:bhl])
        [self updateScores];
}

- (void)vLineTapped: (id) sender
{
    BoardVerticalLine *bvl = (BoardVerticalLine *) sender;
    if ([self.game selectVerticalLine:bvl])
        [self updateScores];
}

- (void)updateScores
{
    self.linesRemainingLabel.text = [NSString stringWithFormat:@"%lu Lines Remaining", (unsigned long)[self.game linesRemaining]];
    self.player1ScoreLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)[self.game player1Score]];
    self.player2ScoreLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)[self.game player2Score]];
}

@end
