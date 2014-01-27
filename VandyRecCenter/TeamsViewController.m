//
//  IntramuralTeamsViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/24/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "TeamsViewController.h"

@interface TeamsViewController ()

@property (nonatomic) CGSize size;
@property (nonatomic, strong) NSArray* tempData;
@end

@implementation TeamsViewController


#pragma mark - Initializer

- (id) initWithContentSize: (CGSize) size {
    if (self = [super init]) {
        self.size = size;
    }
    return self;
}
#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //NOTE: the dimentions of the view are being set by the calling view controller
    
    self.view.frame = CGRectMake(0, 0, self.size.width, self.size.height);
#warning Add variables for sizes
    
    self.teamView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 140)];
    
    self.tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 140, self.view.frame.size.width, self.view.frame.size.height - 140)];
    
    self.teamView.backgroundColor = [UIColor colorWithRed: .95 green:.95 blue:.95 alpha:1];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tempData = @[@"Team Awesome", @"Cool Catz", @"Lakers", @"Clipper", @"Mavericks", @"Spurs", @"Grizzlies", @"Patriots", @"Kings", @"Liverpool"];
    
    
    [self.view addSubview: self.teamView];
    [self.view addSubview: self.tableView];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
#warning should also hilight this row
    [self.tableView selectRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:0] animated: NO scrollPosition: UITableViewScrollPositionTop];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Managing Team Views
- (UIView*) constructTeamViewForTeamAtIndex: (NSUInteger) index withFrame: (CGRect) frame {
    
    static CGSize wltSize = (CGSize) {80, 60};
    static CGFloat wltLeftRightPadding = 15;
    static CGFloat wltTopPadding = 60;
    static CGFloat wltCornerRadius = 5;
    
    static CGSize wltLabelSize = (CGSize) {30,20};
    static CGSize wltStatsSize = (CGSize) {30, 20};
    static CGFloat wltLabelTopPadding = 40.f;
    static CGFloat wltStatsTopPadding = 10.f;
    
    
    UIView* teamView = [[UIView alloc] initWithFrame: frame];
    
    UIView* winsView = [[UIView alloc] initWithFrame: CGRectMake(wltLeftRightPadding, wltTopPadding, wltSize.width, wltSize.height)];
    
    winsView.layer.cornerRadius = wltCornerRadius;
    winsView.layer.backgroundColor = vanderbiltGold.CGColor;
    
    UILabel* wltLabel = [[UILabel alloc] initWithFrame: CGRectMake((wltSize.width / 2.f) - (wltLabelSize.width / 2.f), wltLabelTopPadding, wltLabelSize.width, wltLabelSize.height)];
    
    wltLabel.text = @"wins";
    wltLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel* wltStats = [[UILabel alloc] initWithFrame: CGRectMake((wltSize.width / 2.f) - (wltStatsSize.width / 2.f), wltStatsTopPadding, wltStatsSize.width, wltStatsSize.height)];

    wltStats.text = @"12";
    wltStats.textAlignment = NSTextAlignmentCenter;
    
    [winsView addSubview: wltLabel];
    [winsView addSubview: wltStats];
    
    UIView* lossesView = [[UIView alloc] initWithFrame: CGRectMake(self.teamView.center.x - (wltSize.width / 2.f), wltTopPadding, wltSize.width, wltSize.height)];
    
    
    lossesView.layer.cornerRadius = wltCornerRadius;
    lossesView.layer.backgroundColor = vanderbiltGold.CGColor;
    
    UIView* tiesView = [[UIView alloc] initWithFrame: CGRectMake(self.teamView.frame.size.width - wltSize.width - wltLeftRightPadding, wltTopPadding, wltSize.width, wltSize.height)];
    
    tiesView.layer.cornerRadius = wltCornerRadius;
    tiesView.layer.backgroundColor = vanderbiltGold.CGColor;
    
    
    [teamView addSubview: winsView];
    [teamView addSubview: lossesView];
    [teamView addSubview: tiesView];
    return teamView;
}


#pragma mark - Table View Datasource

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellId = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.tempData[indexPath.row];
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tempData.count;
}


#pragma mark - Table View Delegate


- (void) tableView:(UITableView*) tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    //switch the view
    [self.teamView addSubview: [self constructTeamViewForTeamAtIndex: indexPath.row withFrame: self.teamView.frame]];
}


@end
