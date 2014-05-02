//
//  FilterTrades.m
//  TradeTracker
//
//  Created by Wilkie, Rich on 3/23/14.
//
//

#import "TradeFilter.h"
#import "AppData.h"
#import "NSDate+Extensions.h"

@implementation TradeFilter

static TradeFilter *_filter = nil;

-(id)init {
  _filter = [super init];
  
  if (!_filter) {
    return nil;
  }
  
  _filter.accounts = [NSMutableSet setWithArray:[AppData appState].accounts];
  _filter.strategies = [NSMutableSet setWithArray:[AppData appState].strategies];
  
  _filter.openDate = nil;
  _filter.closedDate = nil;
  
  _filter.openTrades = YES;
  _filter.closedTrades = NO;
  
  _filter.profitable = YES;
  _filter.notProfitable = YES;
  
  _filter.minProfit = [NSNumber numberWithFloat:0.00f];
  
  return _filter;
}

-(id)initWithFilter:(TradeFilter *)sourceFilter {
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

-(NSPredicate *)predicate {
  
  NSMutableArray *predicates = [[NSMutableArray alloc] init];
  
  // Filter on strategies
  NSMutableArray *stratPreds = [[NSMutableArray alloc] init];
  for (Strategy *s in self.strategies) {
    NSString *predString = [NSString stringWithFormat:@"strategyParseId == '%@'", s.parseId];
    [stratPreds addObject:[NSPredicate predicateWithFormat:predString]];
  }
  [predicates addObject:[NSCompoundPredicate orPredicateWithSubpredicates:stratPreds]];
  
  // Filter on accounts
  NSMutableArray *acctPreds = [[NSMutableArray alloc] init];
  for (Account *a in self.accounts) {
    NSString *predString = [NSString stringWithFormat:@"accountParseId == '%@'", a.parseId];
    [acctPreds addObject:[NSPredicate predicateWithFormat:predString]];
  }
  [predicates addObject:[NSCompoundPredicate orPredicateWithSubpredicates:acctPreds]];
  
  // Filter on other things ...
  //   ... open vs closed
  if (self.closedTrades && !self.openTrades) {
    [predicates addObject:[NSPredicate predicateWithFormat:@"closed == 1"]];
  } else if (!self.closedTrades && self.openTrades) {
    [predicates addObject:[NSPredicate predicateWithFormat:@"closed == 0"]];
  }
  if (self.openDate) {
    [predicates addObject:[NSPredicate predicateWithFormat:@"openDate >= %@",self.openDate]];
  }
  if (self.closedDate) {
    [predicates addObject:[NSPredicate predicateWithFormat:@"closeDate <= %@", self.closedDate]];
  }
  
  //   ... profitability
  if (self.profitable && !self.notProfitable) {
    [predicates addObject:[NSPredicate predicateWithFormat:@"netProfit >= 0.0"]];
  } else if (!self.profitable && self.notProfitable) {
    [predicates addObject:[NSPredicate predicateWithFormat:@"netProfit <= 0.0"]];
  }
  
  // Pack it all together and send it back
  NSPredicate *finalPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
  NSLog(@"Predicate = %@", finalPredicate.debugDescription);
  return finalPredicate;
}

@end
