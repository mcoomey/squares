//
//  SquaresGameViewController.h
//  Squares
//
//  Created by Michael Coomey on 3/4/14.
//  Copyright (c) 2014 Michael Coomey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SquaresGameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *player1ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *player2ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *linesRemainingLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPlayerLabel;
@property (weak, nonatomic) IBOutlet UITextField *player1Name;
@property (weak, nonatomic) IBOutlet UITextField *player2Name;
@end
