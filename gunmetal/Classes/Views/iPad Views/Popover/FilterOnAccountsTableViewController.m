//
//  FilterOnAccountsTableViewController.m
//  TradeTracker
//
//  Created by Wilkie, Rich on 3/23/14.
//
//

#import "FilterOnAccountsTableViewController.h"
#import "AppData.h"
#import "Account.h"
#import <Parse/Parse.h>
#import "BlockAlertView.h"

@interface FilterOnAccountsTableViewController ()

@end

@implementation FilterOnAccountsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aCoder {
  return [super initWithCoder:aCoder];
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;

  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (IBAction)allAccountsButtonPressed:(id)sender {
  NSArray *allAccounts = [AppData appState].accounts;
  for (int i=0; i<allAccounts.count; i++) {
    [[AppData appState].tempFilter.accounts addObject:[allAccounts objectAtIndex:i]];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
  }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [AppData appState].accounts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountNameCell" forIndexPath:indexPath];
  Account *account = [[AppData appState].accounts objectAtIndex:indexPath.row];
  cell.textLabel.text = account.name;
  cell.detailTextLabel.text = account.miniDescription;
  cell.accessoryType = UITableViewCellAccessoryNone;
  for (Account *acct in [AppData appState].tempFilter.accounts) {
    if ([acct.parseId isEqualToString:account.parseId]) {
      cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *tableViewCell = [tableView cellForRowAtIndexPath:indexPath];
  Account *selectedAccount = [[AppData appState].accounts objectAtIndex:indexPath.row];
  BOOL inTheSet = NO;
  for (Account *account in [AppData appState].tempFilter.accounts) {
    if ([selectedAccount.parseId isEqualToString:account.parseId]) {
      if ([AppData appState].tempFilter.accounts.count == 1) { // Must have at least one account, don't allow them to remove the last one
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Oops..."
                                 message:@"You need at least one account for a filter. Please turn on another account before turning this one off."];
        [alert setCancelButtonWithTitle:@"OK" block:nil];
        [alert show];
      } else {
        [[AppData appState].tempFilter.accounts removeObject:selectedAccount];
        tableViewCell.accessoryType = UITableViewCellAccessoryNone;
      }
      inTheSet = YES;
      break;
    }
  }
  if (!inTheSet) {
    [[AppData appState].tempFilter.accounts addObject:selectedAccount];
    tableViewCell.accessoryType = UITableViewCellAccessoryCheckmark;
  }
  [self.tableView reloadData];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

@end
