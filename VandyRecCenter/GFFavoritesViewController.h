//
//  GFFavoritesViewController.h
//  VandyRecCenter
//
//  Created by Brendan McNamra on 12/12/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFFavoritesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>


@property (nonatomic, weak) IBOutlet UIView* headerView;
@property (nonatomic, weak) IBOutlet UITableView* tableView;

-(IBAction) done:(id)sender;
@end
