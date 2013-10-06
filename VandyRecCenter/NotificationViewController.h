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

@interface NotificationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NoticiationDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MBProgressHUD* HUD;

@end
