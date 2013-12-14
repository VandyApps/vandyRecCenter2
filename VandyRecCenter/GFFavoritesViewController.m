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

#import "PopoverView.h"

@interface GFFavoritesViewController ()

@property (nonatomic, strong) NSIndexPath* queuedIndexPath;
@property (nonatomic, strong) PopoverView* pv;
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

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
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
    static NSString* emptyCellIdentifier = @"NoFavoritesCell";
    
    UITableViewCell* cell;
    if ([GFFavorites sharedInstance].count) {
        cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        
    } else  {
        cell = [tableView dequeueReusableCellWithIdentifier: emptyCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:emptyCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if (indexPath.row == 1) {
            [self emptyListLabelForCell: cell].text = @"No Favorites";
            [self emptyDetailsLabelForCell: cell].text = @"Add Your Favorite Fitness Classes to Save and View Here";
        }
        
    }
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ([GFFavorites sharedInstance].count) ? [GFFavorites sharedInstance].count : 2;
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

- (UILabel*) emptyListLabelForCell: (UITableViewCell*) cell {
    static NSInteger EmptyLabelTag = 1;
    if ([cell viewWithTag: EmptyLabelTag] == nil) {
        UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(10, 20, self.tableView.frame.size.width - 20, 30)];
        label.tag = EmptyLabelTag;
        label.font = [UIFont systemFontOfSize: 17];
        label.textAlignment = NSTextAlignmentCenter;
        [cell addSubview: label];
    }
    return (UILabel*) [cell viewWithTag: EmptyLabelTag];
}

- (UILabel*) emptyDetailsLabelForCell: (UITableViewCell*) cell {
    static NSInteger EmptyDetailsLabelTag= 2;
    if ([cell viewWithTag: EmptyDetailsLabelTag] == nil) {
        UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(30, 50, self.tableView.frame.size.width - 60, 40)];
        label.tag = EmptyDetailsLabelTag;
        label.font = [UIFont systemFontOfSize: 13];
        label.textColor = [UIColor blueColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 2;
        [cell addSubview: label];
    }
    return (UILabel*) [cell viewWithTag: EmptyDetailsLabelTag];
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
        self.queuedIndexPath = indexPath;
        UIAlertView* deletionAlert = [[UIAlertView alloc] initWithTitle: @"Remove Fitness Class" message: @"Are you sure you want to remove this Group Fitness Class from your list of favorites" delegate:self cancelButtonTitle: @"NO" otherButtonTitles: @"YES", nil];
        [deletionAlert show];
        
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray* dates;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    df.timeStyle = NSDateFormatterNoStyle;
    dates = @[];
    
    for (NSDate* date in [[GFFavorites sharedInstance] GFFavoriteForIndex: indexPath.row].cancelledDates) {
        
        NSDate* currentDate = [NSDate new];
        //remove the time from the current day
        NSDate* today = [NSDate dateWithYear: currentDate.year month: currentDate.month andDay:currentDate.day];
        if (![today compare: date] == NSOrderedDescending) {
            dates = [dates arrayByAddingObject: [df stringFromDate: date]];
        }
    }
    if (dates.count == 0) {
        dates = [dates arrayByAddingObject: @"None!"];
    }
    
    UITableViewCell* cell = [tableView cellForRowAtIndexPath: indexPath];
    self.pv = [PopoverView showPopoverAtPoint: cell.center inView: tableView withTitle:@"Cancelled Dates" withStringArray: dates delegate: nil];
    
}
#pragma mark - Alert View Delegate

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[GFFavorites sharedInstance] removeFromIndex: self.queuedIndexPath.row];
        [self.tableView deleteRowsAtIndexPaths: @[self.queuedIndexPath] withRowAnimation: UITableViewRowAnimationTop];
    }

}

#pragma mark - Events

- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated: YES completion:nil];
}

@end
