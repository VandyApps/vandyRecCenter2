//
//  HoursViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 11/14/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "HoursViewController.h"
#import "BMInfinitePager.h"


@interface HoursViewController ()

@end

@implementation HoursViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void) viewDidLayoutSubviews {
    
    [self setup];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Setup

//facade method used for setting up the view controller
- (void) setup {
    [self setupPager];
}

- (void) setupPager {
    self.pager = [BMInfinitePager pagerWithFrame: CGRectMake(0, 0, self.pagerWrapper.frame.size.width, self.pagerWrapper.frame.size.height)
                                           style: BMInfinitePagerStyleHorizontal];
    self.pager.delegate = self;
    [self.pagerWrapper addSubview: self.pager];
}

#pragma mark - Infinite Pager delegate
- (UIView*) pager:(BMInfinitePager *)pager viewForOffset:(BMIndexPath *)offset {
    
    UIView* view = [[UIView alloc] init];
    view.backgroundColor = (offset.row % 2) ? [UIColor darkGrayColor] : vanderbiltGold;
    return view;
}

@end
