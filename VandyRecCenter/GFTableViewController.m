//
//  GFTableViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/11/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "GFTableViewController.h"

@implementation GFTableViewController


#pragma mark - Lifecycle

- (void) viewDidLoad:(BOOL)animated {
    [super viewDidAppear: animated];
}
#pragma mark - TableViewDataSource

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger count = self.GFClassesToDisplay.count;
    NSLog(@"Count is %i", count);
    if (count == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noDataCell"];
        [[cell textLabel] setTextAlignment:NSTextAlignmentCenter];
        [[cell textLabel] setTextColor:[UIColor colorWithWhite:0.2 alpha:0.8]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        if ([indexPath row] == 1) {
            [[cell textLabel] setText:NSLocalizedString(@"No Group Fitness Classes", @"A label for a table with no Group Fitness Classes.")];
        }
        else
        {
            [[cell textLabel] setText:@""];
        }
        return cell;
    }
    
    //count > 0 here
    NSDictionary* GFClass = [self.GFClassesToDisplay objectAtIndex: indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"groupFitnessCell"];
    if (!cell) {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed: @"GroupFitnessCell" owner: self options:nil];
        cell = [nib objectAtIndex: 0];
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"groupFitnessCell"];
    }
    [(UILabel*)[cell viewWithTag: CELL_CLASSNAME_LABEL] setText: [GFClass objectForKey: @"className" ]];
    return cell;
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.GFClassesToDisplay.count == 0) {
        return 2;
    }
    return self.GFClassesToDisplay.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140.f;
}

#pragma mark - TableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
@end
