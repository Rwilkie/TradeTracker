//
//  datePickerViewController.h
//  TradeTracker
//
//  Created by Wilkie, Rich on 4/27/14.
//
//

#import <UIKit/UIKit.h>

@protocol DatePickerPopover <NSObject>
-(void) datePickerCancelled;
-(void) datePickerDone: (NSDate *)date;
@end

@interface DatePickerViewController : UIViewController

@property (nonatomic) NSDate *initialDate;
@property (nonatomic) NSString *popoverTitle;
@property id <DatePickerPopover> delegate;

@end
