//
//  iPhoneControlsController.m
//  gunmetal
//
//  Created by Valentin on 5/13/122.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import "iPhoneControlsController.h"
#import "STSegmentedControl.h"
#import "RCSwitchOnOff.h"
#import "PopoverDemoController.h"
#import "CustomPopoverBackgroundView.h"
#import "SampleSegment.h"
#import <QuartzCore/QuartzCore.h>

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 140;

CGFloat animatedDistance;

@implementation iPhoneControlsController
@synthesize nativePB;

@synthesize progressBar, slider, scrollView, textInput;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage tallImageNamed:@"navbar-button.png"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(1, 1, 29, 29);
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = btnItem;
    
    UIColor* bgColor = [UIColor colorWithPatternImage:[UIImage tallImageNamed:@"bg.png"]];
    [self.view setBackgroundColor:bgColor];
    
    CALayer* shadowLayer = [self createShadowWithFrame:CGRectMake(0, 0, 320, 5)];
    
    [self.view.layer addSublayer:shadowLayer];
    
    
    self.progressBar = [[ADVPopoverProgressBar alloc] initWithFrame:CGRectMake(10, 30, 300, 24) andProgressBarColor:ADVProgressBarBlue];     
    [progressBar setProgress:0.5f];   
    [scrollView addSubview:progressBar];
    
    
    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 100, 300, 24)];
    [slider setMaximumValue:1.0];
    [slider setMinimumValue:0.0];
    [slider setValue:0.5f];
    [slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [scrollView addSubview:slider];
    
    
    RCSwitchOnOff* onSwitch = [[RCSwitchOnOff alloc] initWithFrame:CGRectMake(70, 150, 80, 36)];
    [onSwitch setOn:YES];
    
    [scrollView addSubview:onSwitch];
    
    RCSwitchOnOff* offSwitch = [[RCSwitchOnOff alloc] initWithFrame:CGRectMake(180, 150, 80, 36)];
    [offSwitch setOn:NO];
    
    [scrollView addSubview:offSwitch];
    
    
    NSArray *objects = @[@"Yes", @"No", @"Maybe"];
    SampleSegment *segment = [[SampleSegment alloc] init];
    segment.titles = objects;
	segment.frame = CGRectMake(40, 210, 250, 45);
	[scrollView addSubview:segment];
    
    textInput.delegate = self;
    [textInput setReturnKeyType:UIReturnKeyDone];
    textInput.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
    textInput.leftViewMode = UITextFieldViewModeAlways;
    
    [super viewDidLoad];
}


-(IBAction)valueChanged:(id)sender {
    if([sender isKindOfClass:[UISlider class]])
    {
        UISlider *s = (UISlider*)sender;
        
        if(s.value >= 0.0 && s.value <= 1.0)
        {
            [progressBar setProgress:s.value];
            [self.nativePB setProgress:s.value];
        }
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGRect textFieldRect = [self.scrollView.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.scrollView.window convertRect:self.scrollView.bounds fromView:self.scrollView];
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation = 
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.scrollView.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.scrollView setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    CGRect viewFrame = self.scrollView.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.scrollView setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
    [self setNativePB:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

@end
