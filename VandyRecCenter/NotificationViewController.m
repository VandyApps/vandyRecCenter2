//
//  NotificationViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "NotificationViewController.h"
#import "NotificationCollection.h"

@implementation NotificationViewController

@synthesize tableView = _tableView;
@synthesize HUD = _HUD;
@synthesize colorMap = _colorMap;


#pragma mark - Static Variables
static CGFloat CellHeight = 200;

static NSUInteger contentViewTag = 1;
static NSUInteger titleLabelTag = 2;
static NSUInteger iconViewTag = 3;
static NSUInteger textBodyTag = 4;

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

- (void) viewDidLoad {
    
    self.HUD = [MBProgressHUD showHUDAddedTo: self.tableView animated: YES];
    self.HUD.mode = MBProgressHUDModeIndeterminate;
    self.HUD.labelText = @"Loading";
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NotificationCollection* collection = [NotificationCollection sharedInstance];
    collection.delegate = self;
    
    [collection initialImport];
    
}


- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Delegate

#pragma mark - Table View Datasource
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellID = @"notificationCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    UIView* contentView = [self getContentViewForCell: cell];
    [(UIImageView*) [contentView viewWithTag: iconViewTag] setImage: [UIImage imageNamed: @"354-newspaper.png"]];
    Notification* notification = [[NotificationCollection sharedInstance].items objectAtIndex: indexPath.row];
    
    [(UILabel*) [contentView viewWithTag: titleLabelTag] setText: @"NEWS"];
    [(UITextView*) [contentView viewWithTag: textBodyTag] setText: notification.message];
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[NotificationCollection sharedInstance] count];
}


- (UIView*) getContentViewForCell: (UITableViewCell*) cell {
    
    
    static CGFloat cellVerticalPadding = 10;
    static CGFloat cellHorizontalPadding = 10;
    static CGFloat iconDimensions = 30;
    static CGFloat iconToLabelPadding = 5;
    static CGFloat titleLabelPadding = 10;
    
    if ([cell viewWithTag: contentViewTag]) {
        return [cell viewWithTag: contentViewTag];
    }
    
    UIView* contentView = [[UIView alloc] initWithFrame: CGRectMake(cellHorizontalPadding, cellVerticalPadding, self.tableView.frame.size.width - 2 * cellHorizontalPadding, CellHeight - 2*cellVerticalPadding)];
    
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.cornerRadius = 12.0f;
    gradient.frame = contentView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor, (id)[UIColor whiteColor].CGColor, (id) [UIColor whiteColor].CGColor, vanderbiltGold.CGColor, nil];
    [contentView.layer insertSublayer:gradient atIndex:0];

    UIImageView* icon = [[UIImageView alloc] initWithFrame: CGRectMake(contentView.frame.size.width - 10 - iconDimensions, 10, iconDimensions, iconDimensions)];
    
    icon.tag = iconViewTag;
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(titleLabelPadding, 10, contentView.frame.size.width - 10 - iconToLabelPadding - iconDimensions - titleLabelPadding, iconDimensions)];
    titleLabel.font = [UIFont systemFontOfSize: 20];
    titleLabel.tag = titleLabelTag;
    titleLabel.backgroundColor = [UIColor clearColor];
    
    UITextView* textBody = [[UITextView alloc] initWithFrame: CGRectMake(10, iconDimensions + 10 + 10, contentView.frame.size.width - 2 * 10, contentView.frame.size.height - iconDimensions - 10 - 10- 10)];
    textBody.tag = textBodyTag;
    textBody.userInteractionEnabled = NO;
    textBody.showsHorizontalScrollIndicator = NO;
    textBody.showsVerticalScrollIndicator = NO;
    textBody.backgroundColor = [UIColor clearColor];
    textBody.font = [UIFont systemFontOfSize: 15];
    contentView.layer.cornerRadius = 5.f;
    
    
    [contentView addSubview: icon];
    [contentView addSubview: titleLabel];
    [contentView addSubview: textBody];
    
    [cell addSubview: contentView];
    
    
    return contentView;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellHeight;
}

#pragma mark - Notification Delegate

- (void) notificationAdded:(Notification *)notification atIndex:(NSUInteger)index {

}

- (void) notificationRemoved:(Notification *)notification fromIndex:(NSUInteger)index {

}

- (void) collectionCompletedInitialImport:(NotificationCollection *) collection {
    
    [self.HUD hide: YES];
    [self.tableView reloadData];
}






@end
