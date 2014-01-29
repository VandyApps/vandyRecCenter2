//
//  IntramuralSeasonViewController.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/24/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "SeasonViewController.h"

@interface SeasonViewController ()

@end

@implementation SeasonViewController

#pragma mark - Initializer

- (id) initWithContentSize: (CGSize) size {
    if (self = [super init]) {
        _size = size;
    }
    return self;
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, self.size.width, self.size.height);
}


@end
