//
//  FSDetailViewController.h
//  GoogleNews
//
//  Created by Admin on 29.06.14.
//  Copyright (c) 2014 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (strong, nonatomic) NSMutableDictionary *item; //the item
@property (weak, nonatomic) IBOutlet UIWebView *itemWebView;
//give an item?

@end
