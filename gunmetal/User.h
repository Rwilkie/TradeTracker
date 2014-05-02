//
//  User.h
//  TradeTracker
//
//  Created by Wilkie, Rich on 4/19/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Account, Comments, Trade, TradeTeam;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * familyName;
@property (nonatomic, retain) NSString * givenName;
@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) NSString * parseId;
@property (nonatomic, retain) NSString * picURL;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSSet *accounts;
@property (nonatomic, retain) NSSet *comments;
@property (nonatomic, retain) NSSet *originatedTrades;
@property (nonatomic, retain) NSSet *tradeTeams;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addAccountsObject:(Account *)value;
- (void)removeAccountsObject:(Account *)value;
- (void)addAccounts:(NSSet *)values;
- (void)removeAccounts:(NSSet *)values;

- (void)addCommentsObject:(Comments *)value;
- (void)removeCommentsObject:(Comments *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

- (void)addOriginatedTradesObject:(Trade *)value;
- (void)removeOriginatedTradesObject:(Trade *)value;
- (void)addOriginatedTrades:(NSSet *)values;
- (void)removeOriginatedTrades:(NSSet *)values;

- (void)addTradeTeamsObject:(TradeTeam *)value;
- (void)removeTradeTeamsObject:(TradeTeam *)value;
- (void)addTradeTeams:(NSSet *)values;
- (void)removeTradeTeams:(NSSet *)values;

+ (NSString *) MR_entityName;

@end
