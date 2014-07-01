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

#define newsArray [[FSData sharedData] fetchData]

@interface FSGeneralTableViewController ()

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
    //<channel>Главные новости – Новости Google
    _navItem.title = @"General news";
    [[FSData sharedData] parseAtUrl:[NSURL URLWithString:@"https://news.google.com/news/feeds?pz=1&cf=all&ned=ru_ua&hl=ru&output=rss"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refreshButtonDidPressed:(id)sender
{
    [[FSData sharedData] parseAtUrl:[NSURL URLWithString:@"https://news.google.com/news/feeds?pz=1&cf=all&ned=ru_ua&hl=ru&output=rss"]];
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
    return [[[FSData sharedData] fetchData] count];
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
    //url = [NSURL URLWithString:[_data.news[indexPath.row] objectForKey:@"link"]];
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
