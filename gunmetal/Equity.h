//
//  Equity.h
//  TradeTracker
//
//  Created by Wilkie, Rich on 4/19/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Equity, Price, Transaction;

@interface Equity : NSManagedObject

@property (nonatomic, retain) NSDate * expirationDate;
@property (nonatomic, retain) NSString * miniDescription;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * parseId;
@property (nonatomic, retain) NSString * symbol;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) Equity *derivativeEquities;
@property (nonatomic, retain) NSSet *prices;
@property (nonatomic, retain) NSSet *transactions;
@property (nonatomic, retain) NSSet *underylingEquity;
@end

@interface Equity (CoreDataGeneratedAccessors)

- (void)addPricesObject:(Price *)value;
- (void)removePricesObject:(Price *)value;
- (void)addPrices:(NSSet *)values;
- (void)removePrices:(NSSet *)values;

- (void)addTransactionsObject:(Transaction *)value;
- (void)removeTransactionsObject:(Transaction *)value;
- (void)addTransactions:(NSSet *)values;
- (void)removeTransactions:(NSSet *)values;

- (void)addUnderylingEquityObject:(Equity *)value;
- (void)removeUnderylingEquityObject:(Equity *)value;
- (void)addUnderylingEquity:(NSSet *)values;
- (void)removeUnderylingEquity:(NSSet *)values;

@end
