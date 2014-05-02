//
//  AppData.h
//  TrackMyTrades
//
//  Created by Wilkie, Rich on 3/13/14.
//  Copyright (c) 2014 Rich Wilkie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountsViewController.h"
#import "MainViewController.h"
#import "TradeFilter.h"

#define kKeyTrackMyTradesUser   @"TrackMyTradesUser"
#define kRememberUsername       @"RemeberUsername"
#define kLoginAutomatically     @"LoginAutomatically"

@interface AppData : NSObject

+ (AppData *)appState;

- (void)updateUserProfile;

@property AccountsViewController *masterVC;
@property UIViewController *activeRootViewController;
@property BOOL LoginAutomtically;
@property NSString *mainSort;
@property MainViewController *mainVC;
@property NSNumber *level;

@property NSArray *accounts;
@property NSArray *strategies;
@property NSArray *trades;

@property TradeFilter *activeFilter;
@property TradeFilter *tempFilter;

@end
