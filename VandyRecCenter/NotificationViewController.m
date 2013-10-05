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
    self.tableView.backgroundColor = vanderbiltGold;
    [NotificationCollection sharedInstance].delegate = self;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear: YES];
    
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
    
    cell.backgroundColor = (indexPath.row%2) ? cellColor1 : cellColor2;
    
    //set title of the cell, message and icon of the cell
    [(UILabel*) [cell viewWithTag: 1] setText: @"NEWS"];
    [(UITextField*) [cell viewWithTag: 3] setText: notification.message];
    [(UIImageView*) [cell viewWithTag: 2] setImage: [UIImage imageNamed: @"354-newspaper"]];
    
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
