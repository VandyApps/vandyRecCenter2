//
//  MainMenuViewController.h
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/4/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JASidePanelController.h"
#import "UIViewController+JASidePanel.h"
@protocol MainMenuDelegate <NSObject>

- (void) didSelectedControllerWithTitle: (NSString*) title atIndex: (NSUInteger) index;

@end

@interface MainMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong, readonly) NSArray* mainMenu;
@property (nonatomic, strong, readonly) NSArray* mainMenuIcons;
@property (nonatomic, weak) id<MainMenuDelegate> delegate;

@end
