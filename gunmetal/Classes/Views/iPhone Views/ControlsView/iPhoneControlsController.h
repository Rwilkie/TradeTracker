//
//  iPhoneControlsController.h
//  gunmetal
//
//  Created by Valentin on 5/13/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADVPopoverProgressBar.h"

@interface iPhoneControlsController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) UISlider* slider;

@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;

@property (nonatomic, strong) ADVPopoverProgressBar *progressBar;

@property (nonatomic, strong) IBOutlet UITextField *textInput;
@property (strong, nonatomic) IBOutlet UIProgressView *nativePB;

-(IBAction)valueChanged:(id)sender;

-(CALayer *)createShadowWithFrame:(CGRect)frame;

@end
