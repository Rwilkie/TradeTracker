//
//  Transaction.h
//  TradeTracker
//
//  Created by Wilkie, Rich on 4/19/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Equity, Trade;

@interface Transaction : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSDate * expirationDate;
@property (nonatomic, retain) NSNumber * impliedVolAtOpen;
@property (nonatomic, retain) NSString * miniDescription;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * parseId;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * quantity;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) Equity *equity;
@property (nonatomic, retain) Trade *trade;

@end
