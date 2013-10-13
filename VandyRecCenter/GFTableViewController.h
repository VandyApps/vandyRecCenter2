//
//  GFTableViewController.h
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/11/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


#define CELL_CLASSNAME_LABEL 1
#define CELL_INSTRUCTOR_LABEL 2
#define CELL_LOCATION_LABEL 3
#define CELL_TIMERANGE_LABEL 4
#define CELL_ADD_BUTTON 5

@interface GFTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray* GFClassesToDisplay;
@property (nonatomic, weak) IBOutlet UITableViewCell* cell;
@end
