//
//  MainMenuViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "MainMenuViewController.h"



@interface MainMenuViewController ()


@end

@implementation MainMenuViewController

@synthesize tableView = _tableView;
@synthesize mainMenu = _mainMenu;
@synthesize mainMenuIcons = _mainMenuIcons;

#pragma mark - Getters
- (NSArray*) mainMenu {
    if (_mainMenu == nil) {
        return @[@"HOME", @"HOURS", @"TRAFFIC", @"GROUP FITNESS", @"INTRAMURALS", @"PROGRAMS", @"MAP"];
    }
    return _mainMenu;
}

- (NSArray*) mainMenuIcons {
    if (_mainMenuIcons == nil) {
        _mainMenuIcons = @[[UIImage imageNamed:@"53-house.png"], [UIImage imageNamed: @"11-clock.png"], [UIImage imageNamed: @"112-group.png"], [UIImage imageNamed: @"63-runner.png"], [UIImage imageNamed: @"374-basketball.png"],[UIImage imageNamed: @"83-calendar.png"],  [UIImage imageNamed: @"103-map.png"]];
    }
    return _mainMenuIcons;
}

#pragma mark - Lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = vanderbiltGold;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View DataSource
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"mainMenuCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //add the text label
    [(UILabel*) [cell viewWithTag: 2] setText: [self.mainMenu objectAtIndex: indexPath.row]];
    //add the icon
    [(UIImageView*) [cell viewWithTag: 1] setImage: [self.mainMenuIcons objectAtIndex: indexPath.row]];
    //color the cell
    cell.backgroundColor = (indexPath.row %2) ? cellColor1 : cellColor2;
    return cell;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mainMenu.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"MAIN MENU";
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate didSelectedControllerWithTitle: [self.mainMenu objectAtIndex: indexPath.row] atIndex:indexPath.row];
    
}


@end
