//
//  Strategy.h
//  TradeTracker
//
//  Created by Wilkie, Rich on 4/19/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Trade;
@class PFObject;

@interface Strategy : NSManagedObject

@property (nonatomic, retain) NSNumber * howBullish;
@property (nonatomic, retain) NSString * howItCanLooseMoney;
@property (nonatomic, retain) NSString * howItMakesMoney;
@property (nonatomic, retain) NSNumber * maxIVRank;
@property (nonatomic, retain) NSNumber * minIVRank;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * parseId;
@property (nonatomic, retain) NSDate   * updatedAt;
@property (nonatomic, retain) NSDate   * createdOn;
@property (nonatomic, retain) NSSet    * trades;
@property (nonatomic, retain) NSString * miniDescription;

@end

@interface Strategy (CoreDataGeneratedAccessors)

- (void)addTradesObject:(Trade *)value;
- (void)removeTradesObject:(Trade *)value;
- (void)addTrades:(NSSet *)values;
- (void)removeTrades:(NSSet *)values;

+(void) syncStrategies;

-(Strategy *) initWithPFObject: (PFObject *) pfObject;

@end
