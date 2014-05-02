//
//  FilterTrades.h
//  TradeTracker
//
//  Created by Wilkie, Rich on 3/23/14.
//
//

#import <Foundation/Foundation.h>

@interface TradeFilter : NSObject

@property NSMutableSet *accounts;
@property NSMutableSet *strategies;
@property BOOL openTrades;
@property BOOL closedTrades;
@property NSDate *openDate;
@property NSDate *closedDate;
@property BOOL profitable;
@property BOOL notProfitable;
@property NSNumber *minProfit;

-(id)initWithFilter: (TradeFilter *)sourceFilter;
-(id)init;
-(NSPredicate *) predicate;

@end
