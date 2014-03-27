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
@property NSArray *boardSizes;
@property UIView *squaresBoardView;
@property UIView *boardSizeSlider;
@property UIScrollView *scrollView;
@end

@implementation SquaresGameViewController


//************* viewDidLoad - load the initial view upon invocation ************//

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // wait for user to press "start" before playing
    self.playingGame = NO;
    
    
    // set up initial visibilities
    
    self.resetButton.hidden = YES;
    self.linesRemainingLabel.hidden = YES;
    self.currentPlayerLabel.hidden = YES;
    
    self.startButton.hidden = NO;
    self.squaresBoardView.hidden = NO;
    self.boardSizeSlider.hidden = NO;
    
    
    // get pointer to the scroll view to scroll for keyboard display
    
    self.scrollView = (UIScrollView*)[self.view viewWithTag:99];
    
    // Get pointer to the squares view and make sure it's visible
    
    self.squaresBoardView = [self.view viewWithTag:1];
    [self.squaresBoardView setHidden:NO];
    
    
    // Get pointer to the board size slider and make sure it's visible
    
    self.boardSizeSlider = [self.view viewWithTag:2];
    [self.boardSizeSlider setHidden:NO];
    
    
    // get current board size from the slider
    
    int current_size = (int) [self.sizeSlider value];
    self.boardRows = [NSNumber numberWithInt:current_size];
    self.boardCols = [NSNumber numberWithInt:current_size];
    
    
    // build the gameboard by drawing on the squaresBoardView
    
    [self buildGameBoard];
}


//************* sliderValueChanged - monitor the slider to change the board size ************//

- (IBAction)sliderValueChanged:(UISlider *)sender
{
    
    int val = (int)[sender value];
    if (val != [self.boardRows intValue]) {
        self.boardRows = [NSNumber numberWithInt:val];
        self.boardCols = [NSNumber numberWithInt:val];
        
        // display the game board
        
        [self buildGameBoard];
    }
}


//************* buildGameBoard - add the view components to the screen ************//

- (void) buildGameBoard
{
    
    // remove old content in case board size has changed
    
    [[self.squaresBoardView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // Calculate row and column height
    float rowHeight = (self.squaresBoardView.frame.size.height-20) / (float)[self.boardRows intValue];
    float columnWidth = (self.squaresBoardView.frame.size.width-20) / (float)[self.boardCols intValue];
    
    
    // add the horizontal lines
    
    for (int row = 0; row < [self.boardRows intValue]+1; row++)
    {
        for (int col = 0; col < [self.boardCols intValue]; col++)
        {
            BoardHorizontalLine *hLine = [[BoardHorizontalLine alloc]initWithFrame:CGRectMake(col*columnWidth+10, row*rowHeight, columnWidth, 20) Column:col andRow:row  ];
            [self.squaresBoardView addSubview:hLine];
        }
    }
    
    
    // add the vertical lines
    
    for (int row = 0; row < [self.boardRows intValue]; row++)
    {
        for (int col = 0; col < [self.boardCols intValue]+1; col++)
        {
            BoardVerticalLine *vLine = [[BoardVerticalLine alloc]initWithFrame:CGRectMake(col*columnWidth, row*rowHeight+10, 20, rowHeight) Column:col andRow:row ];
            [self.squaresBoardView addSubview:vLine];
        }
    }
    
    
    // add the grid of squares and tag them starting at 100
    
    NSUInteger tagidx=100;
    
    for (int row = 0; row < [self.boardRows intValue]; row++)
    {
        for (int col = 0; col < [self.boardCols intValue]; col++)
        {
            BoardSquare *bSquare = [[BoardSquare alloc]initWithFrame:CGRectMake(col*columnWidth+10, row*rowHeight+10, columnWidth, rowHeight) Column:col andRow:row ];
            [bSquare setTag: tagidx++];
            [self.squaresBoardView addSubview:bSquare];
        }
    }
    
    
    //add touch event to each horizontal and vertical line
    
    for (BoardHorizontalLine *btn in [self.squaresBoardView subviews]){
        if ([btn isKindOfClass:[BoardHorizontalLine class]]) {
            [btn addTarget:self action:@selector(hLineTapped:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if ([btn isKindOfClass:[BoardVerticalLine class]]) {
            [btn addTarget:self action:@selector(vLineTapped:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
}


//************* hLineTapped - select the horizontal line & update score ************//

- (void)hLineTapped: (id) sender
{
    NSLog(@"hLine tapped");
    if (self.playingGame) {
        BoardHorizontalLine *bhl = (BoardHorizontalLine *) sender;
        if ([self.game selectHorizontalLine:bhl])   // update scores only if line is newly selected
            [self updateScores];
    }
}



//************* vLineTapped - select the vertical line & update score ************//

- (void)vLineTapped: (id) sender
{
    NSLog(@"vLine tapped");
    if (self.playingGame) {
        BoardVerticalLine *bvl = (BoardVerticalLine *) sender;
        if ([self.game selectVerticalLine:bvl])   // update scores only if line is newly selected
            [self updateScores];
    }
}


//************* startGame - init starting values & enable the game to be played ************//

- (IBAction)startGame:(id)sender
{
    
    // instantiate a new game
    
    self.game = [[SquaresGame alloc] initWithNumRows:[self.boardRows intValue] andNumCols:[self.boardCols intValue]];
    NSLog(@"game has been instantiated.");

    
    // instantiate the vertical lines array on the game board
    
    self.game.board.vLines = [[NSMutableArray alloc]init];
    // init the vLines array with the correct number of vals to hold all the vertical lines
    for (int idx=0; idx < ([self.boardCols intValue]+1)*[self.boardRows intValue]; idx++) {
        [self.game.board.vLines addObject:[NSNumber numberWithInt:LineStateFree]];
    }
    NSLog(@"vLines has been instantiated.");
    
    
    // instantiate the horizontal lines array on the game board

    self.game.board.hLines = [[NSMutableArray alloc]init];
    // init the hLines array with the correct number of vals to hold all the horizontal lines
    for (int idx=0; idx < ([self.boardRows intValue]+1)*[self.boardCols intValue]; idx++) {
        [self.game.board.hLines addObject:[NSNumber numberWithInt:LineStateFree]];
    }
    NSLog(@"hLines has been instantiated.");

    
    // instantiate the squares array on the game board
    
    self.game.board.squares = [[NSMutableArray alloc]init];
    // add all the squares to the array
    for (int row=0; row<[self.boardRows intValue]; row++) {
        for (int col=0; col<[self.boardCols intValue]; col++) {
            BoardSquare *bsq = (BoardSquare *)[self.squaresBoardView viewWithTag:100+row*[self.boardCols intValue]+col];
            [self.game.board.squares addObject:bsq];
        }
    }
    
    NSLog(@"squares has been instantiated.");


    // set visibility to play the game

    self.startButton.hidden = YES;
    self.resetButton.hidden = NO;
    self.boardSizeSlider.hidden = YES;
    self.currentPlayerLabel.hidden = NO;

    // hide the keyboard if it's showing
    [self.view endEditing:YES];
    
    //update the player names and scores labels
    self.game.currentPlayer = LineStateRed;
    [self updateScores];
    
    // play!
    self.playingGame = YES;
}


//************* requestGameReset - process request from user to reset the game ************//

- (IBAction)requestGameReset:(id)sender {
    
    // if game is over then just do the reset
    
    if (self.game.linesRemaining == 0)
        [self resetGame];
    
    // otherwise, display the reset dialog confirmation
    
    else {
        UIAlertView *resetConfirmation = [[UIAlertView alloc]initWithTitle:@"Reset Confirmation"
                                                                   message:@"Reset Game: Are you sure?"
                                                                  delegate:self
                                                         cancelButtonTitle:@"No"
                                                         otherButtonTitles:@"Yes", nil];
        [resetConfirmation show];
    }
}


//************* alertView - check for user confirmation before game reset ************//

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self resetGame];
    }
}


//************* resetGame - reset the game currently in progress ************//

- (void)resetGame {

    // stop playing the game
    
    self.playingGame = NO;
    
    
    // zero out the scores
    
    self.game.player1Score = 0;
    self.game.player2Score = 0;
    [self updateScores];
    
    
    // build a new gameboard
    
    [self buildGameBoard];
    
    
    // set up initial visibilities
    
    self.resetButton.hidden = YES;
    self.linesRemainingLabel.hidden = YES;
    self.currentPlayerLabel.hidden = YES;
    
    self.startButton.hidden = NO;
    self.squaresBoardView.hidden = NO;
    self.boardSizeSlider.hidden = NO;

}


//************* touchesBegan and textFieldShouldReturn will both retire the keyboard ************//

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

//************* updateScores - init starting values & enable the game to be played ************//

- (void)updateScores
{
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

//************************ scroll the view when keyboard is displayed ***************************//

- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)deregisterFromKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self deregisterFromKeyboardNotifications];
    
    [super viewWillDisappear:animated];
    
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    NSString *msg = [[NSString alloc]init];
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
            msg = @"Landscape Left";
            break;
        case UIInterfaceOrientationLandscapeRight:
            msg = @"Landscape Right";
            break;
        case UIInterfaceOrientationPortrait:
            msg = @"Portrait";
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            msg = @"Portrait UpsideDown";
            break;
        default:
            msg = @"Unknown";
            break;
    }
    NSLog(@"about to rotate to %@", msg);
}


- (void)keyboardWasShown:(NSNotification *)notification {
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        NSDictionary* info = [notification userInfo];
        CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        
        // in landscape mode the kb heigth and width are swapped
        CGPoint scrollPoint = CGPointMake(0.0, keyboardSize.width);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
}

@end
