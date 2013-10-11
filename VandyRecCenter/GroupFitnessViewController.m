//
//  GroupFitnessViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/5/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "GroupFitnessViewController.h"

@interface GroupFitnessViewController ()

@end

@implementation GroupFitnessViewController

@synthesize calendar = _calendar;
@synthesize todayButton = _todayButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.calendar = [[CKCalendarView alloc] initWithMode: CKCalendarViewModeWeek];
    self.calendar.backgroundColor = vanderbiltGold;
    [self.view addSubview: self.calendar];
    self.calendar.delegate = self;
    self.calendar.dataSource = self;
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear: YES];
    
    self.todayButton.backgroundColor = vanderbiltGold;//[UIColor colorWithRed: 0 green: 153/255.f blue: 204/255.f alpha:.8];
    self.todayButton.alpha = .8;
    self.todayButton.layer.cornerRadius = self.todayButton.frame.size.height / 2.0;
    self.todayButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.todayButton.layer.borderWidth = 2.0f;
    
    //add shadow to button
    self.todayButton.layer.masksToBounds = NO;
    self.todayButton.layer.shadowOffset = CGSizeMake(-3, 6);
    self.todayButton.layer.shadowRadius = 5;
    self.todayButton.layer.shadowOpacity = 1;
    [self.view bringSubviewToFront: self.todayButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Calendar View Data Source
- (NSArray *)calendarView:(CKCalendarView *)calendarView eventsForDate:(NSDate *)date {
    CKCalendarEvent* event = [[CKCalendarEvent alloc] init];
    event.title = @"This is an event";
    event.date = [[NSDate alloc] init];
    //event.info = @"Here is some info about this event.  This is a long description here so I wonder what will happen";
    return @[event];
}
#pragma mark - Calendar View Delegate

@end
