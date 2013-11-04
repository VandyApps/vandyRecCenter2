//
//  GFTableViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/11/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "GFTableViewController.h"
#import "MBProgressHUD.h"


@interface GFTableViewClassData()

@property (nonatomic, strong) NSArray* GFClassesForTable;

@end

@implementation GFTableViewClassData

@synthesize sectionCount = _sectionCount;
@synthesize GFClassesForTable = _GFClassesForTable;

- (NSArray*) GFClassesForTable {
    if (_GFClassesForTable == nil) {
        _GFClassesForTable = @[];
    }
    return _GFClassesForTable;
}


- (NSUInteger) sectionCount {
    return _GFClassesForTable.count;
}

- (NSUInteger) countForGFClassesInSectionAtIndex: (NSUInteger) index {
    return [[_GFClassesForTable[index] objectForKey: @"GFClasses"] count];
}
- (NSString*) titleForSectionAtIndex: (NSUInteger) index {
    return [_GFClassesForTable[index] objectForKey: @"title"];
}
- (NSDictionary*) GFClassForIndexPath: (NSIndexPath*) indexPath {
    NSArray* GFClasses = [_GFClassesForTable[indexPath.section] objectForKey: @"GFClasses"];
    return GFClasses[indexPath.row];
}

- (void) pushGFClasses: (NSArray*) GFClasses withTitle: (NSString*) title {
    NSDictionary* newEntry = @{@"title": title, @"GFClasses": GFClasses};
    self.GFClassesForTable = [_GFClassesForTable arrayByAddingObject: newEntry];
    NSLog(@"Table: %@",  self.GFClassesForTable);
}

- (void) clearClasses {
    self.GFClassesForTable = @[];
}

@end


@implementation GFTableViewController

@synthesize tableView = _tableView;
@synthesize classData = _classData;

#pragma mark - Getters

- (GFTableViewClassData*) classData {
    if (_classData == nil) {
        _classData = [[GFTableViewClassData alloc] init];
    }
    
    return _classData;
}

#pragma mark - Events

- (IBAction)done:(id)sender {
    [self.classData clearClasses];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Lifecycle

- (void) viewDidLoad:(BOOL)animated {
    [super viewDidAppear: animated];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationView.backgroundColor = vanderbiltGold;
}


#pragma mark - TableViewDataSource

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [self setupTableViewForCell: cell atIndexPath: indexPath];
    return cell;
}

- (void) setupTableViewForCell: (UITableViewCell*) cell atIndexPath: (NSIndexPath*) indexPath {
    NSDictionary* class = [self.classData GFClassForIndexPath: indexPath];
    
    static NSUInteger classNameLabelTag = 1;
    static NSUInteger hoursLabelTag = 2;
    static NSUInteger instructorLabelTag = 3;
    static NSUInteger locationLabelTag = 4;
    static NSUInteger addButtonTag = 5;
    
    UILabel* classNameLabel;
    UILabel* hoursLabel;
    UILabel* instructorLabel;
    UILabel* locationLabel;
    UIButton* addButton;

    classNameLabel = (UILabel*) [cell viewWithTag: classNameLabelTag];
    hoursLabel = (UILabel*) [cell viewWithTag: hoursLabelTag];
    instructorLabel = (UILabel*) [cell viewWithTag: instructorLabelTag];
    locationLabel = (UILabel*) [cell viewWithTag: locationLabelTag];
    addButton = (UIButton*) [cell viewWithTag: addButtonTag];
    
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
        addButton = [UIButton buttonWithType: UIButtonTypeContactAdd];
        addButton.frame = CGRectMake(cell.frame.size.width - 40 - 10, 120/2.f - 40/2.f, 40, 40);
        addButton.tag = addButtonTag;
        [cell addSubview: addButton];
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
}

- (void) setupBlankTableViewCell: (UITableViewCell*) cell {

   
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110.f;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [self.classData titleForSectionAtIndex: section];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.classData countForGFClassesInSectionAtIndex: section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.classData.sectionCount;
}

#pragma mark - TableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
@end
