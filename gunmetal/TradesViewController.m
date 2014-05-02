//
//  TradesViewController.m
//  TrackMyTrade
//
//  Created by Wilkie, Rich on 3/9/14.
//  Copyright (c) 2014 Rich Wilkie. All rights reserved.
//

#import "TradesViewController.h"
#import "MainViewController.h"
#import "TradeTrackerNotifications.h"
#import "TradeFilter.h"
#import "AppData.h"
#import "Trade.h"
#import "Strategy.h"
#import "Account.h"

@interface TradesViewController ()

@end

NSArray *trades;

@implementation TradesViewController

#pragma mark - View lifecycle

- (id)initWithCoder:(NSCoder *)aCoder {
  self = [super initWithCoder:aCoder];
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.clearsSelectionOnViewWillAppear = NO;
}

-(void)viewWillAppear:(BOOL)animated {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTradeList) name:kUpdatedTradeList object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTradeList) name:kUpdatedAccountList object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTradeList) name:kUpdatedStrategyList object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTradeList) name:kUpdatedTradeFilter object:nil];
  
  [self updateTradeList];
}

-(void)viewDidDisappear:(BOOL)animated {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Model managment

-(void) updateTradeList {
  [self applyActiveFilter];
  [self.tableView reloadData];
}

-(void) applyActiveFilter {
  TradeFilter *filter = [[TradeFilter alloc] initWithFilter:[AppData appState].activeFilter];
  if (self.strategy) {
    // Override the active filter and search on only one strategy
    filter.strategies = [NSMutableSet setWithObjects:self.strategy, nil];
  }
  if (self.account) {
    // Override the active filter and search on only one account
    filter.accounts = [NSMutableSet setWithObjects:self.account, nil];
  }
  trades = [Trade findAllSortedBy:@"openDate" ascending:YES withPredicate:[filter predicate]];
  NSLog(@"Found %d trades matching the filter", trades.count);
}

-(void) addTrade {
}

#pragma mark - Trades tabkleview delegate & data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return trades.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"TradeCell";
  Trade *trade = [trades objectAtIndex:indexPath.row];
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menubar-7"]];
  [cell setBackgroundColor: [UIColor colorWithPatternImage:[UIImage imageNamed:@"list-item-bg"]]];
  
  cell.textLabel.text = trade.name;
  cell.detailTextLabel.text = trade.miniDescription;
  
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"TransactionsSegue"]) {
    self.transactionsVC = segue.destinationViewController;
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
//  self.transactionsVC.trade = [[AppData appState].trades objectAtIndex:indexPath.row];
}

@end
