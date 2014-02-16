//
//  HomeViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 11/29/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "HomeViewController.h"

#import "NotificationCollection.h"

#import "UIScrollView+ParallaxEffect.h"
#import "MBProgressHUD.h"

@interface HomeViewController ()

@property (nonatomic, strong) MBProgressHUD* HUD;

@end

@implementation HomeViewController

#pragma mark - Static Variables

static CGFloat cellHeight = 160.f;
static NSInteger cellNotificationTitleLabelTag = 1;
static NSInteger cellNotificationMessageLabelTag = 2;
static NSInteger cellNotificationIconLabelTag = 3;

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style: UITableViewStylePlain];
    
    self.title = @"The Rec";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UIImage* recImage = [self imageWithImage: [UIImage imageNamed: @"rec.jpg"] scaledToSize: CGSizeMake(self.view.frame.size.width, 300)];
    UIImageView* parallaxView = [[UIImageView alloc] initWithImage: recImage];
    
    [self.tableView addBackgroundView:
     parallaxView withWindowHeight: 200
                    dragDistanceLimit: 0
                       parallaxFactor: .25];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview: self.tableView];
    
    [NotificationCollection sharedInstance].delegate = self;
    [[NotificationCollection sharedInstance] initialImport];
    
    self.HUD = [MBProgressHUD showHUDAddedTo: self.tableView animated: YES];
    self.HUD.mode = MBProgressHUDModeIndeterminate;
    self.HUD.labelText = @"Loading...";
}


#pragma mark - TableView Datasource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [NotificationCollection sharedInstance].count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellID = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    #warning - Change this to present images of other types of notifications too
    
    Notification* notification = [NotificationCollection sharedInstance].items[indexPath.row];

    UILabel* cellNotificationTitleLabel;
    UILabel* cellNotificationMessageLabel;
    UIImageView* cellNotificationIconLabel;
    
    if (!(cellNotificationTitleLabel = (UILabel*) [cell viewWithTag: cellNotificationTitleLabelTag]))
    {
        cellNotificationTitleLabel = [[UILabel alloc] initWithFrame: CGRectMake(50, 10, 200, 30)];
        cellNotificationTitleLabel.tag = cellNotificationTitleLabelTag;
        
        [cell addSubview: cellNotificationTitleLabel];
    }
    
    cellNotificationTitleLabel.text = @"NEWS";
    
    if (!(cellNotificationMessageLabel = (UILabel*) [cell viewWithTag: cellNotificationMessageLabelTag]))
    {
        cellNotificationMessageLabel = [[UILabel alloc] initWithFrame: CGRectMake(15, 40, self.view.frame.size.width - 15 - 10, cellHeight - 50 - 5)];
        cellNotificationMessageLabel.tag = cellNotificationMessageLabelTag;
        cellNotificationMessageLabel.numberOfLines = 4;
        
        [cell addSubview: cellNotificationMessageLabel];
    }
    
    cellNotificationMessageLabel.text = notification.message;
    
    if (!(cellNotificationIconLabel = (UIImageView*) [cell viewWithTag: cellNotificationIconLabelTag]))    {

        cellNotificationIconLabel = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"354-newspaper.png"]];
        cellNotificationIconLabel.frame = CGRectMake(10, 15, 30, 30);
        cellNotificationIconLabel.tag = cellNotificationIconLabelTag;
        [cell addSubview: cellNotificationIconLabel];
    }

    return cell;
}

#pragma mark - Table View Dimension

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

#pragma mark - TableView Delegate


#pragma mark - Notification Delegate

- (void) collectionCompletedInitialImport:(NotificationCollection*) collection
{
    [self.HUD hide: YES];
    [self.tableView reloadData];
}


- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
