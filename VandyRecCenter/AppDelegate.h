//
//  AppDelegate.h
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/3/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JASidePanelController.h"
#import "MainMenuViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, MainMenuDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) JASidePanelController* panelViewController;
@property (nonatomic, strong) UINavigationController* centralViewController;
@property (nonatomic, strong) MainMenuViewController* leftPanelViewController;

@property (nonatomic, strong) NSArray* viewControllers;

@end
