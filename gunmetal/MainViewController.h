//
//  MainViewController.h
//  TradeTracker
//
//  Created by Wilkie, Rich on 3/23/14.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "DatePickerViewController.h"

@interface MainViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UIToolbar *bottomToolbar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *displaySegmentedControl;
@property UIPopoverController *filterPopoverController;
@property (weak, nonatomic) IBOutlet UIToolbar *topToolbar;
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;
@property (weak, nonatomic) IBOutlet UIButton *navBackButton;
@property (weak, nonatomic) IBOutlet UIView *detailContainer;

-(void) togglePopover;
-(void) pushNavButtonTitle: (NSString *) title;
-(void) popNavButtonTitle;
-(void) pushTopTitle: (NSString *) title;
-(void) popTopTitle;

-(UIViewController *) makeDetailsViewControllerActive: (NSString *) name;

@end
