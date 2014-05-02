//
//  PopoverSegment.m
//  gunmetal
//
//  Created by Valentin Filip on 3/25/12.
//  Copyright (c) 2012 App Design Vault. All rights reserved.
//

#import "SampleSegment.h"
#import "AppDelegate.h"

#define BUTTON_WIDTH 155.0
#define BUTTON_SEGMENT_WIDTH 155.0
#define CAP_WIDTH 20.0

@interface SampleSegment ()

@property (nonatomic, strong)   CustomSegmentedControl  *segments;

- (UIButton *)buttonForIndex:(NSUInteger)segmentIndex;

@end

@implementation SampleSegment

@synthesize titles;
@synthesize delegate;
@synthesize segments;

- (void)layoutSubviews {
  [super layoutSubviews];
  CGFloat viewWidth = self.bounds.size.width;

  if (!self.segments) {
    self.segments = [[CustomSegmentedControl alloc] initWithSegmentCount:titles.count
                                                            dividerImage:nil tag:0
                                                                delegate:self];
    self.segments.frame = CGRectMake(0, 0, viewWidth, 51);
    [self addSubview:self.segments];
  }

}

- (UIButton *)buttonForIndex:(NSUInteger)segmentIndex {
  UIImage* buttonImage = nil;
  UIImage* buttonPressedImage = nil;
  NSUInteger buttonWidth = 0;
  buttonWidth = 65;

  NSString *position = @"middle";
  if (segmentIndex == 0) {
    position = @"left";
  } else if(segmentIndex == self.titles.count-1) {
    position = @"right";
  }

  NSString *imgName = [NSString stringWithFormat:@"segment-normal-%@.png", position, nil];
  NSString *imgNameSelected = [NSString stringWithFormat:@"segment-selected-%@.png", position, nil];
  buttonImage = [[UIImage tallImageNamed:imgName] stretchableImageWithLeftCapWidth:CAP_WIDTH topCapHeight:0.0];
  buttonPressedImage = [[UIImage tallImageNamed:imgNameSelected] stretchableImageWithLeftCapWidth:CAP_WIDTH topCapHeight:0.0];

  UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.frame = CGRectMake(0.0, 0.0, buttonWidth, buttonImage.size.height);
  button.titleLabel.font = [UIFont boldSystemFontOfSize: 15.0f];
  [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
  [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
  [button setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
  [button setTitleShadowColor:[UIColor blackColor] forState:UIControlStateHighlighted];
  [button setTitleShadowColor:[UIColor blackColor] forState:UIControlStateSelected];
  button.titleLabel.shadowOffset = CGSizeMake(0,1);

  [button setTitle:(self.titles)[segmentIndex] forState:UIControlStateNormal];
  [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
  [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
  [button setBackgroundImage:buttonPressedImage forState:UIControlStateSelected];
  button.adjustsImageWhenHighlighted = NO;

  return button;

}

- (UIButton *)buttonFor:(CustomSegmentedControl *)segmentedControl atIndex:(NSUInteger)segmentIndex {
  UIButton* button = [self buttonForIndex:segmentIndex];
  if (segmentIndex == 0)
    button.selected = YES;
  return button;
}

- (void)touchDownAtSegmentIndex:(NSUInteger)segmentIndex {
  [self.delegate selectedSegmentAtIndex:segmentIndex];
}

@end
