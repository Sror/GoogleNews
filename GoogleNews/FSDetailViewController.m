//
//  FSDetailViewController.m
//  GoogleNews
//
//  Created by Admin on 29.06.14.
//  Copyright (c) 2014 Sky. All rights reserved.
//

#import "FSDetailViewController.h"

@interface FSDetailViewController () <UIWebViewDelegate> {
    int _webViewFramesLoad; //there are many frames on page. I decided to count these frames to prevent blinking of activity indicator
}

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
    _navItem.title = @"Detail";
    NSURL *url = [NSURL URLWithString:[_item objectForKey:@"link"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_itemWebView setDelegate:self];
    [_itemWebView loadRequest:request];
    _itemWebView.scalesPageToFit = YES; //gesture pinch to zoom
    _activityIndicator.hidesWhenStopped = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [_itemWebView loadHTMLString:@"" baseURL:nil]; //just in case
    [super viewDidDisappear:animated];
}

#pragma mark UIWebViewDelegate methods

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //if the some frame failed to load - then something is wrong with the page
    //now calm down and stop activity indicator
    _webViewFramesLoad--;
    [_activityIndicator stopAnimating];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [_activityIndicator startAnimating]; //start animating indicator
    _webViewFramesLoad++;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    _webViewFramesLoad--;
    if (_webViewFramesLoad <= 0) {
        [_activityIndicator stopAnimating]; //stop animation only when all frames has been loaded
    }
}

@end
