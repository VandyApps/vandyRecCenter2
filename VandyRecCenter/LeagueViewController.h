//
//  LeagueViewController.h
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/23/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IMLeague;

@interface LeagueViewController : UIViewController

@property (nonatomic, weak) IBOutlet UISegmentedControl* segmentedControl;
@property (nonatomic, strong) IMLeague* league;

@end
