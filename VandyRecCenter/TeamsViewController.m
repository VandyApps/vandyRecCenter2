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
@property (nonatomic, strong) UIView* teamSubview;
@property (nonatomic) NSInteger currentRow;
@end

@implementation TeamsViewController

typedef enum {
    WLTTypeWin,
    WLTTypeLoss,
    WLTTypeTie
} WLTType;

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
    //set to -1 to not interfere with initial selection
    self.currentRow = -1;
    
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

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
}


#pragma mark - Managing Team Views
- (UIView*) constructTeamViewForTeamAtIndex: (NSUInteger) index withFrame: (CGRect) frame {
    
    static CGSize teamNameLabelSize = (CGSize) {200, 30};
    static CGFloat teamNameLabelTopPadding = 10;
    
    
    UIView* teamView = [[UIView alloc] initWithFrame: frame];
    
    UILabel* teamNameLabel = [[UILabel alloc] initWithFrame: CGRectMake((self.teamView.frame.size.width/ 2.f) - teamNameLabelSize.width / 2.f, teamNameLabelTopPadding, teamNameLabelSize.width, teamNameLabelSize.height)];
    
    teamNameLabel.text = self.tempData[index];
    teamNameLabel.font = [UIFont systemFontOfSize: 18];
    teamNameLabel.textAlignment = NSTextAlignmentCenter;
    
    [teamView addSubview: teamNameLabel];
    [teamView addSubview: [self constructViewOfType: WLTTypeWin withCount: 12]];
    [teamView addSubview: [self constructViewOfType: WLTTypeLoss withCount: 8]];
    [teamView addSubview: [self constructViewOfType: WLTTypeTie withCount: 1]];
    return teamView;
}

- (UIView*) constructViewOfType: (WLTType) type withCount: (NSUInteger) count {
    
    static CGSize wltSize = (CGSize) {80, 60};
    static CGFloat wltLeftRightPadding = 15;
    static CGFloat wltTopPadding = 60;
    static CGFloat wltCornerRadius = 5;
    
    static CGSize wltLabelSize = (CGSize) {60,20};
    static CGSize wltStatsSize = (CGSize) {30, 20};
    static CGFloat wltLabelTopPadding = 30.f;
    static CGFloat wltStatsTopPadding = 10.f;
    
    //set WLTSpecific variables here
    
    CGRect frame;
    NSString* wltTypeString;
    
    if (type == WLTTypeWin) {
        frame = CGRectMake(wltLeftRightPadding, wltTopPadding, wltSize.width, wltSize.height);
        wltTypeString = @"wins";
    } else if (type == WLTTypeLoss) {
        frame = CGRectMake(self.teamView.center.x - (wltSize.width / 2.f), wltTopPadding, wltSize.width, wltSize.height);
        
        wltTypeString = @"losses";
    } else { //ties
        frame = CGRectMake(self.teamView.frame.size.width - wltSize.width - wltLeftRightPadding, wltTopPadding, wltSize.width, wltSize.height);
        
        wltTypeString = @"ties";
    }
    
    
    
    UIView* wltView = [[UIView alloc] initWithFrame: frame];
    
    wltView.layer.cornerRadius = wltCornerRadius;
    wltView.layer.backgroundColor = vanderbiltGold.CGColor;
    
    UILabel* wltLabel = [[UILabel alloc] initWithFrame: CGRectMake((wltSize.width / 2.f) - (wltLabelSize.width / 2.f), wltLabelTopPadding, wltLabelSize.width, wltLabelSize.height)];
    
    wltLabel.text = wltTypeString;
    wltLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel* wltStats = [[UILabel alloc] initWithFrame: CGRectMake((wltSize.width / 2.f) - (wltStatsSize.width / 2.f), wltStatsTopPadding, wltStatsSize.width, wltStatsSize.height)];
    
    wltStats.text = [NSString stringWithFormat: @"%u", count];
    wltStats.textAlignment = NSTextAlignmentCenter;
    wltStats.textColor = [UIColor redColor];
    wltStats.font = [UIFont systemFontOfSize: 20];
    
    [wltView addSubview: wltLabel];
    [wltView addSubview: wltStats];
    
    return wltView;
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


- (void) tableView:(UITableView*) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //switch the view
    if (indexPath.row != self.currentRow) {
        UIView* newTeamSubview = [self constructTeamViewForTeamAtIndex: indexPath.row withFrame: self.teamView.frame];
        
        newTeamSubview.alpha = 0;
        
        [self.teamView addSubview: newTeamSubview];
        [self.teamView sendSubviewToBack: newTeamSubview];
        
        [UIView animateWithDuration: .3f animations:^{
            self.teamSubview.alpha = 0;
            newTeamSubview.alpha = 1;
        } completion:^(BOOL finished) {
            [self.teamSubview removeFromSuperview];
            self.teamSubview = newTeamSubview;
        }];
        self.currentRow = indexPath.row;
    }
}


@end
