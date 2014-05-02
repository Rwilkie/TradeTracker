//
//  FilterOnStrategiesTableViewController.m
//  TradeTracker
//
//  Created by Wilkie, Rich on 3/26/14.
//
//

#import "FilterOnStrategiesTableViewController.h"
#import "AppData.h"
#import "Strategy.h"
#import <Parse/Parse.h>
#import "BlockAlertView.h"


@interface FilterOnStrategiesTableViewController ()

@end

@implementation FilterOnStrategiesTableViewController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (IBAction)allStrategiesButtonPressed:(id)sender {
  NSArray *allStrategies = [AppData appState].strategies;
  for (int i=0; i<allStrategies.count; i++) {
    [[AppData appState].tempFilter.strategies addObject:[allStrategies objectAtIndex:i]];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
  }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [AppData appState].strategies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StrategyNameCell" forIndexPath:indexPath];
  Strategy *strategy = [[AppData appState].strategies objectAtIndex:indexPath.row];
  cell.textLabel.text = strategy.name;
  cell.detailTextLabel.text = strategy.miniDescription;
  cell.accessoryType = UITableViewCellAccessoryNone;
  for (Strategy *strat in [AppData appState].tempFilter.strategies) {
    if ([strat.parseId isEqualToString:strategy.parseId]) {
      cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *tableViewCell = [tableView cellForRowAtIndexPath:indexPath];
  Strategy *selectedStrategy = [[AppData appState].strategies objectAtIndex:indexPath.row];
  BOOL inTheSet = NO;
  for (Strategy *strategy in [AppData appState].tempFilter.strategies) {
    if ([selectedStrategy.parseId isEqualToString:strategy.parseId]) {
      if ([AppData appState].tempFilter.strategies.count == 1) { // Must have at least one strategy, don't allow them to remove the last one
        BlockAlertView *alert = [BlockAlertView alertWithTitle:@"Oops..."
                                                       message:@"You need at least one strategy for a filter. Please turn on another strategy before turning this one off."];
        [alert setCancelButtonWithTitle:@"OK" block:nil];
        [alert show];
      } else {
        [[AppData appState].tempFilter.strategies removeObject:selectedStrategy];
        tableViewCell.accessoryType = UITableViewCellAccessoryNone;
      }
      inTheSet = YES;
      break;
    }
  }
  if (!inTheSet) {
    [[AppData appState].tempFilter.strategies addObject:selectedStrategy];
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
