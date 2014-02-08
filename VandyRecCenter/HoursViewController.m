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

@property (nonatomic) CGSize pagerSize;
@property (nonatomic) UIColor* pageColor;

@property (nonatomic, strong) UIView* placeholderView;

@end

@implementation HoursViewController

@synthesize hours = _hours;

#pragma mark - Static Variables

static CGFloat pageRadius = 10;
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

static CGFloat OpenTimeRangePadding = 40;




#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    
    if (!_hours) {
        self.hours = [[Hours alloc] init];
    }
    
    [_hours loadData:^(NSError *error, Hours *hoursModel) {
        if (error) {
            NSLog(@"There was an error: %@", error);
        }
        if (hoursModel.hours) {
            [self.view bringSubviewToFront: self.placeholderView];
            [self setupPager];
            [self setupTimeLabel];
            [self showTimeLabelAnimated: YES];
            [self showArrowButtonsAnimated: YES];
            [self removePlaceholderViewAnimated: YES];
        }
    }];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    //pager size must be set in viewWillAppear: since the view's frame is not
    //correctly set until here
    self.pagerSize = CGSizeMake(self.view.frame.size.width - 2 * PagerSidePadding, PagerHeight);
    
    //this must be done in view will appear since it depends on pager size to be set
    if (!self.hours.isLoaded) {
        [self setupPlaceholderView];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Setup

- (void) setup {
    [self setupPageColor];
    [self setupArrowButtonsWithoutDisplay];
    [self setupTodayButton];
    
}


- (void) setupPageColor {
    UIColor* vandyGold = vanderbiltGold;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    [vandyGold getRed: &red green: &green blue: &blue alpha: &alpha];
    self.pageColor = [UIColor colorWithRed: red green: green blue: blue alpha: .9];
}

- (void) setupTimeLabel {
    self.timeLabel = [[UILabel alloc] initWithFrame: CGRectMake(self.view.frame.size.width / 2.f - TimeLabelWidth / 2.f, 64 + TimeLabelPadding, TimeLabelWidth, TimeLabelHeight)];
    
    NSTimeInterval timeInSeconds;
    
    // format: "Closing in 1 hour 21 minutes"
    if ([_hours willOpenLaterToday] == TRUE || [_hours wasOpenEarlierToday] == TRUE) {
        timeInSeconds = [_hours timeUntilOpen];
        self.timeLabel.text = @"Opening in ";
    } else { // Rec is currently open
        timeInSeconds = [_hours timeUntilClosed];
        self.timeLabel.text = @"Closing in ";
    }
    
    NSInteger remainingHours = (NSInteger)timeInSeconds / 3600;
    NSInteger remainingMinutes = ((NSInteger)timeInSeconds % 3600) / 60;
    self.timeLabel.text = [self.timeLabel.text stringByAppendingString:[self timeIntervalStringValueWithHours:remainingHours andMinutes:remainingMinutes]];
    
    self.timeLabel.textColor = [UIColor blueColor];
    self.timeLabel.font = [UIFont systemFontOfSize: 14];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    
    self.timeLabel.alpha = 0;
    [self.view addSubview: self.timeLabel];

}

- (void) setupPlaceholderView {
    CGSize placeHolderSize = CGSizeMake(self.pagerSize.width - 2 * contentViewPadding, self.pagerSize.height - 2*contentViewPadding);
    
    self.placeholderView = [[UIView alloc] initWithFrame: CGRectMake(PagerSidePadding + contentViewPadding, 64 + TimeLabelPadding + TimeLabelHeight + TimeLabelPagerPadding + contentViewPadding, placeHolderSize.width, placeHolderSize.height)];
    
    self.placeholderView.backgroundColor = vanderbiltGold;
    self.placeholderView.layer.cornerRadius = pageRadius;
    
    UIActivityIndicatorView* hub = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
    
    hub.center = CGPointMake(placeHolderSize.width/2.f, placeHolderSize.height/2.f);
    [hub startAnimating];
    
    [self.placeholderView addSubview: hub];
    
    [self.view addSubview: self.placeholderView];
}


// Returns a string with the format "1 hour 27 minutes" or, if hours == 0, "27 minutes"
- (NSString *) timeIntervalStringValueWithHours:(NSInteger)hours andMinutes:(NSInteger)minutes {
    NSString* returnString = [[NSString alloc] init];
    
    if (hours == 1) {
        returnString = [returnString stringByAppendingFormat:@"%li", (long)hours];
        returnString = [returnString stringByAppendingString:@" hour "];
    } else if (hours > 1) {
        returnString = [returnString stringByAppendingFormat:@"%li", (long)hours];
        returnString = [returnString stringByAppendingString:@" hours "];
    }
    
    returnString = [returnString stringByAppendingFormat:@"%li", (long)minutes];
    if (minutes == 1) {
        returnString = [returnString stringByAppendingString:@" minute"];
    } else {
        returnString = [returnString stringByAppendingString:@" minutes"];
    }
    
    return returnString;
}


- (void) setupPager {
    self.pager = [BMInfinitePager pagerWithFrame: CGRectMake(PagerSidePadding, 64 + TimeLabelPadding + TimeLabelHeight + TimeLabelPagerPadding, self.pagerSize.width, self.pagerSize.height)
                                           style: BMInfinitePagerStyleHorizontal];
    self.pager.delegate = self;
    
    [self.view addSubview: self.pager];
}

- (void) setupArrowButtonsWithoutDisplay {
    self.leftButton = [BMArrowButton arrowButtonWithFrame: CGRectMake(ArrowButtonPadding, 64 + TimeLabelPadding + TimeLabelHeight + TimeLabelPagerPadding + PagerHeight / 2.f, ArrowButtonWidth, ArrowButtonHeight) style: BMArrowButtonStyleLeft];
    
    self.rightButton = [BMArrowButton arrowButtonWithFrame: CGRectMake(self.view.frame.size.width - ArrowButtonPadding - ArrowButtonWidth, 64 + TimeLabelPadding + TimeLabelHeight + TimeLabelPagerPadding + PagerHeight / 2.f, ArrowButtonWidth, ArrowButtonHeight) style: BMArrowButtonStyleRight];
    
    self.leftButton.alpha = 0;
    self.rightButton.alpha = 0;
    
    
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

#pragma mark - Teardown

- (void) removePlaceholderViewAnimated: (BOOL) animated {
    if (animated) {
        [UIView animateWithDuration: .6f animations:^{
            self.placeholderView.alpha = 0;
        } completion:^(BOOL finished) {
            self.placeholderView = nil;
        }];
        
    } else {
        [self.placeholderView removeFromSuperview];
        self.placeholderView = nil;
    }
    
}

#pragma mark - Animations

- (void) showArrowButtonsAnimated: (BOOL) animated {
    if (animated) {
        [UIView animateWithDuration:.6f animations:^{
            self.leftButton.alpha = 1;
            self.rightButton.alpha = 1;
        }];
    } else {
        self.leftButton.alpha = 1;
        self.leftButton.alpha = 1;
    }
}

- (void) showTimeLabelAnimated: (BOOL) animated {
    if (animated) {
        [UIView animateWithDuration: .6f animations:^{
            self.timeLabel.alpha = 1;
        }];
    } else {
        self.timeLabel.alpha = 1;
    }
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
    
    contentView.layer.cornerRadius = pageRadius;
    
    
    contentView.layer.backgroundColor = self.pageColor.CGColor;
    
    // create day of week label & add it to contentView
    UILabel *dayOfWeekLabel = [self setupDayOfWeekLabelWithPager:pager andOffset:offset];
    [contentView addSubview:dayOfWeekLabel];
    
    // create opening time label & add to contentView
    UILabel *openingTimeLabel = [self setupOpeningTimeLabelWithPager:pager andOffset:offset];
    [contentView addSubview:openingTimeLabel];
    
    // create to label & add to contentView
    UILabel *toLabel = [self setupToSeparatorLabelWithPager:pager];
    [contentView addSubview:toLabel];
    
    // create closing time label & add to contentView
    UILabel *closingTimeLabel = [self setupClosingTimeLabelWithPager:pager andOffset:offset];
    [contentView addSubview:closingTimeLabel];
    
    // create type of hours label
    UILabel *typeOfHoursLabel = [self setupTypeOfHoursLabelWithPager:pager];
    [contentView addSubview:typeOfHoursLabel];
    
    // add the content we set up to the view
    [view addSubview: contentView];
    
    return view;
}

- (UILabel*) setupDayOfWeekLabelWithPager: (BMInfinitePager*) pager andOffset:(BMIndexPath *)offset {
    // create dayOfWeekLabel
    UILabel *dayOfWeekLabel = [[UILabel alloc] initWithFrame:CGRectMake(-contentViewPadding, 1 * pager.pageSize.height / 8, pager.pageSize.width, 20)];
        
    NSDate *currentDate = [self getCurrentDateForOffsetRow:offset.row];
    
    NSString *dayOfWeekString = [DateHelper weekDayForIndex:[currentDate weekDay]];
    NSString *monthString = [DateHelper monthNameAbbreviationForIndex:[currentDate month]];
    NSUInteger dayOfMonthString = [currentDate day];
    NSUInteger year = [currentDate year];
    
    NSString *dateString = [NSString stringWithFormat:@"%@, %@ %lu, %lu", dayOfWeekString, monthString, (unsigned long)dayOfMonthString, (unsigned long)year];
    
    
    dayOfWeekLabel.text = dateString;
    
    // Align the label at center
    dayOfWeekLabel.textAlignment = NSTextAlignmentCenter;
    return dayOfWeekLabel;
}

- (NSDate*) getCurrentDateForOffsetRow: (NSInteger) row {
    NSDate *currentDate = [DateHelper currentDateForTimeZone:[NSTimeZone localTimeZone]];
    
    // Increment date if index is negative; decrement date if positive
    if (row < 0) {
        for (int i = 0; i < -row; i++) {
            currentDate = [currentDate dateByDecrementingDay];
        }
    } else if (row > 0) {
        for (int i = 0; i < row; i++) {
            currentDate = [currentDate dateByIncrementingDay];
        }
    }
    return currentDate;
}

- (UILabel*) setupOpeningTimeLabelWithPager:(BMInfinitePager*)pager andOffset:(BMIndexPath*)offset {
    // create opening time label
    UILabel *openingTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(-contentViewPadding, 1 * pager.pageSize.height / 8 + OpenTimeRangePadding, pager.pageSize.width, 20)];
    
    NSDate *date = [self getCurrentDateForOffsetRow:offset.row];
    NSString *openingTimeString = [[_hours openingTimeForDate:date] stringValue];
    openingTimeLabel.text = openingTimeString;
    
    // Align the label at center
    openingTimeLabel.textAlignment = NSTextAlignmentCenter;
    return openingTimeLabel;
}

- (UILabel*) setupClosingTimeLabelWithPager: (BMInfinitePager*) pager andOffset:(BMIndexPath*)offset {
    UILabel *closingTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(-contentViewPadding, 3 * pager.pageSize.height / 8 + OpenTimeRangePadding, pager.pageSize.width, 20)];
    
    NSDate *date = [self getCurrentDateForOffsetRow:offset.row];
    NSString *closingTimeString = [[_hours closedTimeForDate:date] stringValue];
    closingTimeLabel.text = closingTimeString;
    
    // Align the label at center
    closingTimeLabel.textAlignment = NSTextAlignmentCenter;
    return closingTimeLabel;
}

- (UILabel*) setupToSeparatorLabelWithPager: (BMInfinitePager*) pager {
    UILabel *toLabel = [[UILabel alloc] initWithFrame:CGRectMake(-contentViewPadding, 2 * pager.pageSize.height / 8 + OpenTimeRangePadding, pager.pageSize.width, 20)];
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
