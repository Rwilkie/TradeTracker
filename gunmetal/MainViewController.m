//
//  MainViewController.m
//  TradeTracker
//
//  Created by Wilkie, Rich on 3/23/14.
//
//

#import "MainViewController.h"
#import "AppData.h"
#import "AccountsViewController.h"
#import "TradeFilter.h"
#import "Account.h"
#import "Strategy.h"
#import "Trade.h"
#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "BlockAlertView.h"
#import "TradeTrackerNotifications.h"
#import "Stack.h"

@interface MainViewController ()

@property Stack *navButtonTitleStack;
@property Stack *topTitleStack;
@property NSMutableDictionary *detailVCs;
@property UIViewController *currentDetailViewController;

@end

@implementation MainViewController

#pragma mark - ViewController Life cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [MagicalRecord setupCoreDataStack];
  self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_landscape"]];
  [self makeDetailsViewControllerActive:@"AccountDetailsViewController"];
  [self kickMe:NO];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  CGRect topToolbarRect = self.topToolbar.frame;
  topToolbarRect.size.height = 64;
  [self.topToolbar setFrame:topToolbarRect];
  self.navBackButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(didUpdateAccountList)
                                               name:kUpdatedAccountList
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(didUpdateStrategyList)
                                               name:kUpdatedStrategyList
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector: @selector(appActivated)
                                               name: UIApplicationDidBecomeActiveNotification
                                             object: nil];
}

-(void)viewDidAppear:(BOOL)animated {
  [AppData appState].mainVC = self;
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) appActivated {
  [self.displaySegmentedControl setSelectedSegmentIndex:0];
  [AppData appState].mainSort = kMainSortIsAccounts;
  [self updateAccountsAndStrategies];
  [AppData appState].accounts = [Account findAllSortedBy:@"updatedAt" ascending:NO];
  [AppData appState].strategies = [Strategy findAllSortedBy:@"name" ascending:YES];
  [self kickMe:YES];
}

-(UIViewController *) makeDetailsViewControllerActive: (NSString *) name {
  if (!self.detailVCs) {
    self.detailVCs = [[NSMutableDictionary alloc] initWithCapacity:2];
  }
  UIViewController *vc = [self.detailVCs objectForKey:name];
  if (!vc) {
    vc = [[self storyboard] instantiateViewControllerWithIdentifier:name];
    [self.detailVCs setValue:vc forKey:name];
  }
  
  if(self.currentDetailViewController) {
    [self.currentDetailViewController willMoveToParentViewController:nil];
    [self.currentDetailViewController.view removeFromSuperview];
    [self.currentDetailViewController removeFromParentViewController];
  }
  
  [self addChildViewController:vc];
  [self.detailContainer addSubview:vc.view];
  self.currentDetailViewController = vc;
  [vc didMoveToParentViewController:self];
  
  return vc;
}

#pragma mark - User Controls

- (IBAction)logoutButtonPressed:(id)sender {
  [PFUser logOut];

  NSURL *defaultURL = [NSPersistentStore defaultLocalStoreUrl];
  [MagicalRecord cleanUp];
  
  NSError *error = nil;
  if(![[NSFileManager defaultManager] removeItemAtURL:defaultURL error:&error]){
    NSLog(@"An error has occurred while deleting %@", defaultURL);
    NSLog(@"Error description: %@", error.description);
  }
  [MagicalRecord setupCoreDataStack];
  
  [self kickMe: NO];
  [self updateUserInfo];
  [self updateAccountsAndStrategies];
}

- (IBAction)navBackButtonPressed:(id)sender {
  AccountsViewController *accountsVC = (AccountsViewController *) [AppData appState].activeRootViewController;
  [accountsVC.navigationController popViewControllerAnimated:YES];
  [self popNavButtonTitle];
  [self popTopTitle];
}

- (IBAction)mainSortSegmentedControlChanged:(id)sender {
  if (self.displaySegmentedControl.selectedSegmentIndex == 0) {
    [AppData appState].mainSort = kMainSortIsAccounts;
    [self makeDetailsViewControllerActive:@"AccountDetailsViewController"];
  } else {
    [AppData appState].mainSort = kMainSortIsStrategies;
    [self makeDetailsViewControllerActive:@"StrategyDetailsViewController"];
  }
  [[NSNotificationCenter defaultCenter] postNotificationName:kSwitchedMainSort object:self];
  [self kickMe:YES];
}

- (IBAction)refreshButtonPressed:(id)sender {
  [self updateAccountsAndStrategies];
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
  if (self.filterPopoverController) {
    [self togglePopover];
    return NO;
  }
  return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([[segue identifier] isEqualToString:@"FilterPopoverSegue"]) {
    [[segue destinationViewController] setDelegate:self];
    self.filterPopoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
    self.filterPopoverController.delegate = self;
    [AppData appState].tempFilter = [[TradeFilter alloc] initWithFilter:[AppData appState].activeFilter];
  }
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
  self.filterPopoverController = nil;
}

- (void)togglePopover {
  if (self.filterPopoverController) {
    [self.filterPopoverController dismissPopoverAnimated:YES];
    self.filterPopoverController = nil;
  }
}

-(void) pushNavButtonTitle: (NSString *) title {
  [self.navButtonTitleStack pushObject:title];
  NSMutableString *s = [[NSMutableString alloc] initWithString:@"\u276e "];
  if (title.length) {
    [s appendString:title];
  } else {
    [s setString:@""];
  }
  [self.navBackButton setTintColor:[UIColor lightGrayColor]];
  [self.navBackButton setTitle:s forState:UIControlStateNormal];
}

-(void) popNavButtonTitle {
  NSString *title;
  if (self.navButtonTitleStack.count == 1) {
    title = [self.navButtonTitleStack peekObject];
  } else {
    [self.navButtonTitleStack popObject];
    title = [self.navButtonTitleStack peekObject];
  }
  NSMutableString *s = [[NSMutableString alloc] initWithString:@"\u276e "];
  if (title.length) {
    [s appendString:title];
  } else {
    [s setString:@""];
  }
  [self.navBackButton setTintColor:[UIColor lightGrayColor]];
  [self.navBackButton setTitle:s forState:UIControlStateNormal];
}

-(void) pushTopTitle:(NSString *)title {
  [self.topTitleStack pushObject:title];
  self.mainTitle.text = title;
}

-(void) popTopTitle {
  NSString *title;
  if (self.topTitleStack.count == 1) {
    title = [self.topTitleStack peekObject];
  } else {
    [self.topTitleStack popObject];
    title = [self.topTitleStack peekObject];
  }
  self.mainTitle.text = title;
}

#pragma mark - Model Management

-(void) kickMe: (BOOL) animated {
  AccountsViewController *accountsVC = (AccountsViewController *)[AppData appState].activeRootViewController;
  [accountsVC.navigationController popToRootViewControllerAnimated:animated];
  self.navButtonTitleStack = [[Stack alloc] init];
  [self pushNavButtonTitle:@""];
  self.topTitleStack = [[Stack alloc] init];
  [self pushTopTitle:@"Trade Track"];
}

-(void) updateAccountsAndStrategies {
  if ([PFUser currentUser]) {
    NSLog(@"Updating account and strategy info...");
    [Account syncAccounts];
    [AppData appState].accounts = [Account findAll];
    [Strategy syncStrategies];
    [AppData appState].strategies = [Strategy findAllSortedBy:@"name" ascending:YES];
    [Trade syncTrades];
    [[NSNotificationCenter defaultCenter] postNotificationName:kSwitchedMainSort object:self];
    [AppData appState].activeFilter = [[TradeFilter alloc] init];
    
  } else {
    NSLog(@"Trying to update accounts and strategies but there's no PFUser logged in");
    [self updateUserInfo];
  }
}

#pragma mark - Notifications

-(void) didUpdateAccountList {
  [AppData appState].accounts = [Account findAllSortedBy:@"updatedAt" ascending:NO];
  NSLog(@"\n\n\n\nUpdated account list includes %d strategies.\n%@", [AppData appState].accounts.count, [AppData appState].accounts);
  [AppData appState].activeFilter.accounts = [NSMutableSet setWithArray:[AppData appState].accounts];
}

-(void) didUpdateStrategyList {
  NSArray *strategies = [Strategy findAllSortedBy:@"name" ascending:YES];
  NSLog(@"\n\n\n\nUpdated strategy list includes %d strategies.\n%@", strategies.count, strategies);
  [AppData appState].strategies = [Strategy findAllSortedBy:@"name" ascending:YES];
  [AppData appState].activeFilter.strategies = [NSMutableSet setWithArray:[AppData appState].strategies];
}

#pragma mark - User setup

-(void) updateUserInfo {
  if (![PFUser currentUser]) { // No user logged in
    
    // Create the log in view controller
    LoginViewController *logInViewController = [[LoginViewController alloc] init];
    [logInViewController setDelegate:self];
    
    // Create the sign up view controller
    SignUpViewController *signUpViewController = [[SignUpViewController alloc] init];
    [signUpViewController setDelegate:self];
    
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
                           alertWithTitle:@"Aw Snap...\nDid you forget something?"
                           message:@"Please make sure you fill out all the information and try again."];
  [alert setCancelButtonWithTitle:@"OK" block:nil];
  [alert show];
  
  return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(LoginViewController *)logInController didLogInUser:(PFUser *)user {
  [self dismissViewControllerAnimated:YES completion:NULL];
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [AppData appState].LoginAutomtically = [defaults boolForKey:kLoginAutomatically];
  //  if ([AppData appState].LoginAutomtically == NO) {
  //    [PFUser logOut];
  //  }
  
  NSString *sort = [defaults stringForKey:@"MainSort"];
  if (!sort) {
    sort = @"Accounts";
    [defaults setObject:sort forKey:@"MainSort"];
    [defaults synchronize];
  }
  [AppData appState].mainSort = sort;
  [self appActivated];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(LoginViewController *)logInController didFailToLogInWithError:(NSError *)error {
  NSLog(@"Could not login. Error: %@", error);
  
  // Display an alert that the login was unsuccessful
  BlockAlertView *alert = [BlockAlertView
                           alertWithTitle:@"Oops..."
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
                             alertWithTitle:@"Aw snap...\nDid you forget something?"
                             message:@"Plase make sure you fill out all the information and try again."];
    [alert setCancelButtonWithTitle:@"OK" block:nil];
    [alert show];
  }
  
  return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
  [self dismissViewControllerAnimated:YES completion:nil];
  //  [self dismissModalViewControllerAnimated:YES]; // Dismiss the PFSignUpViewController
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
  NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
  NSLog(@"User dismissed the signUpViewController");
}

@end
