//
//  IntramuralsViewController.h
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/23/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMSports.h"

@interface IntramuralsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong, readonly) IMSports* sportsCollection;

@end
