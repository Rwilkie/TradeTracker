//
//  FilterPopoverViewController.h
//  TradeTracker
//
//  Created by Wilkie, Rich on 3/23/14.
//
//

#import <UIKit/UIKit.h>
#import "TradeFilter.h"
#import "DatePickerViewController.h"

@interface FilterPopoverViewController : UIViewController <UIPopoverControllerDelegate, DatePickerPopover>

@property (weak, nonatomic) IBOutlet UIButton *chooseAccountsButton;
@property (weak, nonatomic) IBOutlet UIButton *chooseStrategiesButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tradeStatusSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *profitabilitySegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *minProfitInput;
@property (weak, nonatomic) IBOutlet UILabel *accountsLabel;
@property (weak, nonatomic) IBOutlet UILabel *strategiesLabel;
@property (weak, nonatomic) IBOutlet UITextField *openDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *closeDateTextField;

@end
