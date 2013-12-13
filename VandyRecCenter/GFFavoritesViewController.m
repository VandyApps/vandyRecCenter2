//
//  GFFavoritesViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 12/12/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "GFFavoritesViewController.h"
#import "BMContainerButton.h"

#import "GFFavorites.h"
#import "DateHelper.h"
@interface GFFavoritesViewController ()

@end

@implementation GFFavoritesViewController


@synthesize headerView = _headerView;
@synthesize tableView = _tableView;

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.headerView.backgroundColor = vanderbiltGold;
	// Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated {
    [[GFFavorites sharedInstance] sort];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View DataSource

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"GFFavoritesCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    GFFavorite* favorite = [[GFFavorites sharedInstance] GFFavoriteForIndex: indexPath.row];
    [self classNameLabelForCell: cell].text = favorite.className;
    [self instructorNameLabelForCell: cell].text = favorite.instructor;
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterShortStyle;
    df.timeStyle = NSDateFormatterNoStyle;
    
    if (favorite.endDate) {
        [self datesLabelForCell: cell].text = [NSString stringWithFormat: @"Takes place from %@ to %@",
                                               [df stringFromDate: favorite.startDate],
                                               [df stringFromDate:favorite.endDate]];
    } else {
        [self datesLabelForCell: cell].text = [NSString stringWithFormat: @"Fitness classes start %@", [df stringFromDate:favorite.startDate]];
    }
    
    [self dailyInfoLabelForCell: cell].text = [NSString stringWithFormat: @"%@s from %@ to %@", [DateHelper weekDayForIndex: favorite.weekDay], favorite.startTime, favorite.endTime];
    
    BMContainerButton* cancelledDatesButton = [self cancelledDatesButtonForCell: cell];
    cancelledDatesButton.info = @{@"cancelledDates" : favorite.cancelledDates};
    [cancelledDatesButton addTarget: self action: @selector(cancelButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [GFFavorites sharedInstance].count;
}

#pragma mark TableViewCell subviews

- (UILabel*) classNameLabelForCell: (UITableViewCell*) cell {
    static NSInteger ClassNameLabelTag = 1;
    if ([cell viewWithTag: ClassNameLabelTag] == nil) {
        UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(10, 10, self.tableView.frame.size.width - 20, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = ClassNameLabelTag;
        [cell addSubview: label];
    }
    return (UILabel*) [cell viewWithTag: ClassNameLabelTag];
}

- (UILabel*) instructorNameLabelForCell: (UITableViewCell*) cell {
    static NSInteger InstructorNameLabelTag = 2;
    if ([cell viewWithTag: InstructorNameLabelTag] == nil) {
        UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(10, 10 + 20 + 5, 100, 15)];
        label.tag = InstructorNameLabelTag;
        label.textColor = [UIColor blueColor];
        label.font = [UIFont systemFontOfSize:12.f];
        [cell addSubview: label];
    }
    return (UILabel*) [cell viewWithTag: InstructorNameLabelTag];
}

- (UILabel*) datesLabelForCell: (UITableViewCell*) cell {
    static NSInteger DatesLabelTag = 3;
    if ([cell viewWithTag: DatesLabelTag] == nil) {
        UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(10, 10 + 20 + 5 + 15 + 5, 200, 15)];
        label.tag = DatesLabelTag;
        label.textColor = [UIColor blueColor];
        label.font = [UIFont systemFontOfSize: 12.f];
        [cell addSubview: label];
    }
    return (UILabel*) [cell viewWithTag: DatesLabelTag];
}

- (UILabel*) dailyInfoLabelForCell: (UITableViewCell*) cell {
    static NSInteger DailyInfoLabelTag = 4;
    if ([cell viewWithTag: DailyInfoLabelTag] == nil) {
        UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(10, 10 + 20 + 5 + 15 + 5 + 15 + 5, 200, 15)];
        label.tag = DailyInfoLabelTag;
        label.textColor = [UIColor blueColor];
        label.font = [UIFont systemFontOfSize: 12.f];
        [cell addSubview: label];
    }
    return (UILabel*) [cell viewWithTag: DailyInfoLabelTag];
}

- (BMContainerButton*) cancelledDatesButtonForCell: (UITableViewCell*) cell {
    static NSInteger CancelledDatesButtonTag = 5;
    if ([cell viewWithTag: CancelledDatesButtonTag] == nil) {
        BMContainerButton* button = [[BMContainerButton alloc] initWithFrame: CGRectMake(self.tableView.frame.size.width - 40 - 30, 45.f, 30, 30)];
        
        button.tag = CancelledDatesButtonTag;
        [button setImage:[UIImage imageNamed: @"298-circlex.png"] forState: UIControlStateNormal];
        [cell addSubview: button];
    }
    return (BMContainerButton*) [cell viewWithTag: CancelledDatesButtonTag];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110.f;
}

#pragma mark - Table View Delegate

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //[[GFFavorites sharedInstance] remove: ];
    }
}

#pragma mark - Events

- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated: YES completion:nil];
}

- (void) cancelButtonSelected: (BMContainerButton*) sender {
#warning Implement me
    NSLog(@"Cancel selected with data: %@", [sender.info objectForKey: @"cancelledDates"]);
}
@end
