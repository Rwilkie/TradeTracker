//
//  iPhoneElementsController.m
//  gunmetal
//
//  Created by Valentin on 5/13/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import "iPhoneElementsController.h"

#import "Utils.h"
#import "iPhoneElementsController.h"
#import "AccountCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation iPhoneElementsController



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CALayer* shadowLayer = [self createShadowWithFrame:CGRectMake(0, 0, 320, 5)];
    [self.view.layer addSublayer:shadowLayer];
    
    UIColor* bgColor = [UIColor colorWithPatternImage:[UIImage tallImageNamed:@"bg.png"]];
    [self.view setBackgroundColor:bgColor];
}

-(CALayer *)createShadowWithFrame:(CGRect)frame {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = frame;
    
    
    UIColor* lightColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    UIColor* darkColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    gradient.colors = @[(id)darkColor.CGColor, (id)lightColor.CGColor];
    
    return gradient;
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
