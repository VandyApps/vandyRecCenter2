//
//  IMTeam.h
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/29/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecModelProtocol.h"

@interface IMTeam : NSObject <RecModelProtocol>

@property (nonatomic, strong, readonly) NSString* cid;
@property (nonatomic, strong, readonly) NSString* name;
@property (nonatomic, readonly) NSUInteger wins;
@property (nonatomic, readonly) NSUInteger losses;
@property (nonatomic, readonly) NSUInteger ties;
@property (nonatomic, assign, getter = hasDropped) BOOL dropped;

@end
