//
//  MasterViewController.m
//  gunmetal
//
//  Created by Valentin on 5/13/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//



#import "MasterViewController.h"
#import "AccountCell.h"
#import "AppDelegate.h"
#import "Utils.h"

#import <Parse/Parse.h>
#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "KeychainItemWrapper.h"
#import "AppData.h"
#import "BlockAlertView.h"

@implementation MasterViewController

@synthesize masterTableView, delegate;

@synthesize models;

#pragma mark - View lifecycle

- (void)viewDidLoad {
  self.title = @"Items";

  UIImage *navBarImage = [UIImage tallImageNamed:@"menubar-7.png"];

  [self.navigationController.navigationBar setBackgroundImage:navBarImage
                                                forBarMetrics:UIBarMetricsDefault];

  masterTableView.delegate = self;
  masterTableView.dataSource = self;

  UIColor* bgColor = [UIColor colorWithPatternImage:[UIImage tallImageNamed:@"bg.png"]];
  [self.view setBackgroundColor:bgColor];

  [super viewDidLoad];

  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [AppData appState].LoginAutomtically = [defaults boolForKey:kLoginAutomatically];

  if ([AppData appState].LoginAutomtically) {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kRememberUsername]) {
      KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:kKeyTrackMyTradesUser accessGroup:nil];
      NSDictionary *userInfo = @{@"username":[keychain objectForKey:(__bridge id)(kSecAttrAccount)],
                                 @"password":[keychain objectForKey:(__bridge id)(kSecValueData)]
                                 };
      if (userInfo) {
        [PFUser logInWithUsername:[userInfo objectForKey:@"username"] password:[userInfo objectForKey:@"password"]];
      }
    }
  } else {
    [PFUser logOut];
  }

}

- (void)viewDidUnload {
  [super viewDidUnload];
}

-(void)viewDidAppear:(BOOL)animated {

  if (![PFUser currentUser]) {
    [self updateUserInfo];
  }
}

-(void) updateUserInfo {

  if (![PFUser currentUser]) { // No user logged in
    // Create the log in view controller
    LoginViewController *logInViewController = [[LoginViewController alloc] init];
    [logInViewController setDelegate:self]; // Set ourselves as the delegate


    // Create the sign up view controller
    SignUpViewController *signUpViewController = [[SignUpViewController alloc] init];
    [signUpViewController setDelegate:self]; // Set ourselves as the delegate

    // Assign our sign up controller to be displayed from the login controller
    [logInViewController setSignUpController:signUpViewController];

    logInViewController.fields = PFLogInFieldsDefault;

    // Present the log in view controller
    [self presentViewController:logInViewController animated:YES completion:NULL];
  }
}

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(LoginViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
  // Check if both fields are completed
  if (username && password && username.length != 0 && password.length != 0) {
    return YES; // Begin login process
  }

  BlockAlertView *alert = [BlockAlertView
                           alertWithTitle:@"Forget something?"
                           message:@"Plase make sure you fill out all the information."];
  [alert setCancelButtonWithTitle:@"OK" block:nil];
  [alert show];

  return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(LoginViewController *)logInController didLogInUser:(PFUser *)user {
  [self dismissViewControllerAnimated:YES completion:NULL];
  [[AppData appState].activeRootViewController loadObjects];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(LoginViewController *)logInController didFailToLogInWithError:(NSError *)error {
  NSLog(@"Could not login. Error: %@", error);

  // Display an alert that the login was nsuccessful
  BlockAlertView *alert = [BlockAlertView
                           alertWithTitle:@"Login error."
                           message:@"Plase check your username and password and try again."];
  [alert setCancelButtonWithTitle:@"OK" block:nil];
  [alert show];
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(LoginViewController *)logInController {
  [self.navigationController popViewControllerAnimated:YES];
}

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
  BOOL informationComplete = YES;

  // loop through all of the submitted data
  for (id key in info) {
    NSString *field = [info objectForKey:key];
    if (!field || field.length == 0) { // check completion
      informationComplete = NO;
      break;
    }
  }

  // Display an alert if a field wasn't completed
  if (!informationComplete) {
    BlockAlertView *alert = [BlockAlertView
                             alertWithTitle:@"Forget something?"
                             message:@"Plase make sure you fill out all the information."];
    [alert setCancelButtonWithTitle:@"OK" block:nil];
    [alert show];
  }

  return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
  [self dismissModalViewControllerAnimated:YES]; // Dismiss the PFSignUpViewController
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
  NSLog(@"Failed to sign up...");
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 190;
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
  NSLog(@"User dismissed the signUpViewController");
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  static NSString *CellIdentifier = @"MasterCell";

  AccountCell *cell = (AccountCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

  [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

  cell.disclosureImageView.image = [UIImage tallImageNamed:@"list-arrow.png"];

  cell.backgroundColor = [UIColor clearColor];
  return cell;

}

#pragma mark - Table view delegate
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 120;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


}

@end
