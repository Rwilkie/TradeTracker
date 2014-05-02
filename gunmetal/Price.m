//
//  Price.m
//  TradeTracker
//
//  Created by Wilkie, Rich on 4/19/14.
//
//

#import "Price.h"
#import "Equity.h"


@implementation Price

@dynamic extrinsicValue;
@dynamic parseId;
@dynamic price;
@dynamic updatedAt;
@dynamic equity;

+ (NSString *) MR_entityName
{
  return @"Price";
}

@end
