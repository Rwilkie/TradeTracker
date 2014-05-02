//
//  Account.h
//  TradeTracker
//
//  Created by Wilkie, Rich on 4/19/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Trade, User;
@class PFObject;

@interface Account : NSManagedObject

@property (nonatomic, retain) NSNumber * balance;
@property (nonatomic, retain) NSDate   * createdOn;
@property (nonatomic, retain) NSNumber * currentInvestmentPercentage;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * parseId;
@property (nonatomic, retain) NSNumber * targetInvestmentPercentage;
@property (nonatomic, retain) NSDate   * updatedAt;
@property (nonatomic, retain) User     * owner;
@property (nonatomic, retain) NSSet    * trades;
@property (nonatomic, retain) NSString * agency;
@property (nonatomic, retain) NSString * miniDescription;
@end

@interface Account (CoreDataGeneratedAccessors)

- (void)addTradesObject:(Trade *)value;
- (void)removeTradesObject:(Trade *)value;
- (void)addTrades:(NSSet *)values;
- (void)removeTrades:(NSSet *)values;

+ (NSString *) MR_entityName;
+ (void) syncAccounts;

- (Account *) initWithPFObject: (PFObject *) pfObject;

@end
