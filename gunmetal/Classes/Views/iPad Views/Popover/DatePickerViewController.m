//
//  datePickerViewController.m
//  TradeTracker
//
//  Created by Wilkie, Rich on 4/27/14.
//
//

#import "DatePickerViewController.h"
#import "FilterPopoverViewController.h"

@interface DatePickerViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *datePickerTitle;
@end

@implementation DatePickerViewController

#pragma mark - ViewController lifecycle

-(void) viewWillAppear:(BOOL)animated {
  [self.datePicker setDate:(self.initialDate ? self.initialDate : [NSDate date])];
  [self.datePickerTitle setText:(self.popoverTitle ? self.popoverTitle : @"Choose a date...")];
}

#pragma mark - User Controls

- (IBAction)todayPressed:(id)sender {
  [self.datePicker setDate:[NSDate date] animated:YES];
}

- (IBAction)donePressed:(id)sender {
  [self.delegate datePickerDone:[self.datePicker date]];
}

- (IBAction)cancelPressed:(id)sender {
  [self.delegate datePickerCancelled];
}

@end
