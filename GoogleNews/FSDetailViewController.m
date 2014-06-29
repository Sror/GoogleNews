//
//  FSDetailViewController.m
//  GoogleNews
//
//  Created by Admin on 29.06.14.
//  Copyright (c) 2014 Sky. All rights reserved.
//

#import "FSDetailViewController.h"

@interface FSDetailViewController ()

@end

@implementation FSDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _navItem.title = @"Item";
    _itemWebView.scalesPageToFit = YES; //gesture pinch to zoom
    [_itemWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[_item objectForKey:@"link"]]]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
