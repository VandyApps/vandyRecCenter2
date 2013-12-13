//
//  GFFavoritesViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 12/12/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "GFFavoritesViewController.h"

#import "GFFavorites.h"

@interface GFFavoritesViewController ()

@end

@implementation GFFavoritesViewController


@synthesize headerView = _headerView;
@synthesize tableView = _tableView;

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.headerView.backgroundColor = vanderbiltGold;
	// Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated {
    [[GFFavorites sharedInstance] sort];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View DataSource

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"GFFavoritesCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [[[GFFavorites sharedInstance] GFFavoriteForIndex: indexPath.row].GFClass objectForKey: @"className"];
    
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [GFFavorites sharedInstance].count;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}

#pragma mark - Table View Delegate

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
#warning Complete deletion logic
        
    }
}

#pragma mark - Events

- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated: YES completion:nil];
}

@end
