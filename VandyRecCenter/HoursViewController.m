//
//  HoursViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 11/14/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "HoursViewController.h"
#import "BMInfinitePager.h"
#import "BMArrowButton.h"

@interface HoursViewController ()

@end

@implementation HoursViewController

#pragma mark - Static Variables

static CGFloat PagerSidePadding = 40;
static CGFloat PagerTopPadding = 20;
static CGFloat PagerHeight = 300;

static CGFloat ArrowButtonHeight = 30;
static CGFloat ArrowButtonWidth = 15;
static CGFloat ArrowButtonPadding = 15;

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pager = [BMInfinitePager pagerWithFrame: CGRectMake(PagerSidePadding, 64 + PagerTopPadding, self.view.frame.size.width - 2 * PagerSidePadding, PagerHeight)
                                           style: BMInfinitePagerStyleHorizontal];
    self.pager.delegate = self;
    
    [self.view addSubview: self.pager];
    
    self.leftButton = [BMArrowButton arrowButtonWithFrame: CGRectMake(ArrowButtonPadding, 64 + PagerTopPadding + PagerHeight / 2.f, ArrowButtonWidth, ArrowButtonHeight) style: BMArrowButtonStyleLeft];
    
    self.rightButton = [BMArrowButton arrowButtonWithFrame: CGRectMake(self.view.frame.size.width - ArrowButtonPadding - ArrowButtonWidth, 64 + PagerTopPadding + PagerHeight / 2.f, ArrowButtonWidth, ArrowButtonHeight) style: BMArrowButtonStyleRight];
    
    [self.leftButton addTarget: self action: @selector(leftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget: self action: @selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: self.leftButton];
    [self.view addSubview: self.rightButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Button Press Events

- (void) leftButtonPressed: (id) sender {
    [self.pager pageLeftAnimated: YES];
}

- (void) rightButtonPressed: (id) sender {
    [self.pager pageRightAnimated: YES];
}

#pragma mark - Pager Delegate

- (UIView*) pager:(BMInfinitePager *)pager viewForOffset:(BMIndexPath *)offset {
    UIView* view = [[UIView alloc] init];
    
    view.backgroundColor = (offset.row % 2) ? vanderbiltGold : [UIColor darkGrayColor];
    return view;
}

@end
