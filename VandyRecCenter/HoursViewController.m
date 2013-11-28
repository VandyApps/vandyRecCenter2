//
//  HoursViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamara on 11/14/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "HoursViewController.h"

@interface HoursViewController ()

@end

@implementation HoursViewController



#pragma mark- Initializer
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void) viewDidLayoutSubviews {
    [self setup];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Setup

//facade method used for setting up the view controller
- (void) setup {
    [self setupScrollView];
}

- (void) setupScrollView {
    
}


#pragma mark - Datasource



@end
