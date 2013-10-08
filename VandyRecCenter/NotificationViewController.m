//
//  NotificationViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "NotificationViewController.h"
@interface NotificationViewController ()

@end

@implementation NotificationViewController

@synthesize tableView = _tableView;
@synthesize HUD = _HUD;
@synthesize colorMap = _colorMap;

#pragma mark - Getters

- (NSArray*) colorMap {
    if (!_colorMap) {
        _colorMap = @[vanderbiltGold, [UIColor blueColor], [UIColor darkGrayColor], [UIColor greenColor]];
    }
    return _colorMap;
}

#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [NotificationCollection sharedInstance].delegate = self;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear: YES];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.HUD = [MBProgressHUD showHUDAddedTo: self.tableView animated: YES];
    self.HUD.mode = MBProgressHUDModeIndeterminate;
    self.HUD.labelText = @"Loading";
    [[NotificationCollection sharedInstance] initialImport];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"notificationCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    Notification* notification = [[NotificationCollection sharedInstance].items objectAtIndex: indexPath.row];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    UIView* contentView = [cell viewWithTag: CELL_CONTENTVIEW_TAG];
    UIView* messageContainer = [cell viewWithTag: CELL_MESSAGE_CONTRAINER_TAG];
    //make sure that the colors are set correctly
    cell.backgroundColor = [UIColor clearColor];
    //contentView.backgroundColor = (indexPath.row%2) ? cellColor1 : cellColor2;
    
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.cornerRadius = 12.0f;
    gradient.frame = contentView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor, (id)[UIColor whiteColor].CGColor, (id) [UIColor whiteColor].CGColor, vanderbiltGold.CGColor, nil];
    [contentView.layer insertSublayer:gradient atIndex:0];
    //style the content view
    contentView.layer.cornerRadius = 12.0f;
    contentView.backgroundColor = [UIColor whiteColor];
    
    //set title of the cell, message and icon of the cell
    [(UILabel*) [cell viewWithTag: CELL_HEADER_TAG] setText: @"NEWS"];
    [(UILabel*) [cell viewWithTag: CELL_HEADER_TAG] setFont: [UIFont fontWithName: @"TrebuchetMS-Bold" size: 18]];
    
    [(UITextField*) [cell viewWithTag: CELL_MESSAGE_TAG] setFont: [UIFont fontWithName: @"Verdana" size: 12]];
    [(UITextField*) [cell viewWithTag: CELL_MESSAGE_TAG] setText: notification.message];
    [(UIImageView*) [cell viewWithTag: CELL_ICON_TAG] setImage: [UIImage imageNamed: @"354-newspaper"]];
    
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, 0, messageContainer.frame.size.width, 1.0f);
    topBorder.backgroundColor = vanderbiltGold.CGColor;
    [messageContainer.layer addSublayer:topBorder];
    
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[NotificationCollection sharedInstance] count];
}


#pragma mark - UITableViewDelegate
- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"AT THE REC";
}


#pragma mark - NotificationDelegate
- (void) collectionCompletedInitialImport:(NotificationCollection *)collection {
    [self.tableView reloadData];
    [self.HUD hide: YES];
}

@end
