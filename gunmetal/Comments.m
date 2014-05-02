//
//  Comments.m
//  TradeTracker
//
//  Created by Wilkie, Rich on 4/19/14.
//
//

#import "Comments.h"
#import "Trade.h"
#import "TradeTeam.h"
#import "User.h"


@implementation Comments

@dynamic comment;
@dynamic date;
@dynamic parseId;
@dynamic updatedAt;
@dynamic owner;
@dynamic team;
@dynamic trade;

+ (NSString *) MR_entityName
{
  return @"Comments";
}

@end
