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

- (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGImageRef imageRef = image.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height);
    
    CGContextConcatCTM(context, flipVertical);
    // Draw into the context; this scales the image
    CGContextDrawImage(context, newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear: YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Calendar View Data Source
- (NSArray *)calendarView:(CKCalendarView *)calendarView eventsForDate:(NSDate *)date {
    
    NSUInteger year = date.year;
    NSUInteger month = date.month;
    NSUInteger day = date.day;
    __block NSArray* GFClasses;
    if (![self.collection dataLoadedForYear:year month: month]) {
        
        MBProgressHUD* HUD;
        HUD = [MBProgressHUD showHUDAddedTo: self.view animated: YES];
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.labelText = @"Loading";
        
        [self.collection loadMonth: month andYear: year block:^(NSError *error, GFModel *model) {
            GFClasses = [model GFClassesForDay: day];
            [HUD hide: YES];
            
        }];
    } else {
        [self.collection GFClassesForYear:year month:month day:day block:^(NSError *error, NSArray *_GFClasses) {
            GFClasses = _GFClasses;
        }];
    }
    return GFClasses;
    
    
}


#pragma mark - Calendar View Delegate

@end
