//
//  NotificationViewController.h
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NotificationCollection.h"
#import "MBProgressHUD.h"

#define CELL_MESSAGE_CONTRAINER_TAG 5
#define CELL_CONTENTVIEW_TAG 1
#define CELL_HEADER_TAG 2
#define CELL_ICON_TAG 3
#define CELL_MESSAGE_TAG 4

#define CONTROL_CELL_CONTENTVIEW 1
#define CONTROL_CELL_NEWS_BUTTON 2
#define CONTROL_CELL_HOURS_BUTTON 3
#define CONTROL_CELL_GROUPFITNESS_BUTTON 5
#define CONTROL_CELL_INTRAMURALS_BUTTON 4

@interface NotificationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NoticiationDelegate>

//color mapping that corresponds a color to a notification type
#define COLOR_MAP_NEWS 0
#define COLOR_MAP_HOURS 1
#define COLOR_MAP_GROUP_FITNESS 2
#define COLOR_MAP_INTRAMURALS 3
@property (nonatomic, strong, readonly) NSArray* colorMap;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MBProgressHUD* HUD;


- (IBAction) toggleNews:(id)sender;
- (IBAction) toggleHours:(id)sender;
- (IBAction) toggleGroupFitness:(id)sender;
- (IBAction) toggleIntramurals:(id)sender;

@end
