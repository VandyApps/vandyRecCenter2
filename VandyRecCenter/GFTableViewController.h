//
//  GFTableViewController.h
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/11/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>



#define CELL_CLASSNAME_LABEL 1
#define CELL_INSTRUCTOR_LABEL 2
#define CELL_LOCATION_LABEL 3
#define CELL_TIMERANGE_LABEL 4
#define CELL_ADD_BUTTON 5


/*
 Collection of classes to display that are organized in a way that
 is easy for the table view controller to output to the view
 */
@interface GFTableViewClassData : NSObject

@property (nonatomic) NSUInteger sectionCount;
//private property needed which is an array of arrays
//another private property with an array of section titles
- (NSUInteger) countForGFClassesInSectionAtIndex: (NSUInteger) index;
- (NSString*) titleForSectionAtIndex: (NSUInteger) index;
- (NSDictionary*) GFClassForIndexPath: (NSIndexPath*) indexPath;

//add classes to the end of the table in a new section
- (void) pushGFClasses: (NSArray*) GFClasses withTitle: (NSString*) title;
//clear the enter set of classes
- (void) clearClasses;
@end


@interface GFTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray* GFClassesToDisplay;
@property (nonatomic, weak) IBOutlet UITableViewCell* cell;

@end
