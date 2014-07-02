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

@interface FSGeneralTableViewController ()

@property (strong, nonatomic) FSData *data;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;

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
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _data = [[FSData alloc] init];
    _navItem.title = _channel[@"channel"];
    [_data parseAtUrl:[NSURL URLWithString:_channel[@"url"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refreshButtonDidPressed:(id)sender
{
    [_data parseAtUrl:[NSURL URLWithString:_channel[@"url"]]];
    [self.tableView reloadData];
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
    return [_data.news count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"NewsHeaderCell";
    FSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    cell.headerLabel.text = [_data.news[indexPath.row] objectForKey:@"title"];
    cell.dateLabel.text = [_data.news[indexPath.row] objectForKey:@"pubDate"];
    //picture
    NSString *pictureUrl = [[NSString alloc] init];
    pictureUrl = [_data.news[indexPath.row] objectForKey:@"picture"];
    if (![pictureUrl  isEqual: @"null"]) {
        NSURL *url = [NSURL URLWithString:[_data.news[indexPath.row] objectForKey:@"picture"]];
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
        [[segue destinationViewController] setItem:_data.news[index.row]];
    }
}

@end
