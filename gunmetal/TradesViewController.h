//
//  TradesViewController.h
//  TrackMyTrades
//
//  Created by Wilkie, Rich on 3/12/14.
//  Copyright (c) 2014 Rich Wilkie. All rights reserved.
//

#import "TransactionsViewController.h"
#import "Account.h"
#import "Strategy.h"

@interface TradesViewController : UITableViewController

@property Account *account;
@property Strategy *strategy;
@property TransactionsViewController *transactionsVC;
@property NSString *backButton;

@end
