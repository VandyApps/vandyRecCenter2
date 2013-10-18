//
//  AppDelegate.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 10/3/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "AppDelegate.h"
#import "TimeString.h"
@implementation AppDelegate

@synthesize window = _window;
@synthesize centralViewController = _centralViewController;
@synthesize viewControllers = _viewControllers;
@synthesize panelViewController = _panelViewController;
@synthesize rightPanelViewController = _rightPanelViewController;
@synthesize leftPanelViewController = _leftPanelViewController;

#pragma mark - Getters
- (NSArray*) viewControllers {
    
    if (_viewControllers == nil) {
        UIStoryboard* mainSB = [UIStoryboard storyboardWithName: @"Main" bundle: [NSBundle mainBundle]];
        
        _viewControllers = @[[mainSB instantiateInitialViewController], [mainSB instantiateViewControllerWithIdentifier: @"hours"], [mainSB instantiateViewControllerWithIdentifier: @"traffic"], [mainSB instantiateViewControllerWithIdentifier: @"groupFitness"]];
    }
    return _viewControllers;
}

- (UINavigationController*) centralViewController {
    if (_centralViewController == nil) {
        _centralViewController = [[UINavigationController alloc] init];
        //_centralViewController.navigationBar.items = @[item];
    }
    return _centralViewController;
}

- (JASidePanelController*) panelViewController {
    if (_panelViewController == nil) {
        _panelViewController = [[JASidePanelController alloc] init];
        
    }
    return _panelViewController;
}

- (MainMenuViewController*) leftPanelViewController {
    if (_leftPanelViewController == nil) {
        UIStoryboard* mainSB = [UIStoryboard storyboardWithName: @"Main" bundle: [NSBundle mainBundle]];
        _leftPanelViewController = [mainSB instantiateViewControllerWithIdentifier: @"leftPanel"];
        _leftPanelViewController.delegate = self;
    }
    return _leftPanelViewController;
}

- (NotificationViewController*) rightPanelViewController {
    if (_rightPanelViewController == nil) {
        UIStoryboard* mainSB = [UIStoryboard storyboardWithName: @"Main" bundle: [NSBundle mainBundle]];
        _rightPanelViewController = [mainSB instantiateViewControllerWithIdentifier: @"rightPanel"];
    }
    return _rightPanelViewController;
}

#pragma mark - Lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[UINavigationBar appearance] setBarTintColor: vanderbiltGold];
    [[UINavigationBar appearance] setTintColor: [UIColor blackColor]];
    
    [self.centralViewController pushViewController: [self.viewControllers objectAtIndex: 0] animated: NO];
    
    
    [self.panelViewController setCenterPanel: self.centralViewController];
    [self.panelViewController setLeftPanel: self.leftPanelViewController];
    [self.panelViewController setRightPanel: self.rightPanelViewController];
    
    [self setUpViewControllers];
    
    self.window.rootViewController = self.panelViewController;
    
    return YES;
}

- (void) setUpViewControllers {
    for (size_t i =0; i < self.viewControllers.count; ++i) {
        UIViewController* controller = [self.viewControllers objectAtIndex: i];
        controller.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed: @"428-checkmark1.png"] style:UIBarButtonItemStylePlain target:self.panelViewController action:@selector(toggleRightPanel:)];
    }
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - MainMenu Delegate

- (void) didSelectedControllerWithTitle:(NSString *)title atIndex:(NSUInteger)index {
    
    //check for the same controller
    UIViewController* newController = [self.viewControllers objectAtIndex: index];
    if (newController != self.centralViewController.topViewController) {
        //pop the top of the navigation controller and push the new controller
        [self.centralViewController setViewControllers: @[newController]];
        newController.title = title;
    }
    [self.panelViewController showCenterPanelAnimated: YES];
}

@end
