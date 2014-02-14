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

static CGFloat HeaderHeight1 = 40;
static CGFloat HeaderHeight2 = 80;

static CGFloat FontSize = 14;

static CGFloat HomeNameLabelTag = 1;
static CGFloat AwayNameLabelTag = 2;
static CGFloat LocationLabelTag = 3;
static CGFloat DateLabelTag = 4;
static CGFloat TimeLabelTag = 5;

static CGFloat HomeScoreLabelTag = 6;
static CGFloat AwayScoreLabelTag = 7;


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
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    
    
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
    
    [cell addSubview: homeNameLabel];
    
    awayNameLabel.text = [game resolvedAwayTeam].name;
    awayNameLabel.font = [UIFont systemFontOfSize: FontSize];
    
    [cell addSubview: awayNameLabel];
    
    //views specific to cell type
    if (indexPath.section == 0)
    {
        UILabel* dateLabel;
        UILabel* timeLabel;
        UILabel* locationLabel;
        
        if (!(locationLabel = (UILabel*) [cell viewWithTag: LocationLabelTag]))
        {
            locationLabel = [[UILabel alloc] initWithFrame: CGRectMake(155, 10, 70, 30)];
        }
        
        locationLabel.text = game.location;
        locationLabel.font = [UIFont systemFontOfSize: FontSize];
        
        [cell addSubview: locationLabel];
        
        if (!(dateLabel = (UILabel*) [cell viewWithTag: DateLabelTag]))
        {
            dateLabel = [[UILabel alloc] initWithFrame: CGRectMake(240, 10, 60, 30)];
        }
        
        
        
        dateLabel.text = [formatter stringFromDate: game.date];
        dateLabel.font = [UIFont systemFontOfSize: FontSize];
        
        [cell addSubview: dateLabel];
        
        if (!(timeLabel = (UILabel*) [cell viewWithTag: TimeLabelTag]))
        {
            timeLabel = [[UILabel alloc] initWithFrame: CGRectMake(240, 45, 70, 30)];
        }
        
        timeLabel.text = [game.startTime description];
        timeLabel.font = [UIFont systemFontOfSize: FontSize];
        
        [cell addSubview: timeLabel];
        
        

    }
    else
    {
        UILabel* homeScoreLabel;
        UILabel* awayScoreLabel;
        UILabel* dateLabel;
        UILabel* timeLabel;
        
        homeScoreLabel = [[UILabel alloc] initWithFrame: CGRectMake(155, 10, 50, 30)];
        awayScoreLabel = [[UILabel alloc] initWithFrame: CGRectMake(155, 45, 50, 30)];
        homeScoreLabel.font = [UIFont systemFontOfSize: FontSize];
        awayScoreLabel.font = [UIFont systemFontOfSize: FontSize];
        
        switch (game.status) {
            case IMGameStatusHomeTeamWon:
                homeScoreLabel.text = [NSString stringWithFormat: @"%lu", game.homeScore];
                awayScoreLabel.text = [NSString stringWithFormat: @"%lu", game.awayScore];
                homeNameLabel.textColor = [UIColor redColor];
                homeScoreLabel.textColor = [UIColor redColor];
                break;
            case IMGameStatusAwayTeamWon:
                homeScoreLabel.text = [NSString stringWithFormat: @"%lu", game.homeScore];
                awayScoreLabel.text = [NSString stringWithFormat: @"%lu", game.awayScore];
                awayNameLabel.textColor = [UIColor redColor];
                awayScoreLabel.textColor = [UIColor redColor];
                break;
            case IMGameStatusHomeTeamForfeit:
                homeScoreLabel.text = @"F";
                awayScoreLabel.text = @"W";
                awayNameLabel.textColor = [UIColor redColor];
                awayScoreLabel.textColor = [UIColor redColor];
                break;
            case IMGameStatusAwayTeamForfeit:
                homeScoreLabel.text = @"W";
                awayScoreLabel.text = @"F";
                homeNameLabel.textColor = [UIColor redColor];
                homeScoreLabel.textColor = [UIColor redColor];
                break;
            case IMGameStatusGameCancelled:
                //create a cancelled view on top of game
                break;
            case IMGameStatusGameNotPlayed:
                NSLog(@"Some sort of error");
                break;
            default:
                NSLog(@"Should never hit default");
                break;
        }
        
        [cell addSubview: homeScoreLabel];
        [cell addSubview: awayScoreLabel];
        
        dateLabel = [[UILabel alloc] initWithFrame: CGRectMake(240, 10, 50, 30)];
        dateLabel.text = [formatter stringFromDate: game.date];
        dateLabel.font = [UIFont systemFontOfSize: FontSize];
        
        [cell addSubview: dateLabel];
        
        timeLabel = [[UILabel alloc] initWithFrame: CGRectMake(240, 45, 50, 30)];
        timeLabel.text = [game.startTime description];
        timeLabel.font = [UIFont systemFontOfSize: FontSize];
        
        [cell addSubview: timeLabel];
    }
    
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
    return (section == 0) ? HeaderHeight1 : HeaderHeight2;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat HeaderHeight = (section == 0) ? HeaderHeight1 : HeaderHeight2;
    
    UIColor* textColor = [UIColor blueColor];
    
    UIView* headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithRed: .95 green: .95 blue:.95 alpha:1];
    
    UILabel* teamLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, HeaderHeight - 20, 130, 20)];
    teamLabel.text = @"Teams";
    teamLabel.textColor = textColor;
    teamLabel.font = [UIFont systemFontOfSize: FontSize];
    
    [headerView addSubview: teamLabel];
    
    if (section == 0)
    {
        //headers specific to section 1
        UILabel* locationLabel = [[UILabel alloc] initWithFrame: CGRectMake(155, HeaderHeight - 20, 70, 20)];
        locationLabel.text = @"Location";
        locationLabel.textColor = textColor;
        locationLabel.font = [UIFont systemFontOfSize: FontSize];
        
        [headerView addSubview: locationLabel];
        
        UILabel* dateLabel = [[UILabel alloc] initWithFrame: CGRectMake(240, HeaderHeight - 20, 50, 20)];
        dateLabel.text = @"Date";
        dateLabel.textColor = textColor;
        dateLabel.font = [UIFont systemFontOfSize: FontSize];
        
        [headerView addSubview: dateLabel];
        
        
        
        return headerView;
    }
    //section 1
    UILabel* scoreLabel = [[UILabel alloc] initWithFrame: CGRectMake(155, HeaderHeight - 20, 50, 20)];
    scoreLabel.text = @"Score";
    scoreLabel.textColor = textColor;
    scoreLabel.font = [UIFont systemFontOfSize: FontSize];
    
    [headerView addSubview: scoreLabel];
    
    UILabel* dateLabel = [[UILabel alloc] initWithFrame: CGRectMake(240, HeaderHeight - 20, 50, 20)];
    dateLabel.text = @"Date";
    dateLabel.textColor = textColor;
    dateLabel.font = [UIFont systemFontOfSize: FontSize];
    
    [headerView addSubview: dateLabel];
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 10, 120, HeaderHeight - 20 - 10)];
    titleLabel.text = @"Past Games";
    titleLabel.font = [UIFont systemFontOfSize: 16];
    
    [headerView addSubview: titleLabel];
    
    return headerView;
}


@end
