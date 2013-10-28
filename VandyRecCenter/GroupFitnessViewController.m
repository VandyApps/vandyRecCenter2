
#import "GroupFitnessViewController.h"
#import "GFTableViewController.h"
#import "GFCollection.h"
#import "MBProgressHUD.h"
#import "DSLCalendarView.h"
#import "NSDate-MyDateClass.h"

@interface GroupFitnessViewController () <DSLCalendarViewDelegate>

@end

@implementation GroupFitnessViewController


@synthesize collection = _collection;
@synthesize calendar = _calendar;
@synthesize modalView = _modalView;

#pragma mark - Getters

- (GFCollection*) collection {
    if (!_collection) {
        _collection = [[GFCollection alloc] init];
    }
    return _collection;
}


- (GFTableViewController*) modalView {
    if (!_modalView) {
        _modalView = [[GFTableViewController alloc] initWithNibName: @"GFTableView" bundle: [NSBundle mainBundle]];
    }
    return _modalView;
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

#pragma mark - Setup

- (void) setUpCalendar {
    self.calendar = [[DSLCalendarView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/3.0)];
    
    self.calendar.delegate = self;
    [self.view addSubview: self.calendar];
}

/* this should be called after setUpCalendar*/
- (void) setUpOptionPanel {

}

#pragma mark - Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setUpCalendar];
    [self setUpOptionPanel];
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

#pragma mark - Calendar Delegate

- (void)calendarView:(DSLCalendarView*)calendarView didSelectRange:(DSLCalendarRange*)range {
    NSDate* startDate = range.startDay.date;
    NSDate* endDate = range.endDay.date;
    NSLog(@"Date with range called");
    
    BOOL fetchFromServer = ![self.collection dataLoadedForMonth: startDate.month year: startDate.year]
                        || ![self.collection dataLoadedForMonth: endDate.month year:endDate.year];
    
    BOOL makeTwoFetches = startDate.month != endDate.month;
    
    MBProgressHUD* HUD;
    if (fetchFromServer) {
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.mode = MBProgressHUDModeIndeterminate;
    }
    
    [self.collection loadMonth: startDate.month andYear:startDate.year block:^(NSError *error, GFModel *model) {
        if (fetchFromServer && !makeTwoFetches) {
            [self presentViewController: self.modalView animated:YES completion:nil];
            [HUD hide: YES];
        }
        
    }];
    
    if (makeTwoFetches) {
        [self.collection loadMonth: endDate.month andYear:endDate.year block:^(NSError *error, GFModel *model) {
            if (fetchFromServer) {
                [self presentViewController: self.modalView animated:YES completion:nil];
                [HUD hide: YES];
            }
            
            
        }];
    }
    
}

- (void) calendarView:(DSLCalendarView *)calendarView willChangeToVisibleMonth:(NSDateComponents *)month duration:(NSTimeInterval)duration {
    [UIView animateWithDuration: duration animations:^{
        
    }];
}

- (void) calendarView:(DSLCalendarView *)calendarView didChangeToVisibleMonth:(NSDateComponents *)month {
}



@end
