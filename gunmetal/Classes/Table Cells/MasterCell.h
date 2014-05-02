//
//  MasterCell.h
//  gunmetal
//
//  Created by Valentin on 5/13/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel* titleLabel;

@property (nonatomic, strong) IBOutlet UILabel* textLabel;

@property (nonatomic, strong) IBOutlet UIImageView* disclosureImageView;

@property (nonatomic, strong) IBOutlet UIImageView* avatarImageView;

@property (nonatomic, strong) IBOutlet UIImageView* bgImageView;

@end
