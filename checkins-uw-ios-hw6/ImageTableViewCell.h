//
//  ImageTableViewCell.h
//  image-picker-uw-ios-hw5
//
//  Created by Parker, Carl (HBO) on 5/22/15.
//  Copyright (c) 2015 Parker, Carl (HBO). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *tableImage;

@property (weak, nonatomic) IBOutlet UILabel *tableDate;


@end
