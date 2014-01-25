//
//  IntramuralsViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/23/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "IntramuralsViewController.h"

#import "LeagueViewController.h"


@interface IntramuralsViewController ()

@property (nonatomic, strong) NSDictionary* demoData;

@end

@implementation IntramuralsViewController


#pragma mark - Static Variables

static CGFloat headerHeight = 30;

#pragma mark - Initializer

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
    self.demoData = @{
                      
                      @"Basketball" :
                        @[
                           @"Black League 1",
                           @"Black League 2",
                           @"Black League 3",
                           @"Fraternity League",
                           @"Cool League",
                           @"Lame League"
                              
                        ],
                      @"Football" :
                        @[
                            @"Green League",
                            @"Black League",
                            @"Blue League",
                            @"Orange League",
                            @"Teal League",
                            @"Lightish-Grayish-Blue League"
                            
                              
                        ],
                      @"Volleyball" :
                        @[
                              @"Co-ed League",
                              @"Orange League",
                              @"Red League",
                              @"Girl's League",
                              @"Boy's League",
                              @"Men's League",
                              @"Women's League"
                        ]
                      };
    
	self.tableView = [[UITableView alloc] initWithFrame: self.view.frame style: UITableViewCellStyleDefault];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview: self.tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [self.demoData[[self.demoData allKeys][indexPath.section]] objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.demoData count];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.demoData[[self.demoData allKeys][section]] count];
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.demoData allKeys][section];
}


#pragma mark - UITableViewDelegate


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LeagueViewController* leagueController = [[LeagueViewController alloc] initWithNibName: @"Intramurals.League" bundle:[NSBundle mainBundle]];
    
    leagueController.title = @"League";
    [self.navigationController pushViewController: leagueController
                                         animated: YES];
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor darkGrayColor];
    view.alpha = .75;
    UILabel* titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, headerHeight)];
    
    titleLabel.text = [self.demoData allKeys][section];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview: titleLabel];
    
    return view;
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return headerHeight;
}

@end
