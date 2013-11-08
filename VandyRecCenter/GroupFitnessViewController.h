//
//  GroupFitnessViewController.h
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/5/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GFCollection;
@class DSLCalendarView;
@class GFTableViewController;

@interface GroupFitnessViewController : UIViewController

@property (nonatomic, strong) GFCollection* collection;
@property (nonatomic, weak) IBOutlet DSLCalendarView* calendar;
@property (nonatomic, strong) GFTableViewController* modalView;

@property (nonatomic, strong) UIButton* todayButton;
@property (nonatomic, strong) UIButton* favoriteButton;
@end
