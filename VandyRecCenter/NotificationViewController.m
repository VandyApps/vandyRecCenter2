//
//  NotificationViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "NotificationViewController.h"
@interface NotificationViewController ()

@property (nonatomic) BOOL showingNews;
@property (nonatomic) BOOL showingHours;
@property (nonatomic) BOOL showingGroupFitness;
@property (nonatomic) BOOL showingIntramurals;

@end

@implementation NotificationViewController

@synthesize tableView = _tableView;
@synthesize HUD = _HUD;
@synthesize colorMap = _colorMap;

@synthesize showingNews = _showingNews;
@synthesize showingHours = _showingHours;
@synthesize showingGroupFitness = _showingGroupFitness;
@synthesize showingIntramurals = _showingIntramurals;

#pragma mark - Getters

- (NSArray*) colorMap {
    if (!_colorMap) {
        _colorMap = @[vanderbiltGold, [UIColor blueColor], [UIColor darkGrayColor], [UIColor greenColor]];
    }
    return _colorMap;
}

#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - Lifecycle

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

        /*
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.cornerRadius = 12.0f;
        gradient.frame = contentView.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor, (id)[UIColor whiteColor].CGColor, (id) [UIColor whiteColor].CGColor, vanderbiltGold.CGColor, nil];
        [contentView.layer insertSublayer:gradient atIndex:0];
         */


@end
