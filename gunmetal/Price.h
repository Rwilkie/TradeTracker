//
//  Price.h
//  TradeTracker
//
//  Created by Wilkie, Rich on 4/19/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Equity;

@interface Price : NSManagedObject

@property (nonatomic, retain) NSNumber * extrinsicValue;
@property (nonatomic, retain) NSString * parseId;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) Equity *equity;

+ (NSString *) MR_entityName;

@end
