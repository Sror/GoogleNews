//
//  FSChannelsTableViewController.m
//  GoogleNews
//
//  Created by Admin on 01.07.14.
//  Copyright (c) 2014 Sky. All rights reserved.
//

#import "FSChannelsTableViewController.h"
#import "FSGeneralTableViewController.h"

static

@interface FSChannelsTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *channels;
@property (strong, nonatomic) UIAlertView *alert;

@end


@implementation FSChannelsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _channels = @[@{@"channel": @"Top Stories",             @"url": @"http://news.google.ru/news?cf=all&ned=ru_ua&hl=ru&output=rss"},
                  @{@"channel": @"World",                   @"url": @"http://news.google.ru/news?cf=all&ned=ru_ua&hl=ru&topic=w&output=rss"},
                  @{@"channel": @"Ukraine",                 @"url": @"http://news.google.ru/news?cf=all&ned=ru_ua&hl=ru&topic=n&output=rss"},
                  @{@"channel": @"Business",                @"url": @"http://news.google.ru/news?cf=all&ned=ru_ua&hl=ru&topic=b&output=rss"},
                  @{@"channel": @"Science and technology",  @"url": @"http://news.google.ru/news?cf=all&ned=ru_ua&hl=ru&topic=t&output=rss"},
                  ];
    self.navigationItem.title = @"GoogleNews";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark prepare for segue

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"selectedChannel"]) {
        NSIndexPath *index = [self.tableView indexPathForSelectedRow];
        [[segue destinationViewController] setChannel:_channels[index.row]];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_channels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"channelsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = _channels[indexPath.row][@"channel"];
    return cell;
}

@end
