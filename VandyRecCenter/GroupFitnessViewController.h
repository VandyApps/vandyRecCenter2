//
//  GroupFitnessViewController.h
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/5/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GFTableViewController.h"
#import "GFCollection.h"
#import "MBProgressHUD.h"


@interface GroupFitnessViewController : UIViewController

@property (nonatomic, strong) GFCollection* collection;
@property (nonatomic, weak) IBOutlet UIButton* todayButton;
@end
