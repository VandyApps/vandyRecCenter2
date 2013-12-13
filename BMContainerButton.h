//
//  BMContainerButton.h
//  VandyRecCenter
//
//  Created by Brendan McNamra on 12/13/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMContainerButton : UIButton

//a dictionary object for storing whatever info you would like
//useful for responding to events
@property (nonatomic, strong) NSDictionary* info;

@end
