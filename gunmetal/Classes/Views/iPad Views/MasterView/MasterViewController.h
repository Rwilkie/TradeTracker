//
//  MasterViewController.h
//  gunmetal
//
//  Created by Valentin on 5/13/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>
#import "TradesViewController.h"

@protocol MasterViewControllerDelegate;

@interface MasterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) TradesViewController *tradesVC;

@property (nonatomic, strong) IBOutlet UITableView* masterTableView;

@property (nonatomic, strong) NSArray* models;

@property (nonatomic, unsafe_unretained) id<MasterViewControllerDelegate> delegate;

-(void) updateUserInfo;

@end


@protocol MasterViewControllerDelegate <NSObject>


@end