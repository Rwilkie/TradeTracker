//
//  Trade.m
//  TradeTracker
//
//  Created by Wilkie, Rich on 4/20/14.
//
//

#import "Trade.h"
#import "Account.h"
#import "Comments.h"
#import "Strategy.h"
#import "TradeTeam.h"
#import "Transaction.h"
#import "User.h"
#import "AppData.h"
#import "TradeTrackerNotifications.h"
#import <Parse/Parse.h>


@implementation Trade

@dynamic closed;
@dynamic closeDate;
@dynamic miniDescription;
@dynamic name;
@dynamic netProfit;
@dynamic openDate;
@dynamic parseId;
@dynamic potentialProfitAtOpen;
@dynamic updatedAt;
@dynamic account;
@dynamic comments;
@dynamic originator;
@dynamic strategy;
@dynamic tradeTeams;
@dynamic transactions;

+ (NSString *) MR_entityName
{
  return @"Trade";
}

-(BOOL)isClosed {
  return (self.closed == 0) ? NO : YES;
}

-(Trade *) initWithPFObject: (PFObject *) pfObject {
  
  self.name = [pfObject objectForKey:@"name"];
  self.updatedAt = pfObject.updatedAt;
  self.parseId = [NSString stringWithString:pfObject.objectId];
  self.miniDescription = [pfObject objectForKey:@"shortDescription"];
  self.openDate = [pfObject objectForKey:@"openDate"];
  self.closeDate = [pfObject objectForKey:@"closeDate"];
  if (self.closeDate) {
    self.closed = [NSNumber numberWithInt:1];
  } else {
    self.closed = [NSNumber numberWithInt:0];
  }
  self.netProfit = [pfObject objectForKey:@"netProfit"];
  self.potentialProfitAtOpen = [pfObject objectForKey:@"potentialProfitAtopen"];
  self.accountParseId = [pfObject objectForKey:@"account"];
  self.strategyParseId = [pfObject objectForKey:@"strategy"];
  
  return self;
}

+(void) syncTrades {
  PFQuery *query = [PFQuery queryWithClassName:@"Trades"];
  [query orderByAscending:@"objectId"];
  [query whereKey:@"user" equalTo:[PFUser currentUser].objectId];
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//TODO: - Need to take care of pagination when the trade list is laerge
    BOOL changesWereMade = NO;
    int newerTrades = NO;
    NSArray *trades = [Trade findAllSortedBy:@"parseId" ascending:YES];
    if (!error) {
      for (PFObject *object in objects) {
        BOOL foundIt = NO;
        for (Trade *trade in trades) {
          if ([trade.parseId isEqualToString:object.objectId]) {
            foundIt = YES;
            NSComparisonResult result = [trade.updatedAt compare:object.updatedAt];
            switch (result) {
              case NSOrderedSame:
                break;
                
              case NSOrderedAscending:
                changesWereMade = YES;
                newerTrades++;
                (void) [trade initWithPFObject:object];
                break;
                
              case NSOrderedDescending:
                break;
                
              default:
                NSLog(@"WTF: Dates on the trade don't make any sense.");
                break;
            }
          }
        }
        if(!foundIt) {
          newerTrades++;
          changesWereMade = YES;
          (void) [[Trade createEntity] initWithPFObject:object];
        }
      }
      if (newerTrades) {
        [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
          NSLog(@"Saved %d newer trades...", newerTrades);
        }];
      }
      if (changesWereMade) {
//        [AppData appState].trades = [Trade findAll];
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdatedTradeList object:nil];
      }
    }
  }];
}

@end
