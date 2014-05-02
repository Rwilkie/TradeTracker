//
//  Stack.h
//  TradeTracker
//
//  Created by Wilkie, Rich on 4/26/14.
//
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject <NSFastEnumeration>

@property (nonatomic, assign, readonly) NSUInteger count;

- (id)initWithArray:(NSArray*)array;

- (void)pushObject:(id)object;
- (void)pushObjects:(NSArray*)objects;
- (id)popObject;
- (id)peekObject;

@end
