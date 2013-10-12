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
@synthesize collection = _collection;

#pragma mark - Getters

- (GFCollection*) collection {
    if (!_collection) {
        _collection = [[GFCollection alloc] init];
    }
    return _collection;
}

#pragma mark - Initializer
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Lifecycle
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

    
    //uses methods from custom date class
    NSUInteger day = date.day;
    NSUInteger month = date.month;
    NSUInteger year = date.year;
    NSArray* classes;
    NSLog(@"Loading for month %u and year %u", month, year);
    if (![self.collection dataLoadedForYear: year month:month]) {
        NSLog(@"Not yet loaded");
        MBProgressHUD* HUD;
        HUD = [MBProgressHUD showHUDAddedTo: self.view animated: YES];
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.labelText = @"Loading";
        [self.collection loadMonth:month andYear:year block:^(NSError *error, GFModel *model) {
            [HUD hide: YES];
            [self setGFClassesForDay: day month:month year:year];
        }];
    } else {
        [self setGFClassesForDay: day month:month year:year];
    }
    return classes;
}

- (void) setGFClassesForDay: (NSUInteger) day month: (NSUInteger) month year: (NSUInteger) year {
    [self.collection GFClassesForYear:year month:month day:day block:^(NSError *error, NSArray *GFClasses) {
        self.calendar.tableController.GFClassesToDisplay = GFClasses;
        NSLog(@"Classes here: %@", GFClasses);
    }];
}
#pragma mark - Calendar View Delegate

@end
