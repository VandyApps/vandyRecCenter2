//
//  IMTeams.h
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/29/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecModelProtocol.h"

@class IMTeam;

@interface IMTeams : NSObject <RecModelProtocol>

@property (nonatomic, readonly, strong) NSArray* teams;
@property (nonatomic, readonly) NSUInteger count;

- (IMTeam*) at: (NSUInteger) index;

- (IMTeam*) teamWithId: (NSString*) id;

@end
