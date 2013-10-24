
#import "GroupFitnessViewController.h"
#import "GFTableViewController.h"
#import "GFCollection.h"
#import "MBProgressHUD.h"
#import "DSLCalendarView.h"

@interface GroupFitnessViewController () <DSLCalendarViewDelegate>

@end

@implementation GroupFitnessViewController

@synthesize tableView = _tableView;
@synthesize collection = _collection;
@synthesize calendar = _calendar;

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

#pragma mark - Setup

- (void) setUpCalendar {
    self.calendar = [[DSLCalendarView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2.0)];
    self.calendar.delegate = self;
    [self.view addSubview: self.calendar];
}


/*this method must be called after setting up calendar*/
- (void) setUpTableView {
    self.tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, self.calendar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.calendar.frame.size.height)];
    
    [self.view addSubview: self.tableView];
}


#pragma mark - Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setUpCalendar];
    [self setUpTableView];
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
}

- (void) calendarView:(DSLCalendarView *)calendarView willChangeToVisibleMonth:(NSDateComponents *)month duration:(NSTimeInterval)duration {
    [UIView animateWithDuration: duration animations:^{
        
        CGRect tableViewFrame = CGRectMake(0, calendarView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - calendarView.frame.size.height);
        self.tableView.frame = tableViewFrame;
    }];
}

- (void) calendarView:(DSLCalendarView *)calendarView didChangeToVisibleMonth:(NSDateComponents *)month {
}



@end
