//
//  Comments.h
//  TradeTracker
//
//  Created by Wilkie, Rich on 4/19/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Trade, TradeTeam, User;

@interface Comments : NSManagedObject

@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * parseId;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) User *owner;
@property (nonatomic, retain) TradeTeam *team;
@property (nonatomic, retain) Trade *trade;

@end
