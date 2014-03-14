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
@property (nonatomic) BOOL playingGame;
@end

@implementation SquaresGameViewController

- (IBAction)startGame:(id)sender {
    self.playingGame = YES;
    UIButton *btn = (UIButton *) sender;
    btn.hidden = YES;
    [self.view endEditing:YES];
    [self updateScores];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

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
    
    // wait for user to start the game before playing
    self.playingGame = NO;
    self.linesRemainingLabel.hidden = YES;
    self.currentPlayerLabel.hidden = YES;
    
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
    if (self.playingGame) {
    BoardHorizontalLine *bhl = (BoardHorizontalLine *) sender;
    if ([self.game selectHorizontalLine:bhl])
        [self updateScores];
    }
}

- (void)vLineTapped: (id) sender
{
    if (self.playingGame) {
    BoardVerticalLine *bvl = (BoardVerticalLine *) sender;
    if ([self.game selectVerticalLine:bvl])
        [self updateScores];
    }
}

- (void)updateScores
{
    if (self.playingGame) {
        
        NSString *player1Name = [[self player1Name] text];
        NSString *player2Name = [[self player2Name] text];
        
        if ([player1Name length] == 0) {
            player1Name = @"Player 1";
        }
        
        if ([player2Name length] == 0) {
            player2Name = @"Player 2";
        }
        
        NSString *cpl = [[NSString alloc] init];
        if (self.game.currentPlayer == LineStateRed) {
            cpl = [NSString stringWithFormat:@"%@'s turn", player1Name];
            self.currentPlayerLabel.textColor = [UIColor redColor];
        }
        else {
            cpl = [NSString stringWithFormat:@"%@'s turn", player2Name];
            self.currentPlayerLabel.textColor = [UIColor blueColor];
        }
        [self.currentPlayerLabel setText:cpl];
        self.currentPlayerLabel.hidden = NO;

        self.linesRemainingLabel.text = [NSString stringWithFormat:@"%lu Lines Remaining", (unsigned long)[self.game linesRemaining]];
        self.linesRemainingLabel.hidden = NO;
        
        self.player1ScoreLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)[self.game player1Score]];
        self.player2ScoreLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)[self.game player2Score]];
    }
}

@end
