//
//  IntramuralTeamsViewController.h
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/24/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView* teamView;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, readonly) CGSize size;

- (id) initWithContentSize: (CGSize) size;

@end
