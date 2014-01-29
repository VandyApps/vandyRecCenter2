//
//  IMTeams.h
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/29/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecModelProtocol.h"

@interface IMTeams : NSObject <RecModelProtocol>

@property (nonatomic, readonly, strong) NSArray* teams;

@end
