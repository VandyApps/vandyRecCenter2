//
//  IntramuralSeasonViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/24/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "GamesViewController.h"

#import "IMGame.h"
#import "IMGames.h"
#import "IMTeam.h"
#import "TimeString.h"

@interface GamesViewController()

@property (nonatomic, strong) NSArray* newGames;
@property (nonatomic, strong) NSArray* oldGames;

@end

@implementation GamesViewController

@synthesize newGames = _newGames;
@synthesize oldGames = _oldGames;

#pragma mark - Static Variables

static CGFloat CellHeight = 80;
static CGFloat HeaderHeight = 40;

static CGFloat FontSize = 14;

static CGFloat HomeNameLabelTag = 1;
static CGFloat AwayNameLabelTag = 2;
static CGFloat HomeScoreLabelTag = 3;
static CGFloat AwayScoreLabelTag = 4;
static CGFloat LocationLabelTag = 5;
static CGFloat DateLabelTag = 6;
static CGFloat TimeLabelTag = 7;


#pragma mark - Getters
/* newGames and old Games properties are using lazy
 * instantiation to get data.  That way, if IMGames
 * is ever updated, the newGames and oldGames can be
 * set to nil, so that on the next fetch, the data will
 * be refetched as needed. newGames and oldGames methods
 * of the games collection are not done in O(1) time
 */

- (NSArray*) newGames {
    if (_newGames == nil) {
        _newGames = [self.gamesCollection newGames];
    }
    return _newGames;
}

- (NSArray*) oldGames {
    if (_oldGames == nil) {
        _oldGames = [self.gamesCollection oldGames];
    }
    return _oldGames;
}

#pragma mark - Initializer

- (id) initWithContentSize: (CGSize) size {
    if (self = [super init]) {
        _size = size;
    }
    return self;
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, self.size.width, self.size.height);

    [self setupTableView];
    
}

#pragma mark - Setup



- (void) setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame: (CGRect) {{0,0}, self.view.frame.size}
                                                  style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview: self.tableView];
}

#pragma mark - Table View Datasource

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* newGamesCellId = @"NewGamesCell";
    static NSString* oldGamesCellId = @"OldGamesCell";
    
    NSString* cellId = (indexPath.section) ? oldGamesCellId : newGamesCellId;
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: cellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    IMGame* game = (indexPath.section) ? self.oldGames[indexPath.row] : self.newGames[indexPath.row];
    

    UILabel* homeNameLabel;
    UILabel* awayNameLabel;
    UILabel* dateLabel;
    UILabel* timeLabel;
    UILabel* locationLabel;
    
    
    if (!(homeNameLabel = (UILabel*) [cell viewWithTag: HomeNameLabelTag]))
    {
        homeNameLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 10, 130, 30)];
    }
    
    if (!(awayNameLabel = (UILabel*) [cell viewWithTag: AwayNameLabelTag]))
    {
        awayNameLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 45, 130, 30)];
    }
    
    homeNameLabel.text = [game resolvedHomeTeam].name;
    homeNameLabel.font = [UIFont systemFontOfSize: FontSize];
    
    awayNameLabel.text = [game resolvedAwayTeam].name;
    awayNameLabel.font = [UIFont systemFontOfSize: FontSize];
    
    if (!(dateLabel = (UILabel*) [cell viewWithTag: DateLabelTag]))
    {
        dateLabel = [[UILabel alloc] initWithFrame: CGRectMake(155, 10, 60, 30)];
    }
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    
    dateLabel.text = [formatter stringFromDate: game.date];
    dateLabel.font = [UIFont systemFontOfSize: FontSize];
    
    if (!(timeLabel = (UILabel*) [cell viewWithTag: TimeLabelTag]))
    {
        timeLabel = [[UILabel alloc] initWithFrame: CGRectMake(155, 45, 70, 30)];
    }
    
    timeLabel.text = [game.startTime description];
    timeLabel.font = [UIFont systemFontOfSize: FontSize];
    
    if (!(locationLabel = (UILabel*) [cell viewWithTag: LocationLabelTag]))
    {
        locationLabel = [[UILabel alloc] initWithFrame: CGRectMake(240, 10, 70, 30)];
    }
    
    locationLabel.text = game.location;
    locationLabel.font = [UIFont systemFontOfSize: FontSize];
    
    [cell addSubview: homeNameLabel];
    [cell addSubview: awayNameLabel];

    [cell addSubview: dateLabel];
    [cell addSubview: timeLabel];
    [cell addSubview: locationLabel];
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0) ? self.newGames.count : self.oldGames.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellHeight;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HeaderHeight;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    if (section == 0)
    {
         UIView* headerView = [[UIView alloc] init];
        
        UILabel* teamLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, HeaderHeight - 20, 130, 20)];
        teamLabel.text = @"Teams";
        teamLabel.textColor = [UIColor blueColor];
        teamLabel.font = [UIFont systemFontOfSize: FontSize];
        
        UILabel* dateLabel = [[UILabel alloc] initWithFrame: CGRectMake(155, HeaderHeight - 20, 50, 20)];
        dateLabel.text = @"Dates";
        dateLabel.textColor = [UIColor blueColor];
        dateLabel.font = [UIFont systemFontOfSize: FontSize];
        
        UILabel* locationLabel = [[UILabel alloc] initWithFrame: CGRectMake(240, HeaderHeight - 20, 70, 20)];
        locationLabel.text = @"Location";
        locationLabel.textColor = [UIColor blueColor];
        locationLabel.font = [UIFont systemFontOfSize: FontSize];
        
        [headerView addSubview: teamLabel];
        [headerView addSubview: dateLabel];
        [headerView addSubview: locationLabel];
        
        headerView.backgroundColor = [UIColor colorWithRed: .95 green: .95 blue:.95 alpha:1];
        return headerView;
    }
    
    return [[UIView alloc] init];
}


@end
