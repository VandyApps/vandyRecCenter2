//
//  IntramuralPlayoffsViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/24/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "PlayoffsViewController.h"

@interface PlayoffsViewController ()

@end

@implementation PlayoffsViewController

#pragma mark - Initialization

- (id) initWithContentSize:(CGSize)size {
    if (self = [super init]) {
        _size = size;
    }
    
    return self;
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor redColor];
    
    self.view.frame = CGRectMake(0, 0, self.size.width, self.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
