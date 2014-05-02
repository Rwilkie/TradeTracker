//
//  SignUpViewController.m
//  TrackMyTrades
//
//  Created by Wilkie, Rich on 3/14/14.
//  Copyright (c) 2014 Rich Wilkie. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}
- (void)viewDidLoad
{
  [super viewDidLoad];

  //  self.logInView.logo = label; // logo can be any UIView

  [self.signUpView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_landscape"]]];

  // Set field text color
  [self.signUpView.usernameField setBackground:[UIImage imageNamed:@"text-input"]];
  [self.signUpView.passwordField setBackground:[UIImage imageNamed:@"text-input"]];
  [self.signUpView.emailField setBackground:[UIImage imageNamed:@"text-input"]];
  [self.signUpView.usernameField setTextColor:[UIColor whiteColor]];
  [self.signUpView.passwordField setTextColor:[UIColor whiteColor]];
  [self.signUpView.emailField setTextColor:[UIColor whiteColor]];

}

@end
