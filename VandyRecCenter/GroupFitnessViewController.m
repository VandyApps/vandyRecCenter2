
#import "GroupFitnessViewController.h"

#import "GFTableViewController.h"
#import "GFFavoritesViewController.h"

#import "GFCollection.h"
#import "MBProgressHUD.h"
#import "DSLCalendarView.h"
#import "NSDate-MyDateClass.h"

#import "ErrorHandler.h"

@interface GroupFitnessViewController () <DSLCalendarViewDelegate>

@property (nonatomic, strong) UIView* optionsView;
@property (nonatomic, strong) UIView* optionsContentView;
@property (nonatomic, strong) MBProgressHUD* HUD;

@end

@implementation GroupFitnessViewController

#pragma mark - Synthesize
@synthesize collection = _collection;
@synthesize calendar = _calendar;
@synthesize classModalView = _classModalView;
@synthesize optionsView = _optionsView;

#pragma mark - Private Static Variables
static CGFloat OptionsViewPadding = 6.f;
static CGFloat buttonSize = 40.f;
static CGFloat buttonPadding = 100.f;

#pragma mark - Getters

- (GFCollection*) collection {
    if (!_collection) {
        _collection = [[GFCollection alloc] init];
    }
    return _collection;
}


- (GFTableViewController*) classModalView {
    if (!_classModalView) {
        _classModalView = [[GFTableViewController alloc] initWithNibName: @"GFTableView" bundle: [NSBundle mainBundle]];
    }
    return _classModalView;
}

- (GFFavoritesViewController*) favoritesModalView {
    if (!_favoritesModalView) {
        _favoritesModalView = [[GFFavoritesViewController alloc] initWithNibName: @"GFFavoritesView" bundle: [NSBundle mainBundle]];
    }
    return _favoritesModalView;
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear: YES];
    static BOOL initialSetup = YES;
    if (initialSetup) {
        initialSetup = NO;
        [self setup];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Setup

/* facade for setup methods*/
- (void) setup {
    [self setUpCalendar];
    [self setUpOptionPanel];
    [self setupObservers];
}
- (void) setUpCalendar {
    self.calendar.delegate = self;
    [self.view addSubview: self.calendar];
}

- (void) setupObservers {
    [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(networkConnectionFailed:) name:NetworkErrorConnection object: nil];
}

- (void) networkConnectionFailed: (NSNotification*) notification {
    [self.HUD hide: YES];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle: @"Network Error" message: @"Could not connect to the internet, please check your connection" delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
    [alert show];
}

/* this should be called after setUpCalendar*/
- (void) setUpOptionPanel {
    
    self.optionsView = [[UIView alloc] initWithFrame: CGRectMake(0, self.calendar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.calendar.frame.size.height)];
    
    self.optionsView.backgroundColor = [UIColor colorWithRed: .95f green: .95f blue: .95f alpha:1];

    self.optionsContentView = [[UIView alloc] initWithFrame: CGRectMake(OptionsViewPadding * 2, OptionsViewPadding * 2, self.optionsView.frame.size.width - (4* OptionsViewPadding), self.optionsView.frame.size.height - (4* OptionsViewPadding))];
    self.optionsContentView.layer.cornerRadius = 10.f;
    UIColor* vandyGold = vanderbiltGold;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    [vandyGold getRed: &red green: &green blue: &blue alpha: &alpha];
    UIColor* backgroundColor = [UIColor colorWithRed: red green: green blue: blue alpha: .5];
    self.optionsContentView.layer.backgroundColor = backgroundColor.CGColor;
    
    //create the buttons to the interface
    //buttons are to be nested within the bottomLayer for the
    //options view
    CGFloat collectiveButtonSize = (buttonSize * 2) + buttonPadding;
    
    //today button setup
    self.todayButton = [[UIButton alloc] initWithFrame: CGRectMake((self.optionsContentView.frame.size.width - collectiveButtonSize)/ 2.f, (self.optionsContentView.frame.size.height - buttonSize) /2.f, buttonSize, buttonSize)];
    UIImage* todayButtonIcon = [UIImage imageNamed:@"426-calendar.png"];
    
    [self.todayButton setImage: todayButtonIcon forState: UIControlStateNormal];
    [self.todayButton addTarget: self action: @selector(todayButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //favorite button setup
    self.favoriteButton = [[UIButton alloc] initWithFrame: CGRectMake(self.todayButton.frame.origin.x + self.todayButton.frame.size.width + buttonPadding, (self.optionsContentView.frame.size.height - buttonSize) / 2.f, buttonSize, buttonSize)];
    UIImage* favoriteButtonIcon = [UIImage imageNamed: @"428-checkmark1.png"];
    
    [self.favoriteButton setImage: favoriteButtonIcon forState: UIControlStateNormal];
    [self.favoriteButton addTarget: self action: @selector(favoriteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //add the subviews to the options view
    [self.optionsView addSubview: self.optionsContentView];
    [self.optionsContentView addSubview: self.todayButton];
    [self.optionsContentView addSubview: self.favoriteButton];
    
    [self.view addSubview: self.optionsView];
    

}

#pragma mark - Events

- (void) todayButtonPressed: (id) sender {
    NSDateComponents* start = [[NSDateComponents alloc] init];
    NSDateComponents* end = [[NSDateComponents alloc] init];
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    
    //calculate beginning of week
    NSDate* iterationDate = [[NSDate alloc] init];
    while ([iterationDate weekDayForTimeZone: NashvilleTime] != 0) {
        iterationDate = [iterationDate dateByDecrementingDay];
        
    }
    start.day = [iterationDate dayForTimeZone: NashvilleTime];
    start.month = [iterationDate monthForTimeZone: NashvilleTime] + 1;
    start.year = [iterationDate yearForTimeZone: NashvilleTime];
    start.calendar = calendar;
    
    //calculate end of week
    iterationDate = [iterationDate dateByAddingTimeInterval: 60 * 60 * 24 * 6];
    end.day = [iterationDate dayForTimeZone: NashvilleTime];
    end.month = [iterationDate monthForTimeZone: NashvilleTime] + 1;
    end.year = [iterationDate yearForTimeZone: NashvilleTime];
    end.calendar = calendar;
    
    DSLCalendarRange* thisWeek = [[DSLCalendarRange alloc] initWithStartDay:start endDay:end];
    self.calendar.selectedRange = thisWeek;
    [self.calendar.delegate calendarView: self.calendar didSelectRange: thisWeek];
}

- (void) favoriteButtonPressed: (id) sender {
    [self presentViewController: self.favoritesModalView animated: YES completion:nil];
    
}

#pragma  mark - Helper Methods

- (void) resizeOptionsViewWithDuration: (NSTimeInterval) duration {
    [UIView animateWithDuration: duration animations:^{
        CGRect optionsViewFrame = CGRectMake(0, self.calendar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.calendar.frame.size.height);
        self.optionsView.frame = optionsViewFrame;
        
        CGRect topLayerFrame = CGRectMake(OptionsViewPadding * 2, OptionsViewPadding * 2, self.optionsView.frame.size.width - (4* OptionsViewPadding), self.optionsView.frame.size.height - (4* OptionsViewPadding));
        
        self.optionsContentView.frame = topLayerFrame;
        
        
        CGFloat collectiveButtonSize = (buttonSize * 2) + buttonPadding;
        CGRect todayButtonFrame = CGRectMake((self.optionsContentView.frame.size.width - collectiveButtonSize)/ 2.f, (self.optionsContentView.frame.size.height - buttonSize) /2.f, buttonSize, buttonSize);
        
        self.todayButton.frame = todayButtonFrame;
        
        CGRect favoriteButtonFrame = CGRectMake(self.todayButton.frame.origin.x + self.todayButton.frame.size.width + buttonPadding, (self.optionsContentView.frame.size.height - buttonSize) / 2.f, buttonSize, buttonSize);
        
        self.favoriteButton.frame = favoriteButtonFrame;

    }];
    
}



#pragma mark - Modal View Prep

- (void) displayResultsFromDate: (NSDate*) start toDate: (NSDate*) end {

    [self addClassesToModalViewFromDate: start toDate:end];
    [self.classModalView.tableView reloadData];
    
    [self presentViewController: self.classModalView animated: YES completion: nil];
    
}

- (void) addClassesToModalViewFromDate: (NSDate*) start toDate: (NSDate*) end {
    
    while ([start compare: end] != NSOrderedDescending) {
        //this should not be making network calls because this method is invoked AFTER
        //all the data is fethed from the network
        [self.collection GFClassesForYear: start.year month:start.month day:start.day block:^(NSArray *GFClasses) {
            
            if (GFClasses.count) {
                [self.classModalView.classData pushGFClasses: GFClasses withDate: [NSDate dateWithYear:start.year month:start.month andDay:start.day]];
            }
        }];
        
        start = [start dateByIncrementingDay];
    }
}

#pragma mark - Calendar Delegate

- (void)calendarView:(DSLCalendarView*)calendarView didSelectRange:(DSLCalendarRange*)range {
    NSDate* startDate = range.startDay.date;
    NSDate* endDate = range.endDay.date;
    
    //set the title of the modal view
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterShortStyle;
    df.timeStyle = NSDateFormatterNoStyle;
    self.classModalView.header = ([startDate compare: endDate] != NSOrderedSame) ?
    [NSString stringWithFormat: @"%@ - %@", [df stringFromDate: startDate], [df stringFromDate: endDate]] :
    [df stringFromDate: startDate];
    
    NSUInteger month_it = startDate.month;
    NSUInteger year_it = startDate.year;
    
    BOOL fetchFromServer = YES;
    while (month_it <= endDate.month && year_it <= endDate.year && fetchFromServer) {
        
        //update boolean
        fetchFromServer = ![self.collection dataLoadedForMonth: month_it year:year_it];
        
        //increment
        month_it = (month_it + 1) % 12;
        year_it = (month_it) ? year_it : year_it + 1;
        
    }
    
    //BOOL fetchFromServer = ![self.collection dataLoadedForMonth: startDate.month year: startDate.year]
                        //|| ![self.collection dataLoadedForMonth: endDate.month year:endDate.year];
    
    if (fetchFromServer) {
        NSLog(@"Fetching from server");
        [self fetchAndDisplayDataFromServerFromStartDate: startDate toEndDate: endDate];
    } else {
        NSLog(@"Not Fetching from server");
        [self displayResultsFromDate: startDate toDate: endDate];
    }
}

- (void) fetchAndDisplayDataFromServerFromStartDate: (NSDate*) startDate toEndDate: (NSDate*) endDate {
    
    
    self.HUD = [MBProgressHUD showHUDAddedTo: self.view animated: YES];
    self.HUD.mode = MBProgressHUDModeIndeterminate;
    self.HUD.labelText = @"Loading...";
    
    NSUInteger numberOfFetches = (endDate.month + endDate.year * 12) - (startDate.month + startDate.year * 12) + 1;
    __block NSUInteger remainingFetches = numberOfFetches;
    
    NSUInteger month = startDate.month;
    NSUInteger year = startDate.year;
    
    for (NSUInteger i = 0 ; i < numberOfFetches; ++i) {
        
        __block NSUInteger a_month = month;
        __block NSUInteger a_year = year;
        
        //fetch
        [self.collection loadMonth: startDate.month andYear:startDate.year block:^(GFModel *model) {
            --remainingFetches;
            NSLog(@"should decrement: %i", remainingFetches);
            if (!remainingFetches) {
                [self.HUD hide: YES];
                [self displayResultsFromDate: startDate toDate: endDate];
            }
        }];
        
        //increment month
        a_month = (a_month + 1) % 12;
        a_year = (a_month) ? a_year : a_year + 1;
        
    }

}

- (void) calendarView:(DSLCalendarView *)calendarView willChangeToVisibleMonth:(NSDateComponents *)month duration:(NSTimeInterval)duration {
    [self resizeOptionsViewWithDuration: duration];
}



@end
