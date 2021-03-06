//
//  IntramuralSeasonViewController.h
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/24/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IMGames;

@interface GamesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic,readonly) CGSize size;

- (id) initWithContentSize: (CGSize) size;

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) IMGames* gamesCollection;


@end
