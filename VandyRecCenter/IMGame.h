//
//  IMGame.h
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/29/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecModelProtocol.h"

@class IMTeam;
@class TimeString;

typedef  enum {

    IMTeamStatusHomeTeamWon = 0,
    IMTeamStatusAwayTeamWon = 1,
    IMTeamStatusHomeTeamForfeit = 2,
    IMTeamStatusAwayTeamForfeit = 3,
    IMTeamStatusGameCancelled = 4,
    IMTeamStatusGameNotPlayed = 5
    
} IMTeamStatus;
@interface IMGame : NSObject <RecModelProtocol>

@property (nonatomic, strong, readonly) NSString* cid;

@property (nonatomic, strong, readonly) NSDate* date;
@property (nonatomic, strong, readonly) TimeString* startTime;
@property (nonatomic, strong, readonly) TimeString* endTime;

@property (nonatomic, strong, readonly) IMTeam* homeTeam;
@property (nonatomic, strong, readonly) IMTeam* awayTeam;

@property (nonatomic, readonly) NSUInteger homeScore;
@property (nonatomic, readonly) NSUInteger awayScore;

@property (nonatomic, readonly) IMTeamStatus status;

@property (nonatomic, strong, readonly) NSString* location;

@end
