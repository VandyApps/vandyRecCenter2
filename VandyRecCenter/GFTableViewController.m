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
}

- (void) clearClasses {
    self.GFClassesForTable = @[];
}

@end


@implementation GFTableViewController

- (IBAction)done:(id)sender {
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
    UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(20, 10, 200, 20)];
    label.text = @"This is the title";
    [cell addSubview: label];
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
/*
- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.GFClassesToDisplay.count) {
        UIView* header = [[UIView alloc] init];
        CAGradientLayer* gradient = [[CAGradientLayer alloc] init];
        gradient.frame = CGRectMake(0, 0, self.view.frame.size.width, 24);
        gradient.colors  = @[(id) [UIColor blackColor].CGColor,(id) [UIColor darkGrayColor].CGColor];
        [header.layer insertSublayer: gradient atIndex: 0];
        
        UILabel* headerTitle = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 20)];
        
        headerTitle.textColor = [UIColor whiteColor];
        headerTitle.font = [UIFont systemFontOfSize: 12];
        headerTitle.textAlignment = NSTextAlignmentCenter;
        headerTitle.backgroundColor = [UIColor clearColor];
        headerTitle.text = [[self.GFClassesToDisplay objectAtIndex: section] objectForKey: @"timeRange"];
        [header addSubview: headerTitle];
        
        return header;
    }
    return  nil;
}
 */

#pragma mark - TableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
@end
