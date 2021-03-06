//
//  GFTableViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/11/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "GFTableViewController.h"
#import "MBProgressHUD.h"
#import "BMAddRemoveButton.h"
#import "GFFavorites.h"

#import "DateHelper.h"

@interface GFTableViewClassData()

@property (nonatomic, strong) NSArray* GFClassesForTable;

@end

@implementation GFTableViewClassData

@synthesize sectionCount = _sectionCount;
@synthesize GFClassesForTable = _GFClassesForTable;

- (NSArray*) GFClassesForTable {
    if (_GFClassesForTable == nil) {
        _GFClassesForTable = [[NSArray alloc] init];
    }
    return _GFClassesForTable;
}


- (NSUInteger) sectionCount {
    return _GFClassesForTable.count;
}

- (NSUInteger) countForGFClassesInSectionAtIndex: (NSUInteger) index {
    return [[_GFClassesForTable[index] objectForKey: @"GFClasses"] count];
}
- (NSDate*) dateForSectionAtIndex: (NSUInteger) index {
    return [_GFClassesForTable[index] objectForKey: @"date"];
}
- (NSDictionary*) GFClassForIndexPath: (NSIndexPath*) indexPath {
    NSArray* GFClasses = [_GFClassesForTable[indexPath.section] objectForKey: @"GFClasses"];
    return GFClasses[indexPath.row];
}

- (void) pushGFClasses: (NSArray*) GFClasses withDate: (NSDate*) date {
    NSDictionary* newEntry = @{@"date": date, @"GFClasses": GFClasses};
    _GFClassesForTable = [self.GFClassesForTable arrayByAddingObject: newEntry];
}

- (void) clearClasses {
    self.GFClassesForTable = @[];
}

@end

@implementation GFTableViewController

@synthesize tableView = _tableView;
@synthesize classData = _classData;
@synthesize titleView = _titleView;
@synthesize header = _header;


#pragma mark - Static Members
static NSInteger CancelViewTag = 10;


#pragma mark - Getters

- (GFTableViewClassData*) classData {
    if (_classData == nil) {
        _classData = [[GFTableViewClassData alloc] init];
    }
    
    return _classData;
}


#pragma mark - Setters

- (void) setHeader:(NSString *)header {
    _header = header;
    _titleView.text = _header;
}

#pragma mark - Events

- (IBAction)done:(id)sender {
    [self.classData clearClasses];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Lifecycle
- (void) viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    self.navigationView.backgroundColor = vanderbiltGold;
    _titleView.text = _header;
}



#pragma mark - TableViewDataSource

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* cellIdentifier = @"cell";
    static NSString* blankCellIdentifier = @"emptyCell";
    
    
    UITableViewCell* cell;
    
    if (self.classData.sectionCount) {
       cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier: blankCellIdentifier];
    }
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (self.classData.sectionCount) {
        [self setupTableViewForCell: cell atIndexPath: indexPath];
    } else {
        [self setupBlankTableViewCell: cell];
    }
    
    return cell;
}

- (void) setupTableViewForCell: (UITableViewCell*) cell atIndexPath: (NSIndexPath*) indexPath {
    NSDictionary* class = [self.classData GFClassForIndexPath: indexPath];
    
    static NSUInteger classNameLabelTag = 1;
    static NSUInteger hoursLabelTag = 2;
    static NSUInteger instructorLabelTag = 3;
    static NSUInteger locationLabelTag = 4;
    static NSUInteger addButtonTag = 5;
    static NSUInteger blankCellTag = 6;
    
    UILabel* classNameLabel;
    UILabel* hoursLabel;
    UILabel* instructorLabel;
    UILabel* locationLabel;
    BMAddRemoveButton* addButton;
    UILabel* blankCellLabel;

    classNameLabel = (UILabel*) [cell viewWithTag: classNameLabelTag];
    hoursLabel = (UILabel*) [cell viewWithTag: hoursLabelTag];
    instructorLabel = (UILabel*) [cell viewWithTag: instructorLabelTag];
    locationLabel = (UILabel*) [cell viewWithTag: locationLabelTag];
    addButton = (BMAddRemoveButton*) [cell viewWithTag: addButtonTag];
    blankCellLabel = (UILabel*) [cell viewWithTag: blankCellTag];
    
#warning Separate management of these views into their own methods
    if (classNameLabel == nil) {
        classNameLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 10, 230, 30)];
        classNameLabel.tag = classNameLabelTag;
        [cell addSubview: classNameLabel];
    }
    
    if (hoursLabel == nil) {
        hoursLabel = [[UILabel alloc] initWithFrame: CGRectMake(30, 45, 200, 15)];
        hoursLabel.tag = hoursLabelTag;
        [cell addSubview: hoursLabel];
    }
    
    if (instructorLabel == nil) {
        instructorLabel = [[UILabel alloc] initWithFrame: CGRectMake(30, 65, 200, 15)];
        instructorLabel.tag = instructorLabelTag;
        [cell addSubview: instructorLabel];
    }
    
    if (locationLabel == nil) {
        locationLabel = [[UILabel alloc] initWithFrame: CGRectMake(30, 85, 200, 15)];
        locationLabel.tag = locationLabelTag;
        [cell addSubview: locationLabel];
    }
    
    if (addButton == nil) {
        addButton = [[BMAddRemoveButton alloc] initWithFrame:CGRectMake(cell.frame.size.width - 30 - 10, 120/2.f - 30/2.f, 30, 30)];
        addButton.tag = addButtonTag;
        
        [cell addSubview: addButton];
    }
    
    if (blankCellLabel) {
        [blankCellLabel removeFromSuperview];
    }
    
    classNameLabel.text = [class objectForKey: @"className"];
    
    
    hoursLabel.text = [class objectForKey: @"timeRange"];
    hoursLabel.font = [UIFont systemFontOfSize: 12];
    hoursLabel.textColor = [UIColor blueColor];
    
    instructorLabel.text = [class objectForKey: @"instructor"];
    instructorLabel.font = [UIFont systemFontOfSize: 12];
    instructorLabel.textColor = [UIColor blueColor];
    
    locationLabel.text = [class objectForKey: @"location"];
    locationLabel.font = [UIFont systemFontOfSize: 12];
    locationLabel.textColor = [UIColor blueColor];
    
    [addButton addTarget: self action: @selector(addButtonClicked:) forControlEvents: UIControlEventTouchUpInside];
    addButton.selected = [[GFFavorites sharedInstance] contains: class];
    addButton.info = @{@"GFClass": class};
    
    
    if ([self GFClass: class isCanceledOnDate: [self.classData dateForSectionAtIndex: indexPath.section]]) {
        [self addCancelViewToCell: cell];
    } else {
        [self removeCancelViewFromCell: cell];
    }
    
}


- (UIView*) addCancelViewToCell: (UITableViewCell*) cell {
    
    if ([cell viewWithTag: CancelViewTag] == nil) {
        
        UIView* cancelView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, self.tableView.frame.size.width, 110.f)];
        cancelView.tag = CancelViewTag;
        cancelView.backgroundColor = [UIColor blackColor];
        cancelView.alpha = .6;
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, cancelView.frame.size.height / 2.f - 50.f/2.f, self.tableView.frame.size.width, 40.f)];
        label.text = @"Cancelled";
        label.textColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize: 25.f];
        
        [cancelView addSubview: label];
        [cell addSubview: cancelView];
    }
    return [cell viewWithTag: CancelViewTag];
}

- (void) removeCancelViewFromCell: (UITableViewCell*) cell {
    
    if ([cell viewWithTag: CancelViewTag]) {
        [[cell viewWithTag: CancelViewTag] removeFromSuperview];
    }
}
- (void) setupBlankTableViewCell: (UITableViewCell*) cell {
    static NSUInteger blankLabelTag = 6;
    
    UILabel* blankLabel = (UILabel*) [cell viewWithTag: blankLabelTag];
    
    if (blankLabel == nil) {
        blankLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        blankLabel.tag = blankLabelTag;
        [cell addSubview: blankLabel];
    }
    
    blankLabel.textAlignment = NSTextAlignmentCenter;
    blankLabel.text = @"No Group Fitness Classes";
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (self.classData.sectionCount) ? 110.f : 50.f;
}


- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    static NSDateFormatter* format;
    if (!format) {
        format = [[NSDateFormatter alloc] init];
        format.dateStyle = NSDateFormatterShortStyle;
        format.timeStyle = NSDateFormatterNoStyle;
    }
    NSDate* date = (self.classData.sectionCount) ? [self.classData dateForSectionAtIndex: section] : nil;
    
    return (self.classData.sectionCount) ? [NSString stringWithFormat: @"%@, %@", [format stringFromDate: [self.classData dateForSectionAtIndex: section]], [DateHelper weekDayForIndex: date.weekDay]] : @"TRY ANOTHER DATE";
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (self.classData.sectionCount) ? [self.classData countForGFClassesInSectionAtIndex: section] : 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return (self.classData.sectionCount) ? self.classData.sectionCount : 1;
}

#pragma mark Add button

- (void) addButtonClicked: (BMAddRemoveButton*) sender {
    sender.selected = !sender.selected;
    NSString* message;
    if (sender.selected) {
        message = @"Class Added";
        [[GFFavorites sharedInstance] add: [sender.info objectForKey: @"GFClass"]];
    } else {
        message = @"Class Removed";
        [[GFFavorites sharedInstance] remove: [sender.info objectForKey: @"GFClass"]];
    }
    [[GFFavorites sharedInstance] save];
    
    
    MBProgressHUD* HUD = [MBProgressHUD showHUDAddedTo: self.tableView animated: YES];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"37x-Checkmark.png"]];
    HUD.labelText = message;
    [HUD hide: YES afterDelay: .7];

}

#pragma mark - Helpers

#warning This should be part of the model
- (BOOL) GFClass: (NSDictionary*) GFClass isCanceledOnDate: (NSDate*) date {
    
    for (NSString* dateString in [GFClass objectForKey: @"cancelledDates"]) {
        NSLog(@"%@", date);
        
        if ([[NSDate dateWithDateString: dateString] compare: date] == NSOrderedSame) {
            return YES;
        }
    }
    return NO;
}

@end
