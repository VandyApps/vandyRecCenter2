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

static CGFloat TimeLabelPadding = 10;
static CGFloat TimeLabelHeight = 20;
static CGFloat TimeLabelWidth = 250;

static CGFloat TimeLabelPagerPadding = 10;

static CGFloat PagerSidePadding = 40;
static CGFloat PagerHeight = 300;

static CGFloat ArrowButtonHeight = 30;
static CGFloat ArrowButtonWidth = 15;
static CGFloat ArrowButtonPadding = 15;

static CGFloat PagerTodayButtonPadding = 40;
static CGFloat TodayButtonHeight = 30;
static CGFloat TodayButtonWidth = 100;


#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Setup

- (void) setup {
    [self setupTimeLabel];
    [self setupPager];
    [self setupArrowButtons];
    [self setupTodayButton];
}

- (void) setupTimeLabel {
    self.timeLabel = [[UILabel alloc] initWithFrame: CGRectMake(self.view.frame.size.width / 2.f - TimeLabelWidth / 2.f, 64 + TimeLabelPadding, TimeLabelWidth, TimeLabelHeight)];
    
    self.timeLabel.text = @"Closing in 1 hour 21 minutes";
    self.timeLabel.textColor = [UIColor blueColor];
    self.timeLabel.font = [UIFont systemFontOfSize: 14];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview: self.timeLabel];

}

- (void) setupPager {
    self.pager = [BMInfinitePager pagerWithFrame: CGRectMake(PagerSidePadding, 64 + TimeLabelPadding + TimeLabelHeight + TimeLabelPagerPadding, self.view.frame.size.width - 2 * PagerSidePadding, PagerHeight)
                                           style: BMInfinitePagerStyleHorizontal];
    self.pager.delegate = self;
    
    [self.view addSubview: self.pager];
}

- (void) setupArrowButtons {
    self.leftButton = [BMArrowButton arrowButtonWithFrame: CGRectMake(ArrowButtonPadding, 64 + TimeLabelPadding + TimeLabelHeight + TimeLabelPagerPadding + PagerHeight / 2.f, ArrowButtonWidth, ArrowButtonHeight) style: BMArrowButtonStyleLeft];
    
    self.rightButton = [BMArrowButton arrowButtonWithFrame: CGRectMake(self.view.frame.size.width - ArrowButtonPadding - ArrowButtonWidth, 64 + TimeLabelPadding + TimeLabelHeight + TimeLabelPagerPadding + PagerHeight / 2.f, ArrowButtonWidth, ArrowButtonHeight) style: BMArrowButtonStyleRight];
    
    [self.leftButton addTarget: self
                        action: @selector(leftButtonPressed:)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self.rightButton addTarget: self
                         action: @selector(rightButtonPressed:)
               forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: self.leftButton];
    [self.view addSubview: self.rightButton];

}

- (void) setupTodayButton {
    self.todayButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    self.todayButton.frame = CGRectMake(self.view.frame.size.width / 2.f - TodayButtonWidth / 2.f, TimeLabelHeight + TimeLabelPadding + TimeLabelPagerPadding + PagerHeight + TodayButtonHeight + PagerTodayButtonPadding, TodayButtonWidth, TodayButtonHeight);
    [self.todayButton setTitle: @"Today" forState: UIControlStateNormal];
    
    [self.todayButton addTarget: self action: @selector(todayButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.todayButton.layer.borderColor = vanderbiltGold.CGColor;
    self.todayButton.layer.borderWidth = 1.f;
    self.todayButton.layer.cornerRadius = 2.f;
    
    [self.view addSubview: self.todayButton];

}



#pragma mark - Button Press Events

- (void) leftButtonPressed: (id) sender {
    [self.pager pageLeftAnimated: YES];
}

- (void) rightButtonPressed: (id) sender {
    [self.pager pageRightAnimated: YES];
}

- (void) todayButtonPressed: (id) sender {
    [self.pager setOffset:[BMIndexPath indexPathWithRow: 0] animated: YES];
}

#pragma mark - Pager Delegate

- (UIView*) pager:(BMInfinitePager *)pager viewForOffset:(BMIndexPath *)offset {
    static CGFloat contentViewPadding = 10;
    UIView* view = [[UIView alloc] init];
    
    UIView* contentView = [[UIView alloc] initWithFrame: CGRectMake(contentViewPadding, contentViewPadding, pager.pageSize.width - 2 * contentViewPadding, pager.pageSize.height - 2 * contentViewPadding)];
    
    contentView.layer.borderColor = [UIColor brownColor].CGColor;
    contentView.layer.borderWidth = 5.f;
    contentView.layer.cornerRadius = 5.f;
    
    [view addSubview: contentView];
    
    return view;
}

@end
