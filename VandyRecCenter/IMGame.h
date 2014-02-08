//
//  IMGame.h
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/29/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecModelProtocol.h"

@class IMTeams;
@class TimeString;

typedef  enum {

    IMGameStatusHomeTeamWon = 0,
    IMGameStatusAwayTeamWon = 1,
    IMGameStatusHomeTeamForfeit = 2,
    IMGameStatusAwayTeamForfeit = 3,
    IMGameStatusGameCancelled = 4,
    IMGameStatusGameNotPlayed = 5
    
} IMGameStatus;
@interface IMGame : NSObject <RecModelProtocol>

@property (nonatomic, strong, readonly) NSString* cid;

@property (nonatomic, strong, readonly) NSDate* date;
@property (nonatomic, strong, readonly) TimeString* startTime;
@property (nonatomic, strong, readonly) TimeString* endTime;

//this could either be a string for the teams or
//an actual imteam model, depending on whether
//the team was resolved
@property (nonatomic, strong, readonly) id homeTeam;
@property (nonatomic, strong, readonly) id awayTeam;

@property (nonatomic, readonly) NSUInteger homeScore;
@property (nonatomic, readonly) NSUInteger awayScore;

@property (nonatomic, readonly) IMGameStatus status;

@property (nonatomic, strong, readonly) NSString* location;

- (BOOL) teamsResolved;
- (void) resolveTeamsWithCollection: (IMTeams*) teams;

@end
