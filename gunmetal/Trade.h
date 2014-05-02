//
//  Trade.h
//  TradeTracker
//
//  Created by Wilkie, Rich on 4/20/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <Parse/Parse.h>

@class Account, Comments, Strategy, TradeTeam, Transaction, User;

@interface Trade : NSManagedObject

@property (nonatomic, retain) NSNumber * closed;
@property (nonatomic, retain) NSDate * closeDate;
@property (nonatomic, retain) NSString * miniDescription;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * netProfit;
@property (nonatomic, retain) NSDate * openDate;
@property (nonatomic, retain) NSString * parseId;
@property (nonatomic, retain) NSNumber * potentialProfitAtOpen;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) Account *account;
@property (nonatomic, retain) NSString *accountParseId;
@property (nonatomic, retain) NSSet *comments;
@property (nonatomic, retain) User *originator;
@property (nonatomic, retain) Strategy *strategy;
@property (nonatomic, retain) NSString *strategyParseId;
@property (nonatomic, retain) NSSet *tradeTeams;
@property (nonatomic, retain) NSSet *transactions;
@end

@interface Trade (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(Comments *)value;
- (void)removeCommentsObject:(Comments *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

- (void)addTradeTeamsObject:(TradeTeam *)value;
- (void)removeTradeTeamsObject:(TradeTeam *)value;
- (void)addTradeTeams:(NSSet *)values;
- (void)removeTradeTeams:(NSSet *)values;

- (void)addTransactionsObject:(Transaction *)value;
- (void)removeTransactionsObject:(Transaction *)value;
- (void)addTransactions:(NSSet *)values;
- (void)removeTransactions:(NSSet *)values;

- (BOOL) isClosed;
+ (NSString *) MR_entityName;
+ (void) syncTrades;
- (Trade *) initWithPFObject: (PFObject *) pfObject;

@end
