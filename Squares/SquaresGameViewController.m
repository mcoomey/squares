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
#import "LineState.h"

@interface SquaresGameViewController ()
@property (nonatomic, strong) SquaresGame *game;
@property (nonatomic) BOOL playingGame;
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
    
    self.playingGame = NO;                      // wait for user to start the game before playing
    self.linesRemainingLabel.hidden = YES;
    self.currentPlayerLabel.hidden = YES;
    self.resetButton.hidden = YES;
    
    
    // Set action for buttons added by SquaresBoardView
    
    UIView *squaresBoardView = [self.view viewWithTag:1];
    
    //add touch event to each horizontal line and add it to the hLines array
    
    for (BoardHorizontalLine *btn in [squaresBoardView subviews]){
        if ([btn isKindOfClass:[BoardHorizontalLine class]]) {
            [btn addTarget:self action:@selector(hLineTapped:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([btn isKindOfClass:[BoardVerticalLine class]]) {
            [btn addTarget:self action:@selector(vLineTapped:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    // add each boardsquare to the gameboard
    
    for (int row=0; row<NUM_ROWS; row++) {
        for (int col=0; col<NUM_COLS; col++) {
            BoardSquare *bsq = (BoardSquare *)[squaresBoardView viewWithTag:100+row*NUM_COLS+col];
            [self.game.board.squares addObject:bsq];
        }
    }
    
    // reset the hLine and vLine arrays
    
    [self.game.board resetHLines];
    [self.game.board resetVLines];
    
    // call updateScores to fill in initial label values
    
    [self updateScores];
    
}

- (void)hLineTapped: (id) sender
{
    if (self.playingGame) {
        BoardHorizontalLine *bhl = (BoardHorizontalLine *) sender;
        if ([self.game selectHorizontalLine:bhl])   // update scores only if line is newly selected
            [self updateScores];
    }
}

- (void)vLineTapped: (id) sender
{
    if (self.playingGame) {
        BoardVerticalLine *bvl = (BoardVerticalLine *) sender;
        if ([self.game selectVerticalLine:bvl])   // update scores only if line is newly selected
            [self updateScores];
    }
}

- (IBAction)startGame:(id)sender {
    self.playingGame = YES;
    self.startButton.hidden = YES;
    self.resetButton.hidden = NO;
    [self.view endEditing:YES];
    [self updateScores];
}

- (IBAction)requestGameReset:(id)sender {
    
    UIAlertView *resetConfirmation = [[UIAlertView alloc]initWithTitle:@"Reset Confirmation"
                                                               message:@"Reset Game: Are you sure?"
                                                              delegate:self
                                                     cancelButtonTitle:@"No"
                                                     otherButtonTitles:@"Yes", nil];
    [resetConfirmation show];

}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self resetGame];
    }
}

- (void)resetGame {
    
    // reset starting values
    
    self.playingGame = NO;
    self.startButton.hidden = NO;
    self.resetButton.hidden = YES;
    self.linesRemainingLabel.hidden = YES;
    self.currentPlayerLabel.hidden = YES;
    [self.game resetGameValues];
    [self updateScores];
    
    // reset any marked lines or squares
    
    UIView *squaresBoardView = [self.view viewWithTag:1];
    for (BoardHorizontalLine *btn in [squaresBoardView subviews]){
        if (([btn isKindOfClass:[BoardHorizontalLine class]])||([btn isKindOfClass:[BoardVerticalLine class]])) {
            btn.stateOfLine = LineStateFree;
            [btn setNeedsDisplay];
        }
    }
    for (BoardSquare *bsv in [squaresBoardView subviews]){
        if ([bsv isKindOfClass:[BoardSquare class]]) {
            bsv.stateOfSquare = LineStateFree;
            [bsv setNeedsDisplay];
        }
    }
}

// touchesBegan and textFieldShouldReturn will both retire the keyboard

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
        
        if (self.game.linesRemaining == 0) {
            self.playingGame = NO;
            [self.currentPlayerLabel setText:@"Game Over"];
            [self.currentPlayerLabel setTextColor:[UIColor greenColor]];
        }
    }
}

@end
