//
//  HomeViewController.h
//  VandyRecCenter
//
//  Created by Brendan McNamara on 11/29/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NotificationDelegate.h"

@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NoticiationDelegate>

@property (nonatomic, strong) UITableView* tableView;
@end
