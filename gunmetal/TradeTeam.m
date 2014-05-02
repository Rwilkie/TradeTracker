//
//  TradeTeam.m
//  TradeTracker
//
//  Created by Wilkie, Rich on 4/19/14.
//
//

#import "TradeTeam.h"
#import "Comments.h"
#import "Trade.h"
#import "User.h"


@implementation TradeTeam

@dynamic miniDescription;
@dynamic name;
@dynamic parseId;
@dynamic publicTeam;
@dynamic updatedAt;
@dynamic comments;
@dynamic members;
@dynamic trades;

+ (NSString *) MR_entityName
{
  return @"TradeTeam";
}

@end
