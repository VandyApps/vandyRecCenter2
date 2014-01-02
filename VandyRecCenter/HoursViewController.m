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

static CGFloat contentViewPadding = 10;

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
    
    self.timeLabel.text = @"Opening in 1 hour 27 minutes";
    // format: "Closing in 1 hour 21 minutes"
//    Hours *time = [[Hours alloc] init];
//    if (time.willOpenLaterToday == TRUE || time.wasOpenEarlierToday == TRUE) {
//        self.timeLabel.text = @"Opening in %@", [time timeUntilOpen];
//    } else if (time.isOpen == TRUE) {
//        self.timeLabel.text = @"Closing in %@", [time timeUntilClosed];
//    }
    
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
    UIView* view = [[UIView alloc] init];
    
    UIView* contentView = [[UIView alloc] initWithFrame: CGRectMake(contentViewPadding, contentViewPadding, pager.pageSize.width - 2 * contentViewPadding, pager.pageSize.height - 2 * contentViewPadding)];
    
    contentView.layer.cornerRadius = 10.f;
    
    UIColor* vandyGold = vanderbiltGold;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    [vandyGold getRed: &red green: &green blue: &blue alpha: &alpha];
    UIColor* backgroundColor = [UIColor colorWithRed: red green: green blue: blue alpha: .5];
    contentView.layer.backgroundColor = backgroundColor.CGColor;
    
    
    Hours *time = [[Hours alloc] init];
//    NSLog(@"Hours: %@", [time otherHours]);
    
    // create opening time label & add to contentView
    UILabel *openingTimeLabel = [self setupOpeningTimeLabelWithPager:pager];
    [contentView addSubview:openingTimeLabel];
    
    // create to label & add to contentView
    UILabel *toLabel = [self setupToSeparatorLabelWithPager:pager];
    [contentView addSubview:toLabel];
    
    // create closing time label & add to contentView
    UILabel *closingTimeLabel = [self setupClosingTimeLabelWithPager:pager];
    [contentView addSubview:closingTimeLabel];
    
    // create type of hours label
    UILabel *typeOfHoursLabel = [self setupTypeOfHoursLabelWithPager:pager];
    [contentView addSubview:typeOfHoursLabel];
    
    // add the content we set up to the view
    [view addSubview: contentView];
    
    return view;
}

- (UILabel*) setupOpeningTimeLabelWithPager: (BMInfinitePager*) pager {
    // create opening time label
    UILabel *openingTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(-contentViewPadding, 1 * pager.pageSize.height / 8, pager.pageSize.width, 20)];
    NSString *openingTimeString = @"8:00 pm";
    openingTimeLabel.text = openingTimeString;
    
    // Align the label at center
    openingTimeLabel.textAlignment = NSTextAlignmentCenter;
    return openingTimeLabel;
}

- (UILabel*) setupClosingTimeLabelWithPager: (BMInfinitePager*) pager {
    UILabel *closingTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(-contentViewPadding, 3 * pager.pageSize.height / 8, pager.pageSize.width, 20)];
    NSString *closingTimeString = [NSString stringWithFormat:@"10:00 pm"];
    closingTimeLabel.text = closingTimeString;
    
    // Align the label at center
    closingTimeLabel.textAlignment = NSTextAlignmentCenter;
    return closingTimeLabel;
}

- (UILabel*) setupToSeparatorLabelWithPager: (BMInfinitePager*) pager {
    UILabel *toLabel = [[UILabel alloc] initWithFrame:CGRectMake(-contentViewPadding, 2 * pager.pageSize.height / 8, pager.pageSize.width, 20)];
    NSString *toString = @"to";
    toLabel.text = toString;
    toLabel.textAlignment = NSTextAlignmentCenter;
    return toLabel;
}

- (UILabel*) setupTypeOfHoursLabelWithPager: (BMInfinitePager*) pager {
    UILabel *typeOfHoursLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentViewPadding, pager.pageSize.height - 5 * contentViewPadding, pager.pageSize.width, 20)];
    NSString *typeOfHoursString = [NSString stringWithFormat:@"Fall Hours"];
    typeOfHoursLabel.text = typeOfHoursString;
    return typeOfHoursLabel;
}

@end
