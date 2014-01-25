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

@property (nonatomic) NSUInteger currentSegment;


@property (nonatomic, strong) UIView* contentView;

@end

@implementation LeagueViewController

#pragma mark - Getter

//lazy load controllers
- (TeamsViewController*) teamsViewController {
    if (!_teamsViewController) {
        _teamsViewController = [[TeamsViewController alloc] init];
    }
    return _teamsViewController;
}

- (SeasonViewController*) seasonViewController {
    if (!_seasonViewController) {
        _seasonViewController = [[SeasonViewController alloc] init];
    }
    return _seasonViewController;
}

- (PlayoffsViewController*) playoffsViewController {
    if (!_playoffsViewController) {
        _playoffsViewController = [[PlayoffsViewController alloc] init];
    }
    return _playoffsViewController;
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.segmentedControl addTarget: self action: @selector(segmentedControlDidChange:) forControlEvents:UIControlEventValueChanged];
	// Do any additional setup after loading the view.
    
#warning Turn 50 and 64 into static variables/ get view instead of declaring 50
    
    self.contentView = [[UIView alloc] initWithFrame: CGRectMake(0, 64 + 50, self.view.frame.size.width, self.view.frame.size.height - (64 + 50))];
    
    [self.view addSubview: self.contentView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Managing Segmented Control

- (void) segmentedControlDidChange: (UISegmentedControl*) sender {
    
    
    if (sender.selectedSegmentIndex == 0) {
        
        
    } else if (sender.selectedSegmentIndex == 1) {
        NSLog(@"Display Season");
    } else  {
        NSLog(@"Display Playoffs");
    }
}

@end
