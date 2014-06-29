//
//  FSTableViewCell.h
//  GoogleNews
//
//  Created by Admin on 29.06.14.
//  Copyright (c) 2014 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
