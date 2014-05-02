//
//  Transaction.m
//  TradeTracker
//
//  Created by Wilkie, Rich on 4/19/14.
//
//

#import "Transaction.h"
#import "Equity.h"
#import "Trade.h"


@implementation Transaction

@dynamic date;
@dynamic expirationDate;
@dynamic impliedVolAtOpen;
@dynamic miniDescription;
@dynamic name;
@dynamic parseId;
@dynamic price;
@dynamic quantity;
@dynamic updatedAt;
@dynamic equity;
@dynamic trade;

+ (NSString *) MR_entityName
{
  return @"Transaction";
}

@end
