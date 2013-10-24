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

@interface GroupFitnessViewController : UIViewController

@property (nonatomic, strong) GFCollection* collection;

@property (nonatomic, strong) DSLCalendarView* calendar;
@end
