//
//  TransactionsViewController.m
//  TrackMyTrade
//
//  Created by Wilkie, Rich on 3/9/14.
//  Copyright (c) 2014 Rich Wilkie. All rights reserved.
//

#import "TransactionsViewController.h"

#import "AppData.h"

@interface TransactionsViewController ()

@end

@implementation TransactionsViewController

- (id)initWithCoder:(NSCoder *)aCoder {

  self = [super initWithCoder:aCoder];
//  if (self) {
//    // Customize the table
//
//    // The className to query on
//    self.parseClassName = @"Transactions";
//
//    // The key of the PFObject to display in the label of the default cell style
//    self.textKey = @"name";
//
//    // The title for this table in the Navigation Controller.
//    self.title = @"Transactions";
//
//    // Whether the built-in pull-to-refresh is enabled
//    self.pullToRefreshEnabled = YES;
//
//    // Whether the built-in pagination is enabled
//    self.paginationEnabled = YES;
//
//    // The number of objects to show per page
//    self.objectsPerPage = 25;
//
//  }
  return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];

  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;

  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
  static NSString *CellIdentifier = @"TransactionCell";

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
  }

  // Configure the cell
  cell.textLabel.text = [object objectForKey:@"name"];
  cell.detailTextLabel.text = [object objectForKey:@"description"];

  return cell;
}

// Override to customize the look of the cell that allows the user to load the next page of objects.
// The default implementation is a UITableViewCellStyleDefault cell with simple labels.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"NextPage";

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }

  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.textLabel.text = @"Load more...";

  return cell;
}

#pragma mark - Table view data source

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Return NO if you do not want the specified item to be editable.
  return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    // Delete the row from the data source
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
  }
  else if (editingStyle == UITableViewCellEditingStyleInsert) {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
  }
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
  // Return NO if you do not want the item to be re-orderable.
  return YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
