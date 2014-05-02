//
//  Strategy.m
//  TradeTracker
//
//  Created by Wilkie, Rich on 4/19/14.
//
//

#import "TradeTrackerNotifications.h"
#import "AppData.h"

#import "Strategy.h"
#import "Trade.h"

#import <Parse/Parse.h>

@implementation Strategy

@dynamic howBullish;
@dynamic howItCanLooseMoney;
@dynamic howItMakesMoney;
@dynamic maxIVRank;
@dynamic minIVRank;
@dynamic name;
@dynamic parseId;
@dynamic updatedAt;
@dynamic trades;
@dynamic miniDescription;
@dynamic createdOn;

+ (NSString *) MR_entityName
{
  return @"Strategy";
}

-(Strategy *) initWithPFObject: (PFObject *) pfObject {

  self.name = [pfObject objectForKey:@"name"];
  self.updatedAt = pfObject.updatedAt;
  self.howItMakesMoney = [pfObject objectForKey:@"howItMakesMoney"];
  self.howItCanLooseMoney = [pfObject objectForKey:@"howItCanLooseMoney"];
  self.parseId = [NSString stringWithString:pfObject.objectId];
  self.miniDescription = [pfObject objectForKey:@"shortDescription"];
  self.howBullish = [NSNumber numberWithFloat:[pfObject[@"howBullish"] floatValue]];
  self.maxIVRank = [NSNumber numberWithFloat:[pfObject[@"maxIVRank"] floatValue]];
  self.minIVRank = [NSNumber numberWithFloat:[pfObject[@"minIVRank"] floatValue]];
  self.createdOn = pfObject.createdAt;
  
  return self;
}

+(void) syncStrategies {
  PFQuery *query = [PFQuery queryWithClassName:@"Strategies"];
  [query orderByAscending:@"objectId"];
  [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    BOOL changesWereMade = NO;
    int newerStrategies = NO;
    NSArray *strategies = [Strategy findAllSortedBy:@"parseId" ascending:YES];
    if (!error) {
      for (PFObject *object in objects) {
        BOOL foundIt = NO;
        for (Strategy *strat in strategies) {
          if ([strat.parseId isEqualToString:object.objectId]) {
            foundIt = YES;
            NSComparisonResult result = [strat.updatedAt compare:object.updatedAt];
            switch (result) {
              case NSOrderedSame:
                break;
                
              case NSOrderedAscending:
                changesWereMade = YES;
                newerStrategies++;
                (void) [strat initWithPFObject:object];
                break;
                
              case NSOrderedDescending:
                break;
                
              default:
                NSLog(@"WTF: Dates on the strategy don't make any sense.");
                break;
            }
          }
        }
        if(!foundIt) {
          newerStrategies++;
          changesWereMade = YES;
          (void) [[Strategy createEntity] initWithPFObject:object];
        }
      }
      if (newerStrategies) {
        [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
          NSLog(@"Saved %d newer strategies...", newerStrategies);
        }];
      }
      if (changesWereMade) {
        [AppData appState].strategies = [Strategy findAllSortedBy:@"name" ascending:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:kUpdatedStrategyList object:nil];
      }
    }
  }];
}

@end
