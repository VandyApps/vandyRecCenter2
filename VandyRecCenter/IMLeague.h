//
//  IMLeague.h
//  VandyRecCenter
//
//  Created by Brendan McNamra on 2/1/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecModelProtocol.h"

@class  IMTeam;
@class  IMGame;
@class  IMTeams;
@class IMGames;

@interface IMLeague : NSObject <RecModelProtocol>

@property (nonatomic, strong, readonly) NSString* name;
@property (nonatomic, strong, readonly) NSString* cid;

@property (nonatomic, strong,readonly) NSDate* entryStartDate;
@property (nonatomic, strong, readonly) NSDate* entryEndDate;

@property (nonatomic, strong, readonly) NSDate* startDate;
@property (nonatomic, strong, readonly) NSDate* endDate;


@property (nonatomic, strong,readonly) IMTeams* teams;
@property (nonatomic, strong, readonly) IMGames* games;

- (IMTeam*) teamWithId: (NSString*) team;
- (IMGame*) gameWithId: (NSString*) game;

@end
