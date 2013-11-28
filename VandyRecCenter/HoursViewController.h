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

@interface HoursViewController : UIViewController <BMInfinitePagerDelegate>


@property (nonatomic, weak) IBOutlet UIView* pagerWrapper;
@property (nonatomic, weak) IBOutlet UIView* contentView;

@property (nonatomic, strong) BMInfinitePager* pager;

@end
