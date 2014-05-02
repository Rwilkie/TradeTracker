//
//  AppDelegate.m
//  gunmetal
//
//  Created by Valentin on 5/13/122.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import "AppDelegate.h"
#import "AppData.h"
#import "Account.h"

#import <Parse/Parse.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
  [Parse setApplicationId:@"5OjjPDO5cCFRIlz4mKxrCJ5bwd2eh8JTRX0D5bCj" clientKey:@"77gsEuK0fbjxdOhwZoEG2GRQRkOJWjmoig1ZQoNx"];
  
  [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
  
  [self customizeiPadTheme];
  
  return YES;
}

-(void)applicationWillTerminate:(UIApplication *)application {
  [MagicalRecord cleanUp];
}

-(void)customizeiPadTheme
{
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
  
  // UINavigationBar appearance
  UIImage *navBarImage = [[UIImage tallImageNamed:@"menubar-right-7.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 0, 5)];
  [[UINavigationBar appearance] setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];
  [[UINavigationBar appearance] setTitleTextAttributes:
   @{UITextAttributeTextColor: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
     UITextAttributeTextShadowColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8],
     UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, -1)]}];
  
  // UIToolBar appearance
  [[UIToolbar appearance] setBackgroundImage:navBarImage forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
  
  // UISlider appearance
  UIImage *minImage = [UIImage tallImageNamed:@"slider-fill.png"];
  UIImage *maxImage = [UIImage tallImageNamed:@"slider-track.png"];
  UIImage *thumbImage = [UIImage tallImageNamed:@"slider-handle.png"];
  [[UISlider appearance] setMaximumTrackImage:maxImage forState:UIControlStateNormal];
  [[UISlider appearance] setMinimumTrackImage:minImage forState:UIControlStateNormal];
  [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateNormal];
  [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateHighlighted];
  
  // UISearchBar appearance
  [[UISearchBar appearance] setBackgroundImage:[UIImage tallImageNamed:@"searchbar-bg.png"]];
  
  // UIBarButtonItem appearance
  [[UIBarButtonItem appearance] setTitleTextAttributes: @{UITextAttributeTextColor: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
                                                          UITextAttributeTextShadowColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8],
                                                          UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, -1)]} forState:UIControlStateNormal];
  [[UIBarButtonItem appearance] setTintColor:[UIColor lightGrayColor]];
  
  // UISegmentedControl appearance
  [[UISegmentedControl appearance] setTintColor:[UIColor darkGrayColor]];
  [[UISegmentedControl appearance] setBackgroundImage:[UIImage tallImageNamed:@"button-black-pressed"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
  [[UISegmentedControl appearance] setTitleTextAttributes: @{UITextAttributeTextColor: [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
                                                             UITextAttributeTextShadowColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8],
                                                             UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, -1)]} forState:UIControlStateSelected];
  [[UISegmentedControl appearance] setTitleTextAttributes: @{UITextAttributeTextColor: [UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:0.8],
                                                             UITextAttributeTextShadowColor: [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8],
                                                             UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, -1)]} forState:UIControlStateNormal];
  
  
  
  // Main window appearance
  [self.window setBackgroundColor:[UIColor blackColor]];
  
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  /*
   Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  /*
   Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
   If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  /*
   Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
   */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  /*
   Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   */
}

@end
