//
//  FSGeneralTableViewController.m
//  GoogleNews
//
//  Created by Admin on 29.06.14.
//  Copyright (c) 2014 Sky. All rights reserved.
//

#import "FSGeneralTableViewController.h"
#import "FSTableViewCell.h"
#import "FSData.h"
#import "FSDetailViewController.h"

#define newsArray [[FSData sharedData] allNews]

@interface FSGeneralTableViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (assign) BOOL busy;

@end


@implementation FSGeneralTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _navItem.title = _channel[@"channel"];
    _busy = NO;
    [self parseData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refreshButtonDidPressed:(id)sender
{
    [self parseData];
}

- (void)parseData
{
    if (_busy) {
        return;
    }
    _busy = YES;
    [newsArray removeAllObjects];
    //parse in background
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    dispatch_async(queue, ^{
        [[FSData sharedData] parseAtUrl:[NSURL URLWithString:_channel[@"url"]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [self.tableView reloadData];
            _busy = NO;
        });
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [newsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"NewsHeaderCell";
    FSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    cell.headerLabel.text = [newsArray[indexPath.row] objectForKey:@"title"];
    cell.dateLabel.text = [newsArray[indexPath.row] objectForKey:@"pubDate"];
    //picture
    NSString *pictureUrl = [[NSString alloc] init];
    pictureUrl = [newsArray[indexPath.row] objectForKey:@"picture"];
    if (![pictureUrl  isEqual: @"null"]) {
        NSURL *url = [NSURL URLWithString:[newsArray[indexPath.row] objectForKey:@"picture"]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        cell.picture.image = img;
    } else {
        cell.picture.image = [UIImage imageNamed:@"noImage"];
    }
    return cell;
}

#pragma mark prepare for segue

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"detail"]) {
        NSIndexPath *index = [self.tableView indexPathForSelectedRow];
        [[segue destinationViewController] setItem:newsArray[index.row]];
    }
}

@end
