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

@interface GamesViewController()

@property (nonatomic, strong) NSArray* newGames;
@property (nonatomic, strong) NSArray* oldGames;

@end

@implementation GamesViewController

@synthesize newGames = _newGames;
@synthesize oldGames = _oldGames;

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
                                                  style:UITableViewStyleGrouped];
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
    }
    IMGame* game = (indexPath.section) ? self.oldGames[indexPath.row] : self.newGames[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat: @"%@ and %@",
                           [game resolvedHomeTeam].name, [game resolvedAwayTeam].name];
    
    return cell;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0) ? self.newGames.count : self.oldGames.count;
}


@end
