//
//  FilterTrades.m
//  TradeTracker
//
//  Created by Wilkie, Rich on 3/23/14.
//
//

#import "FilterTrades.h"
#import "AppData.h"
#import "NSDate+Extensions.h"

@implementation FilterTrades

static FilterTrades *_filter = nil;

-(id)init {
  _filter = [super init];

  if (!_filter) {
    return nil;
  }

  _filter.accounts = [NSMutableSet setWithArray:[AppData appState].accounts];
  _filter.strategies = [NSMutableSet setWithArray:[AppData appState].strategies];

  _filter.openDate = [NSDate dateWithDaysBeforeNow:730];
  _filter.closedDate = nil;

  _filter.openTrades = YES;
  _filter.closedTrades = NO;

  _filter.profitable = YES;
  _filter.notProfitable = YES;

  _filter.minProfit = [NSNumber numberWithFloat:0.00f];

  return _filter;
}

-(id)initWithFilter:(FilterTrades *)sourceFilter {
  (void) [self init];

  if (!_filter) {
    return  nil;
  }

  if (sourceFilter) {

    if (sourceFilter.accounts.count) {
      _filter.accounts = [NSMutableSet setWithArray:[sourceFilter.accounts allObjects]];
    }

    if (sourceFilter.strategies.count) {
      _filter.strategies = [NSMutableSet setWithArray:[sourceFilter.strategies allObjects]];
    }

    _filter.closedDate = [sourceFilter.closedDate copy];
    _filter.openDate = [sourceFilter.openDate copy];

    _filter.closedTrades = sourceFilter.closedTrades;
    if (!_filter.closedTrades) {
      _filter.openTrades = YES;
    } else {
      _filter.openTrades = sourceFilter.openTrades;
    }

    _filter.minProfit = sourceFilter.minProfit;
    _filter.notProfitable = sourceFilter.notProfitable;
    if (!_filter.notProfitable) {
      _filter.profitable = YES;
    } else {
      _filter.profitable = sourceFilter.profitable;
    }
    
  }
  return _filter;
}

@end
