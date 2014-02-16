//
//  HomeViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 11/29/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "HomeViewController.h"

#import "NotificationCollection.h"


@interface HomeViewController ()

@end

@implementation HomeViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style: UITableViewStylePlain];
    
    self.title = @"The Rec";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview: self.tableView];
    
    [NotificationCollection sharedInstance].delegate = self;
    [[NotificationCollection sharedInstance] initialImport];
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
    cell.textLabel.text = @"THis is a cell";
    return cell;
}

#pragma mark - TableView Delegate


#pragma mark - Notification Delegate

- (void) collectionCompletedInitialImport:(NotificationCollection*) collection
{
    
    [self.tableView reloadData];
}




@end
