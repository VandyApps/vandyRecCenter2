//
//  HoursViewController.h
//  VandyRecCenter
//
//  Created by Brendan McNamara on 11/14/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMInfinitePagerDelegate.h"

@class BMInfinitePager;
@class BMArrowButton;

@interface HoursViewController : UIViewController <BMInfinitePagerDelegate>

@property (nonatomic, strong) BMInfinitePager* pager;

@property (nonatomic, strong) BMArrowButton* leftButton;
@property (nonatomic, strong) BMArrowButton* rightButton;

@property (nonatomic, strong) UIButton* todayButton;
@property (nonatomic, strong) UILabel* timeLabel;
@end
