//
//  Account.m
//  TradeTracker
//
//  Created by Wilkie, Rich on 4/19/14.
//
//

#import "TradeTrackerNotifications.h"
#import "AppData.h"
#import "Account.h"
#import "Trade.h"
#import "User.h"
#import <Parse/Parse.h>

@implementation Account

@dynamic balance;
@dynamic createdOn;
@dynamic currentInvestmentPercentage;
@dynamic name;
@dynamic parseId;
@dynamic targetInvestmentPercentage;
@dynamic updatedAt;
@dynamic owner;
@dynamic trades;
@dynamic agency;
@dynamic miniDescription;

+ (NSString *) MR_entityName
{
  return @"Account";
}

-(Account *) initWithPFObject: (PFObject *) pfObject {
  self.name = [NSString stringWithString:[pfObject objectForKey:@"name"]];
  self.balance = [pfObject objectForKey:@"balance"];
  self.parseId = [NSString stringWithString:pfObject.objectId];
  self.createdOn = pfObject.createdAt;
  self.currentInvestmentPercentage = [NSNumber numberWithFloat:[pfObject[@"currentInvestmentPercentage"] floatValue]];
  self.targetInvestmentPercentage = [NSNumber numberWithFloat:[pfObject[@"targetInvestmentPercentage"] floatValue]];
  self.updatedAt = pfObject.updatedAt;
  self.agency = [NSString stringWithString:[pfObject objectForKey:@"agency"]];
  self.miniDescription = [NSString stringWithString:[pfObject objectForKey:@"shortDescription"]];

  return self;
}

+(void) syncAccounts {
  PFQuery *query = [PFQuery queryWithClassName:@"Accounts"];
  [query whereKey:@"user" equalTo:[PFUser currentUser].objectId];
  [query orderByAscending:@"objectId"];
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    BOOL changesWereMade = NO;
    int newerAccounts = 0;
    NSArray *accounts = [Account findAllSortedBy:@"parseId" ascending:YES];
    if (!error) {
      for (PFObject *object in objects) {
        BOOL foundIt = NO;
        for (Account *acct in accounts) {
          if ([acct.parseId isEqualToString:object.objectId]) {
            foundIt = YES;
            NSComparisonResult result = [acct.updatedAt compare:object.updatedAt];
            switch (result) {
              case NSOrderedSame:
                break;
                
              case NSOrderedAscending:
                changesWereMade = YES;
                newerAccounts++;
                (void) [acct initWithPFObject:object];
                break;
                
              case NSOrderedDescending:
                break;
                
              default:
                NSLog(@"WTF: Dates on the account don't make any sense.");
                break;
            }
          }
        }
        if(!foundIt) {
          newerAccounts++;
          changesWereMade = YES;
          (void) [[Account createEntity] initWithPFObject:object];
        }
      }
      if (newerAccounts) {
        [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
          NSLog(@"Saved %d newer accounts...", newerAccounts);
        }];
      }
      if (changesWereMade) {
        [AppData appState].accounts = [Account findAllSortedBy:@"updatedAt" ascending:NO];
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdatedAccountList object:nil];
      }
    }
  }];
}
@end
