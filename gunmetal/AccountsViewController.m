//
//  AccountsViewController.m
//  TrackMyTrades
//
//  Created by Wilkie, Rich on 3/12/14.
//  Copyright (c) 2014 Rich Wilkie. All rights reserved.
//

#import "AccountsViewController.h"
#import "TradeTrackerNotifications.h"
#import "BlockAlertView.h"
#import "AppData.h"
#import "Account.h"
#import "Strategy.h"

@interface AccountsViewController ()

@end

@implementation AccountsViewController

#pragma mark - View lifecycle

- (id)initWithCoder:(NSCoder *)aCoder {
  return [super initWithCoder:aCoder];
}

- (void)viewDidLoad
{
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatedAccounts) name:kUpdatedAccountList object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatedStrategies) name:kUpdatedStrategyList object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showEm) name:kSwitchedMainSort object:nil];
  
  // Uncomment the following line to preserve selection between presentations.
  self.clearsSelectionOnViewWillAppear = NO;
  [AppData appState].activeRootViewController = self;
  
  [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
  //  [[AppData appState].mainVC pushNavButtonTitle:@""];
}

-(void)viewDidAppear:(BOOL)animated {
  [self.tableView reloadData];
}

#pragma mark - Model management

-(void) showEm {
  [self putUpTheAddButtonIfNecessary];
  [self.tableView reloadData];
}

-(void) updatedAccounts {
  [self showEm];
}

-(void) updatedStrategies {
  [self showEm];
}

-(void) putUpTheAddButtonIfNecessary {
  if ([[AppData appState].mainSort isEqualToString:kMainSortIsStrategies]) {
    if ([[[PFUser currentUser] objectForKey:@"level"] isEqualToString:@"SuperUser"]) {
      UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addStrategy)];
      self.navigationItem.rightBarButtonItem = addButton;
    } else {
      self.navigationItem.rightBarButtonItem = nil;
    }
  } else {
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAccount)];
    self.navigationItem.rightBarButtonItem = addButton;
  }
}

-(void) addAccount {
}

-(void) addStrategy {
}

#pragma mark - TableView delgate and data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  int nrows = ([[AppData appState].mainSort isEqualToString:kMainSortIsAccounts]) ? [AppData appState].accounts.count : [AppData appState].strategies.count;
  if (nrows > 1) {
    nrows++; // Need to account for the extra "All accounts" or "All stratgeies" at the top
  }
  return nrows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"AccountCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menubar-7"]];
  [cell setBackgroundColor: [UIColor colorWithPatternImage:[UIImage imageNamed:@"list-item-bg"]]];
  
  if ([[AppData appState].mainSort isEqualToString:kMainSortIsAccounts]) {
    if ([AppData appState].accounts.count > 1) {
      if (indexPath.row > 0) {
        Account *account = [[AppData appState].accounts objectAtIndex:indexPath.row-1];
        cell.textLabel.text = account.name;
        cell.detailTextLabel.text = account.miniDescription;
      } else {
        cell.textLabel.text = @"All Accounts";
        cell.detailTextLabel.text = @"";
      }
    } else {
      Account *account = [[AppData appState].accounts objectAtIndex:indexPath.row];
      cell.textLabel.text = account.name;
      cell.detailTextLabel.text = account.miniDescription;
    }
  } else {
    if (indexPath.row > 0) {
      Strategy *strategy = [[AppData appState].strategies objectAtIndex:indexPath.row-1];
      cell.textLabel.text = strategy.name;
      cell.detailTextLabel.text = strategy.miniDescription;
    } else {
      cell.textLabel.text = @"All strategies";
      cell.detailTextLabel.text = @"";
    }
  }
  return cell;
}

// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//  return NO;
//}

// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//  if (editingStyle == UITableViewCellEditingStyleDelete) {
//    // Delete the row from the data source
//    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//  }
//  else if (editingStyle == UITableViewCellEditingStyleInsert) {
//    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//  }
//}

// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
//{
//  //TODO - save the order
//}

// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//  return YES;
//}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
  if ([[AppData appState].mainSort isEqualToString:kMainSortIsAccounts]) {
    NSString *mainTitle = @"All Accounts";
    if ([AppData appState].accounts.count > 1) {
      if (indexPath.row == 0) {
        self.tradesVC.account = nil;
      } else {
        self.tradesVC.account = [[AppData appState].accounts objectAtIndex:indexPath.row-1];
        mainTitle = self.tradesVC.account.name;
      }
    } else {
      self.tradesVC.account = [[AppData appState].accounts objectAtIndex:indexPath.row];
      mainTitle = self.tradesVC.account.name;
    }
    [[AppData appState].mainVC pushNavButtonTitle:@"Accounts"];
    [[AppData appState].mainVC pushTopTitle:mainTitle];
    self.tradesVC.strategy = nil;
  } else{
    NSString *mainTitle = @"All Strategies";
    if (indexPath.row == 0) {
      self.tradesVC.strategy = nil;
    } else {
      self.tradesVC.strategy = [[AppData appState].strategies objectAtIndex:indexPath.row-1];
      mainTitle = self.tradesVC.strategy.name;
    }
    [[AppData appState].mainVC pushNavButtonTitle:@"Strategies"];
    [[AppData appState].mainVC pushTopTitle:mainTitle];
    self.tradesVC.account = nil;
  }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"TradesSegue"]) {
    self.tradesVC = segue.destinationViewController;
    self.tradesVC.backButton = [AppData appState].mainSort;
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if ([[AppData appState].mainSort isEqualToString:kMainSortIsAccounts]) {
    if ([AppData appState].accounts.count > 1) {
      if (indexPath.row == 0) {
        self.tradesVC.account = nil;
      } else {
        self.tradesVC.account = [[AppData appState].accounts objectAtIndex:indexPath.row-1];
      }
    } else {
      self.tradesVC.account = [[AppData appState].accounts objectAtIndex:indexPath.row];
    }
    self.tradesVC.strategy = nil;
  } else{
    if (indexPath.row == 0) {
      self.tradesVC.strategy = nil;
    } else {
      self.tradesVC.strategy = [[AppData appState].strategies objectAtIndex:indexPath.row-1];
    }
    self.tradesVC.account = nil;
  }
}

@end
