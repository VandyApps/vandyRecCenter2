//
//  IMSports.h
//  VandyRecCenter
//
//  Created by Brendan McNamra on 2/2/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecModelProtocol.h"



@interface IMSports : NSObject <RecModelProtocol>

@property (nonatomic, strong, readonly) NSArray* sports;

@end
