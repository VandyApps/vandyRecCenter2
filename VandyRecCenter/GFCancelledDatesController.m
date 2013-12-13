//
//  GFCancelledDatesController.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 12/13/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "GFCancelledDatesController.h"

@interface GFCancelledDatesController ()

@property (nonatomic, strong) NSDateFormatter* format;

@end

@implementation GFCancelledDatesController


#pragma mark - Getters
- (NSDateFormatter*) format {
    if (_format == nil) {
        _format = [[NSDateFormatter alloc] init];
        _format.dateStyle = NSDateFormatterMediumStyle;
        _format.timeStyle = NSDateFormatterNoStyle;
    }
    return _format;
}

- (id) init {
    self = [super initWithStyle: UITableViewStylePlain];
    return self;
}


#pragma mark - Lifecycle

- (void) viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (self.cancelledDates.count) ? self.cancelledDates.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
    }
    
    if (self.cancelledDates.count) {
        cell.textLabel.text = [self.format stringFromDate: self.cancelledDates[indexPath.row]];
    } else {
        cell.textLabel.text = @"No Cancelled Dates";
    }
    
    return cell;
}

@end
