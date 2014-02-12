//
//  MainMenuViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "MainMenuViewController.h"

@implementation MainMenuViewController

@synthesize tableView = _tableView;
@synthesize mainMenu = _mainMenu;
@synthesize mainMenuIcons = _mainMenuIcons;


#pragma mark - Static Variables
static CGFloat CellHeight = 60;
static CGFloat SectionHeight = 70;
static CGFloat IconPadding = 15;
static CGFloat IconDimensions = 25;

#pragma mark - Getters
- (NSArray*) mainMenu {
    if (_mainMenu == nil) {
        //return @[@"HOME", @"HOURS", @"TRAFFIC", @"GROUP FITNESS", @"INTRAMURALS", @"PROGRAMS", @"MAP"];
        return @[@"HOME", @"HOURS", @"GROUP FITNESS", @"INTRAMURALS"];
    }
    return _mainMenu;
}

- (NSArray*) mainMenuIcons {
    if (_mainMenuIcons == nil) {
        //_mainMenuIcons = @[[UIImage imageNamed:@"53-house.png"], [UIImage imageNamed: @"11-clock.png"], [UIImage imageNamed: @"112-group.png"], [UIImage imageNamed: @"63-runner.png"], [UIImage imageNamed: @"374-basketball.png"],[UIImage imageNamed: @"83-calendar.png"],  [UIImage imageNamed: @"103-map.png"]];
        
        _mainMenuIcons = @[[UIImage imageNamed:@"53-house.png"], [UIImage imageNamed: @"11-clock.png"],[UIImage imageNamed: @"63-runner.png"], [UIImage imageNamed: @"374-basketball.png"]];
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
    self.tableView.backgroundColor = [UIColor colorWithRed: .8 green:.8 blue:.8 alpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //select home by default
    NSIndexPath *defaultIndexPath = [NSIndexPath indexPathForRow:0 inSection: 0];
    
    
    [self.tableView selectRowAtIndexPath:defaultIndexPath animated: NO scrollPosition:UITableViewScrollPositionNone];
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
    UILabel* titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(IconPadding + IconDimensions + 10, 0, self.tableView.frame.size.width - (IconDimensions + IconPadding + 40), CellHeight)];
    
    titleLabel.text = [self.mainMenu objectAtIndex: indexPath.row];
    titleLabel.textColor = [UIColor whiteColor];
    [cell addSubview: titleLabel];

    //add the icon
    UIImageView* iconView = [[UIImageView alloc] initWithImage: [self.mainMenuIcons objectAtIndex: indexPath.row]];
    iconView.frame = CGRectMake(IconPadding, CellHeight / 2.f - IconDimensions / 2.f, IconDimensions, IconDimensions);
    [cell addSubview: iconView];
    
    
    cell.backgroundColor = (indexPath.row % 2) ? cellColor1 : cellColor2;
    
    
    //set the background view for a selected cell
    UIView* backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor colorWithRed: 228.f/255.f green:200.f/255.f blue:124.f/255.f alpha: 1];
    cell.selectedBackgroundView = backgroundView;
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mainMenu.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"MAIN MENU";
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SectionHeight;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellHeight;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.delegate didSelectedControllerWithTitle: [self.mainMenu objectAtIndex: indexPath.row] atIndex:indexPath.row];
    
}


@end
