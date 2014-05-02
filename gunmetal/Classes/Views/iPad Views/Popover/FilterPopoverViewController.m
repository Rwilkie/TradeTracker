//
//  FilterPopoverViewController.m
//  TradeTracker
//
//  Created by Wilkie, Rich on 3/23/14.
//
//

#import "FilterPopoverViewController.h"
#import "FilterOnAccountsTableViewController.h"
#import "TradeFilter.h"
#import "AppData.h"
#import "Account.h"
#import "Strategy.h"
#import "MainViewController.h"
#import "TradeTrackerNotifications.h"
#import "DatePickerViewController.h"

@interface FilterPopoverViewController ()

@property UIPopoverController *popoverControl;
@property DatePickerViewController *popoverVC;

@end

@implementation FilterPopoverViewController

BOOL isOpenDatePicker;

#pragma mark - View Lifecycle

-(void)viewWillAppear:(BOOL)animated {
  TradeFilter *filter = [AppData appState].tempFilter;
  
  self.minProfitInput.text = [filter.minProfit stringValue];
  
  if (filter.openTrades && filter.closedTrades) {
    self.tradeStatusSegmentedControl.selectedSegmentIndex = 1;
  } else if (filter.openTrades) {
    self.tradeStatusSegmentedControl.selectedSegmentIndex = 0;
  } else {
    self.tradeStatusSegmentedControl.selectedSegmentIndex = 2;
  }
  
  if (filter.profitable && filter.notProfitable) {
    self.profitabilitySegmentedControl.selectedSegmentIndex = 1;
  } else if (filter.profitable) {
    self.profitabilitySegmentedControl.selectedSegmentIndex = 0;
  } else {
    self.profitabilitySegmentedControl.selectedSegmentIndex = 2;
  }
  
  [self.openDateTextField setText:[self formattedDate:filter.openDate]];
  [self.closeDateTextField setText:[self formattedDate:filter.closedDate]];
  
  self.accountsLabel.text = [self whichAccounts];
  self.strategiesLabel.text = [self whichStrategies];
}

-(NSString *) formattedDate: (NSDate *)date {
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:@"MMM dd, yyyy"];
  return [dateFormat stringFromDate:date];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - User Controls

- (IBAction)openAfterDatePickerPressed:(id)sender {
  TradeFilter *filter = [AppData appState].tempFilter;
  isOpenDatePicker = YES;
  [self loadDatePickerAt:sender withInitialDate:filter.openDate andTitle:@"Opened on or after ..."];
}

- (IBAction)closedBeforeDatePickerPressed:(id)sender {
  TradeFilter *filter = [AppData appState].tempFilter;
  isOpenDatePicker = NO;
  [self loadDatePickerAt:sender withInitialDate:filter.closedDate andTitle:@"Closed on or before ..."];
}

- (IBAction)clearDatesPressed:(id)sender {
  TradeFilter *filter = [AppData appState].tempFilter;
  self.openDateTextField.text = @"";
  filter.openDate = nil;
  self.closeDateTextField.text = @"";
  filter.closedDate = nil;
}

- (IBAction)cancelButtonPressed:(id)sender {
  [[AppData appState].mainVC togglePopover];
}

- (IBAction)doneButtonPressed:(id)sender {
  [AppData appState].activeFilter = [[TradeFilter alloc] initWithFilter:[AppData appState].tempFilter];
  [[NSNotificationCenter defaultCenter] postNotificationName:kUpdatedTradeFilter object:self];
  [[AppData appState].mainVC togglePopover];
}

- (IBAction)openDateFinishedEditing:(id)sender {
  NSLog(@"Finished editing the open date with %@", self.openDateTextField.text);
  TradeFilter *filter = [AppData appState].tempFilter;
  if (self.openDateTextField.text.length) {
    NSDate *date = [self legitDateFromString:self.openDateTextField.text];
    filter.openDate = [date earlierDate:filter.closedDate];
  } else {
    filter.openDate = nil;
  }
}

-(NSDate *) legitDateFromString: (NSString *)string {
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:@"MMM dd, yyyy"];
  return [dateFormat dateFromString:string];
}

- (IBAction)closeDateFinishedEditing:(id)sender {
  NSLog(@"Finished editing the close date with %@", self.closeDateTextField.text);
  TradeFilter *filter = [AppData appState].tempFilter;
  if (self.closeDateTextField.text.length) {
    NSDate *date = [self legitDateFromString:self.closeDateTextField.text];
    filter.closedDate = [date laterDate:filter.openDate];
  } else {
    filter.closedDate = nil;
  }
}

- (IBAction)tradeStatusChanged:(id)sender {
  TradeFilter *filter = [AppData appState].tempFilter;
  
  switch (self.tradeStatusSegmentedControl.selectedSegmentIndex) {
    case 0:
      filter.openTrades = YES;
      filter.closedTrades = NO;
      break;
      
    case 1:
      filter.openTrades = YES;
      filter.closedTrades = YES;
      break;
      
    case 2:
      filter.openTrades = NO;
      filter.closedTrades = YES;
      break;
      
    default:
      break;
  }
}

- (IBAction)profitabilityChanged:(id)sender {
  TradeFilter *filter = [AppData appState].tempFilter;
  
  switch (self.profitabilitySegmentedControl.selectedSegmentIndex) {
    case 0:
      filter.profitable = YES;
      filter.notProfitable = NO;
      break;
      
    case 1:
      filter.profitable = YES;
      filter.notProfitable = YES;
      break;
      
    case 2:
      filter.profitable = NO;
      filter.notProfitable = YES;
      break;
      
    default:
      break;
  }
}

-(NSString *) whichAccounts {
  
  NSMutableSet *accountSet = [AppData appState].tempFilter.accounts;
  NSArray *allAccounts = [AppData appState].accounts;
  NSString *accountString = @"All accounts";
  NSMutableString *accountList = [[NSMutableString alloc] init];
  BOOL anyMissing = NO;
  
  for (int i=0; i<allAccounts.count; i++) {
    
    Account *account = [allAccounts objectAtIndex:i];
    
    BOOL inTheSet = NO;
    for (Account *acct in accountSet) {
      if ([acct.parseId isEqualToString:account.parseId]) {
        if ([accountList length] > 0) {
          [accountList appendFormat:@", "];
        }
        [accountList appendFormat:@"%@", account.name];
        inTheSet = YES;
      }
    }
    if (!inTheSet) {
      anyMissing = YES;
    }
  }
  
  if (anyMissing) {
    accountString = [accountList copy];
  }
  
  return accountString;
}

-(NSString *) whichStrategies {
  
  NSMutableSet *strategySet = [AppData appState].tempFilter.strategies;
  NSArray *allStrategies = [AppData appState].strategies;
  NSString *strategyString = @"All strategies";
  NSMutableString *strategyList = [[NSMutableString alloc] init];
  BOOL anyMissing = NO;
  
  for (int i=0; i<allStrategies.count; i++) {
    
    Strategy *strategy = [allStrategies objectAtIndex:i];
    
    BOOL inTheSet = NO;
    for (Strategy *strat in strategySet) {
      if ([strat.parseId isEqualToString:strategy.parseId]) {
        if ([strategyList length] > 0) {
          [strategyList appendFormat:@", "];
        }
        [strategyList appendFormat:@"%@", strategy.name];
        inTheSet = YES;
      }
    }
    if (!inTheSet) {
      anyMissing = YES;
    }
  }
  
  if (anyMissing) {
    strategyString = [strategyList copy];
  }
  
  return strategyString;
}


-(void) datePickerCancelled {
  [self.popoverControl dismissPopoverAnimated:YES];
  [self nullOutThePopover];
}

-(void) datePickerDone: (NSDate *)date {
  if (isOpenDatePicker) {
    [AppData appState].tempFilter.openDate = date;
    [AppData appState].tempFilter.closedDate = [[AppData appState].tempFilter.closedDate laterDate:date];
  } else {
    [AppData appState].tempFilter.closedDate = date;
    [AppData appState].tempFilter.openDate = [[AppData appState].tempFilter.openDate earlierDate:date];
  }
  [self.openDateTextField setText:[self formattedDate:[AppData appState].tempFilter.openDate]];
  [self.closeDateTextField setText:[self formattedDate:[AppData appState].tempFilter.closedDate]];
  [self.popoverControl dismissPopoverAnimated:YES];
  [self nullOutThePopover];
}

- (void) loadDatePickerAt: (id)sender withInitialDate: (NSDate *)date andTitle: (NSString *) pickerTitle {
  self.popoverVC = [[self storyboard] instantiateViewControllerWithIdentifier:@"DatePickerVC"];
  self.popoverControl = [[UIPopoverController alloc] initWithContentViewController:self.popoverVC];
  self.popoverControl.delegate = self;
  self.popoverVC.delegate = self;
  self.popoverVC.popoverTitle = pickerTitle;
  self.popoverVC.initialDate = date;
  [self.popoverControl presentPopoverFromRect:[(UIButton *)sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void) nullOutThePopover {
  self.popoverVC = nil;
  self.popoverControl = nil;
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
  [self nullOutThePopover];
}

@end