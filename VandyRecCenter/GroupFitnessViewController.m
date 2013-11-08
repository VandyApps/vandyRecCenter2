
#import "GroupFitnessViewController.h"
#import "GFTableViewController.h"
#import "GFCollection.h"
#import "MBProgressHUD.h"
#import "DSLCalendarView.h"
#import "NSDate-MyDateClass.h"

@interface GroupFitnessViewController () <DSLCalendarViewDelegate>

@property (nonatomic, strong) UIView* optionsView;
@property (nonatomic, strong) UIView* topLayerOptionsView;
@property (nonatomic, strong) UIView* bottomLayerOptionsView;
@end

@implementation GroupFitnessViewController

#pragma mark - Synthesize
@synthesize collection = _collection;
@synthesize calendar = _calendar;
@synthesize modalView = _modalView;
@synthesize optionsView = _optionsView;

#pragma mark - Private Static Variables
static CGFloat navBarHeight = 64;
static CGFloat bottomLayerBorderDistance = 6.f;
static CGFloat buttonSize = 40.f;
static CGFloat buttonPadding = 100.f;

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

/* facade for setup methods*/
- (void) setup {
    [self setUpCalendar];
    [self setUpOptionPanel];
}
- (void) setUpCalendar {
    self.calendar.delegate = self;
    [self.view addSubview: self.calendar];
}

/* this should be called after setUpCalendar*/
- (void) setUpOptionPanel {
    self.optionsView = [[UIView alloc] initWithFrame: CGRectMake(0, self.calendar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.calendar.frame.size.height - navBarHeight)];
    
    self.optionsView.backgroundColor = [UIColor colorWithRed: .95f green: .95f blue: .95f alpha:1];
    
    
    //set up nested views
    self.bottomLayerOptionsView = [[UIView alloc] initWithFrame: CGRectMake(bottomLayerBorderDistance, bottomLayerBorderDistance, self.optionsView.frame.size.width - (2* bottomLayerBorderDistance), self.optionsView.frame.size.height - (2* bottomLayerBorderDistance))];
    
    self.topLayerOptionsView = [[UIView alloc] initWithFrame: CGRectMake(bottomLayerBorderDistance * 2, bottomLayerBorderDistance * 2, self.optionsView.frame.size.width - (4* bottomLayerBorderDistance), self.optionsView.frame.size.height - (4* bottomLayerBorderDistance))];
    
    self.bottomLayerOptionsView.layer.borderWidth = 1.f;
    self.bottomLayerOptionsView.layer.borderColor = [UIColor blackColor].CGColor;
    self.topLayerOptionsView.layer.borderWidth = 1.f;
    self.bottomLayerOptionsView.layer.borderColor = [UIColor blackColor].CGColor;
    
    //create the buttons to the interface
    //buttons are to be nested within the bottomLayer for the
    //options view
    CGFloat collectiveButtonSize = (buttonSize * 2) + buttonPadding;
    self.todayButton = [[UIButton alloc] initWithFrame: CGRectMake((self.topLayerOptionsView.frame.size.width - collectiveButtonSize)/ 2.f, (self.topLayerOptionsView.frame.size.height - buttonSize) /2.f, buttonSize, buttonSize)];
    self.todayButton.backgroundColor = [UIColor lightGrayColor];
    
    self.favoriteButton = [[UIButton alloc] initWithFrame: CGRectMake(self.todayButton.frame.origin.x + self.todayButton.frame.size.width + buttonPadding, (self.topLayerOptionsView.frame.size.height - buttonSize) / 2.f, buttonSize, buttonSize)];
    self.favoriteButton.backgroundColor = [UIColor lightGrayColor];
    
    //add the subviews to the options view
    [self.optionsView addSubview: self.bottomLayerOptionsView];
    [self.optionsView addSubview: self.topLayerOptionsView];
    [self.topLayerOptionsView addSubview: self.todayButton];
    [self.topLayerOptionsView addSubview: self.favoriteButton];
    
    [self.view addSubview: self.optionsView];
    

}


#pragma  mark - Helper Methods

- (void) resizeOptionsViewWithDuration: (NSTimeInterval) duration {
    [UIView animateWithDuration: duration animations:^{
        CGRect optionsViewFrame = CGRectMake(0, self.calendar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.calendar.frame.size.height);
        self.optionsView.frame = optionsViewFrame;
        
        CGRect bottomLayerFrame = CGRectMake(bottomLayerBorderDistance, bottomLayerBorderDistance, self.optionsView.frame.size.width - (2* bottomLayerBorderDistance), self.optionsView.frame.size.height - (2* bottomLayerBorderDistance));
        self.bottomLayerOptionsView.frame = bottomLayerFrame;
        
        CGRect topLayerFrame = CGRectMake(bottomLayerBorderDistance * 2, bottomLayerBorderDistance * 2, self.optionsView.frame.size.width - (4* bottomLayerBorderDistance), self.optionsView.frame.size.height - (4* bottomLayerBorderDistance));
        
        self.topLayerOptionsView.frame = topLayerFrame;
        
        
        CGFloat collectiveButtonSize = (buttonSize * 2) + buttonPadding;
        CGRect todayButtonFrame = CGRectMake((self.topLayerOptionsView.frame.size.width - collectiveButtonSize)/ 2.f, (self.topLayerOptionsView.frame.size.height - buttonSize) /2.f, buttonSize, buttonSize);
        
        self.todayButton.frame = todayButtonFrame;
        
        CGRect favoriteButtonFrame = CGRectMake(self.todayButton.frame.origin.x + self.todayButton.frame.size.width + buttonPadding, (self.topLayerOptionsView.frame.size.height - buttonSize) / 2.f, buttonSize, buttonSize);
        
        self.favoriteButton.frame = favoriteButtonFrame;

    }];
    
}


#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setup];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear: YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Modal View Prep

- (void) displayResultsFromDate: (NSDate*) start toDate: (NSDate*) end {
    [self addClassesToModalViewFromDate: start toDate:end];
    [self presentViewController: self.modalView animated: YES completion:nil];
    [self.modalView.tableView reloadData];
}

- (void) addClassesToModalViewFromDate: (NSDate*) start toDate: (NSDate*) end {
    
    while ([start compare: end] != NSOrderedDescending) {
        [self.collection GFClassesForYear: start.year month:start.month day:start.day block:^(NSError *error, NSArray *GFClasses) {
            //must check for errors
            if (GFClasses.count) {
                NSDateFormatter* formatDate = [[NSDateFormatter alloc] init];
                formatDate.timeStyle = NSDateFormatterNoStyle;
                formatDate.dateStyle = NSDateFormatterMediumStyle;
                                NSString* dateString = [formatDate stringFromDate: start];
                [self.modalView.classData pushGFClasses: GFClasses withTitle: dateString];
            }
        }];
        
        start = [start dateByIncrementingDay];
    }
}

#pragma mark - Calendar Delegate

- (void)calendarView:(DSLCalendarView*)calendarView didSelectRange:(DSLCalendarRange*)range {
    NSDate* startDate = range.startDay.date;
    NSDate* endDate = range.endDay.date;
    
    BOOL fetchFromServer = ![self.collection dataLoadedForMonth: startDate.month year: startDate.year]
                        || ![self.collection dataLoadedForMonth: endDate.month year:endDate.year];
    
    BOOL makeTwoFetches = startDate.month != endDate.month;
    
    static MBProgressHUD* HUD;
    
    if (fetchFromServer && !HUD) {
        
        HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText = @"Loading";
        HUD.mode = MBProgressHUDModeIndeterminate;
    } else if (fetchFromServer) {
        //don't need to re-initialize the loading view
        [HUD show: YES];
    }
    
    [self.collection loadMonth: startDate.month andYear:startDate.year block:^(NSError *error, GFModel *model) {
        if (fetchFromServer && !makeTwoFetches) {
            [self displayResultsFromDate: startDate toDate: endDate];
            [HUD hide: YES];
        }
        
    }];
    
    if (makeTwoFetches) {
        [self.collection loadMonth: endDate.month andYear:endDate.year block:^(NSError *error, GFModel *model) {
            if (fetchFromServer) {
                [self displayResultsFromDate: startDate toDate: endDate];
                [HUD hide: YES];
            }
        }];
    }
    
}

- (void) calendarView:(DSLCalendarView *)calendarView willChangeToVisibleMonth:(NSDateComponents *)month duration:(NSTimeInterval)duration {
    [self resizeOptionsViewWithDuration: duration];
}



@end
