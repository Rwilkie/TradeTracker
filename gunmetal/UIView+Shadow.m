//
//  UIView+Shadow.m
//  TradeTracker
//
//  Created by Wilkie, Rich on 3/23/14.
//
//

#import "UIView+Shadow.h"

@implementation UIView (Shadow)

-(void) addShadow {
  self.layer.shadowOffset = CGSizeMake(10.0, 10.0);
  self.layer.shadowColor = [UIColor whiteColor].CGColor;
  self.layer.shadowRadius = 5.0f;
  self.layer.shadowOpacity = 1.00f;
  self.layer.masksToBounds = NO;
  self.layer.shadowPath = [[UIBezierPath bezierPathWithRect:self.layer.bounds] CGPath];
}
@end
