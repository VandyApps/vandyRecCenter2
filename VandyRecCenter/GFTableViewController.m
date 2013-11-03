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
    NSDictionary* class = [self.classData GFClassForIndexPath: indexPath];
    
    UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(20, 10, 200, 20)];
    label.text = [class objectForKey: @"className"];
    [cell addSubview: label];
    return cell;
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
