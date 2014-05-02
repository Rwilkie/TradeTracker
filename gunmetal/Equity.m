//
//  Equity.m
//  TradeTracker
//
//  Created by Wilkie, Rich on 4/19/14.
//
//

#import "Equity.h"
#import "Equity.h"
#import "Price.h"
#import "Transaction.h"


@implementation Equity

@dynamic expirationDate;
@dynamic miniDescription;
@dynamic name;
@dynamic parseId;
@dynamic symbol;
@dynamic updatedAt;
@dynamic derivativeEquities;
@dynamic prices;
@dynamic transactions;
@dynamic underylingEquity;

+ (NSString *) MR_entityName
{
  return @"Equity";
}

@end
