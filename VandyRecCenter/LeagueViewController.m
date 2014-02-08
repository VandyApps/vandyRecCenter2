//
//  LeagueViewController.m
//
//
//  Created by Brendan McNamra on 1/23/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "LeagueViewController.h"

#import "TeamsViewController.h"
#import "GamesViewController.h"
#import "PlayoffsViewController.h"

#import "IMLeague.h"

@interface LeagueViewController ()

@property (nonatomic, strong) TeamsViewController* teamsViewController;
@property (nonatomic, strong) GamesViewController* gamesViewController;
@property (nonatomic, strong) PlayoffsViewController* playoffsViewController;

@property (nonatomic, strong) UIView* contentView;
//the display view is displayed straight from the another view controller
@property (nonatomic, weak) UIView* displayView;

@end

@implementation LeagueViewController

#pragma mark - Getter

//lazy load controllers
- (TeamsViewController*) teamsViewController {
    if (!_teamsViewController) {
        
        _teamsViewController = [[TeamsViewController alloc] initWithContentSize: self.contentView.frame.size];
        _teamsViewController.teamsCollection = self.league.teams;
        
        NSLog(@"%@", self.league.teams);
        
    }
    return _teamsViewController;
}

- (GamesViewController*) gamesViewController {
    if (!_gamesViewController) {
        _gamesViewController = [[GamesViewController alloc] initWithContentSize: self.contentView.frame.size];
        _gamesViewController.gamesCollection = self.league.games;
    }
    return _gamesViewController;
}

- (PlayoffsViewController*) playoffsViewController {
    if (!_playoffsViewController) {
        _playoffsViewController = [[PlayoffsViewController alloc] initWithContentSize: self.contentView.frame.size];
    }
    return _playoffsViewController;
}

#pragma mark - Lifecycle

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self setupSegmentedControl];
    [self setupContentView];
    [self setupLeagueModel];
   
}

#pragma mark - Setup
- (void) setupSegmentedControl {
    [self.segmentedControl addTarget: self action: @selector(segmentedControlDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (void) setupContentView {
#warning Turn 50 and 64 into static variables/ get view instead of declaring 50
    
    self.contentView = [[UIView alloc] initWithFrame: CGRectMake(0, 64 + 50, self.view.frame.size.width, self.view.frame.size.height - (64 + 50))];
    
    [self.view addSubview: self.contentView];
    
    //setup the teams view controller to display it's content
    self.displayView = self.teamsViewController.view;
    [self.contentView addSubview: self.displayView];
}

- (void) setupLeagueModel {
    [self.league resolveGames];
}
#pragma mark - Managing Segmented Control

- (void) segmentedControlDidChange: (UISegmentedControl*) sender {
    
    UIView* newView;
    
    if (sender.selectedSegmentIndex == 0) {
        newView = self.teamsViewController.view;
        
    } else if (sender.selectedSegmentIndex == 1) {
        newView = self.gamesViewController.view;
    } else  {
        newView = self.playoffsViewController.view;
    }
    
    newView.alpha = 0;
    [self.contentView addSubview: newView];
    [self.contentView sendSubviewToBack: newView];
    
    [UIView animateWithDuration: .3f animations:^{
        self.displayView.alpha = 0;
        newView.alpha = 1;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [self.displayView removeFromSuperview];
            self.displayView = newView;
        }
    }];
}

@end
