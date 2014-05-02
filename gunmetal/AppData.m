//
//  AppData.m
//  TrackMyTrades
//
//  Created by Wilkie, Rich on 3/13/14.
//  Copyright (c) 2014 Rich Wilkie. All rights reserved.
//

#import "AppData.h"
@implementation AppData

static AppData *_sharedAppState = nil;

+ (void) resetAppData
{
  _sharedAppState = nil;
}

+(AppData *)appState {
  @synchronized(self) {
    if(!_sharedAppState) {
      _sharedAppState = [[self alloc] init];
    }
  }
  return _sharedAppState;
}

-(void)updateUserProfile {

}
@end
