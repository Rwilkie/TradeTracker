//
//  ListViewController.m
//  gunmetal
//
//  Created by Valentin Filip on 5/13/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import "ListViewController.h"
#import "AccountCell.h"
#import "Utils.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage tallImageNamed:@"bg.png"]];
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewDidUnload {
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source


//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//  return 80;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 52;
}

#pragma mark - Table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  cell.disclosureImageView.image = [UIImage tallImageNamed:@"list-arrow.png"];

  cell.backgroundColor = [UIColor clearColor];
  // Configure the cell...

  return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  NSLog(@"Your implementation! :)");
}

@end
