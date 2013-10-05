//
//  NotificationViewController.h
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationCollection.h"
#import "MBProgressHUD.h"

@interface NotificationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NoticiationDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MBProgressHUD* HUD;

@end
