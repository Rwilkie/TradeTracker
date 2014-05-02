//
//  AccountsViewController.h
//  TrackMyTrades
//
//  Created by Wilkie, Rich on 3/12/14.
//  Copyright (c) 2014 Rich Wilkie. All rights reserved.
//

#import "TradesViewController.h"

#define kMainSortIsStrategies @"Strategies"
#define kMainSortIsAccounts   @"Accounts"

@interface AccountsViewController : UITableViewController

@property TradesViewController *tradesVC;
@property (nonatomic, strong) IBOutlet UIView* shadowView;

@end
