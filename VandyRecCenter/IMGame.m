//
//  IMGame.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/29/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "IMGame.h"
#import "NSDate+DateHelper.h"

#import "TimeString.h"

#import "IMTeam.h"
#import "IMTeams.h"

@implementation IMGame

@synthesize cid = _cid;
@synthesize date = _date;
@synthesize startTime = _startTime;
@synthesize endTime = _endTime;

@dynamic teamsResolved;


- (BOOL) teamsResolved {
    if ([self.homeTeam isKindOfClass: [IMTeam class]]) {
        return YES;
    }
    return NO;
}

- (void) resolveTeamsWithCollection:(IMTeams *)teams {
    if (![self teamsResolved]) {
        _homeTeam = [teams teamWithId: _homeTeam];
        _awayTeam = [teams teamWithId: _awayTeam];
    }
}


- (IMTeam*) resolvedHomeTeam {
    return (self.teamsResolved) ? _homeTeam : nil;
}

- (IMTeam*) resolvedAwayTeam {
    return (self.teamsResolved) ? _awayTeam : nil;
}
#pragma mark - Rec Model Protocol

- (void) parse:(NSDictionary *)hash {
    _cid = hash[@"id"];
    _date = [NSDate dateWithDateString: hash[@"date"]];
    _startTime = [[TimeString alloc] initWithString: hash[@"startTime"]];
    _endTime = [[TimeString alloc] initWithString: hash[@"endTime"]];
    
    //these should just be string for id's, not actual team models
    _homeTeam = hash[@"homeTeam"];
    _awayTeam = hash[@"awayTeam"];
    
    _homeScore = [hash[@"homeScore"] intValue];
    _awayScore = [hash[@"awayScore"] intValue];
    
    _status = [hash[@"status"] intValue];
    
    _location = hash[@"location"];
    
    
}

- (NSDictionary*) serialize {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    return nil;
}

@end
