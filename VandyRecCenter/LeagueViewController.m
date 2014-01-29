//
//  LeagueViewController.m
//
//
//  Created by Brendan McNamra on 1/23/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "LeagueViewController.h"

#import "TeamsViewController.h"
#import "SeasonViewController.h"
#import "PlayoffsViewController.h"

@interface LeagueViewController ()

@property (nonatomic, strong) TeamsViewController* teamsViewController;
@property (nonatomic, strong) SeasonViewController* seasonViewController;
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
    }
    return _teamsViewController;
}

- (SeasonViewController*) seasonViewController {
    if (!_seasonViewController) {
        _seasonViewController = [[SeasonViewController alloc] initWithContentSize: self.contentView.frame.size];
    }
    return _seasonViewController;
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
    
    
    [self.segmentedControl addTarget: self action: @selector(segmentedControlDidChange:) forControlEvents:UIControlEventValueChanged];
    
#warning Turn 50 and 64 into static variables/ get view instead of declaring 50
    
    self.contentView = [[UIView alloc] initWithFrame: CGRectMake(0, 64 + 50, self.view.frame.size.width, self.view.frame.size.height - (64 + 50))];
    NSLog(@"View height is %g", self.view.frame.size.height);
    
    NSLog(@"content view height is %g", self.contentView.frame.size.height);
    
    [self.view addSubview: self.contentView];
    
    //setup the teams view controller to display it's content
    self.displayView = self.teamsViewController.view;
    [self.contentView addSubview: self.displayView];
}

#pragma mark - Managing Segmented Control

- (void) segmentedControlDidChange: (UISegmentedControl*) sender {
    
    UIView* newView;
    
    if (sender.selectedSegmentIndex == 0) {
        newView = self.teamsViewController.view;
        
    } else if (sender.selectedSegmentIndex == 1) {
        newView = self.seasonViewController.view;
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
