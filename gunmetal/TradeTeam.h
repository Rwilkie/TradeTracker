//
//  TradeTeam.h
//  TradeTracker
//
//  Created by Wilkie, Rich on 4/19/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comments, Trade, User;

@interface TradeTeam : NSManagedObject

@property (nonatomic, retain) NSString * miniDescription;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * parseId;
@property (nonatomic, retain) NSNumber * publicTeam;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSSet *comments;
@property (nonatomic, retain) NSSet *members;
@property (nonatomic, retain) NSSet *trades;
@end

@interface TradeTeam (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(Comments *)value;
- (void)removeCommentsObject:(Comments *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

- (void)addMembersObject:(User *)value;
- (void)removeMembersObject:(User *)value;
- (void)addMembers:(NSSet *)values;
- (void)removeMembers:(NSSet *)values;

- (void)addTradesObject:(Trade *)value;
- (void)removeTradesObject:(Trade *)value;
- (void)addTrades:(NSSet *)values;
- (void)removeTrades:(NSSet *)values;

@end
