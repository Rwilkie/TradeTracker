//
//  LoginViewController.m
//  TrackMyTrades
//
//  Created by Wilkie, Rich on 3/14/14.
//  Copyright (c) 2014 Rich Wilkie. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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

  [self.logInView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_landscape"]]];

  // Set field text color
  [self.logInView.usernameField setBackground:[UIImage imageNamed:@"text-input"]];
  [self.logInView.passwordField setBackground:[UIImage imageNamed:@"text-input"]];
  [self.logInView.usernameField setTextColor:[UIColor whiteColor]];
  [self.logInView.passwordField setTextColor:[UIColor whiteColor]];

}

@end
