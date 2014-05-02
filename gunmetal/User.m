//
//  User.m
//  TradeTracker
//
//  Created by Wilkie, Rich on 4/19/14.
//
//

#import "User.h"
#import "Account.h"
#import "Comments.h"
#import "Trade.h"
#import "TradeTeam.h"


@implementation User

@dynamic email;
@dynamic familyName;
@dynamic givenName;
@dynamic level;
@dynamic parseId;
@dynamic picURL;
@dynamic updatedAt;
@dynamic accounts;
@dynamic comments;
@dynamic originatedTrades;
@dynamic tradeTeams;

+ (NSString *) MR_entityName
{
  return @"User";
}

@end
