//
//  IMLeague.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 2/1/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "IMLeague.h"

#import "IMTeam.h"
#import "IMGame.h"
#import "IMTeams.h"
#import "IMGames.h"

#import "NSDate-MyDateClass.h"

@implementation IMLeague


- (IMTeam*) teamWithId:(NSString *)cid {
    return [self.teams teamWithId: cid];
}

- (IMGame*) gameWithId:(NSString *)cid {
    
    return [self.games gameWithId: cid];
}

- (void) resolveGames {
    [self.games resolveTeamsWithCollection: self.teams];
}

#pragma mark - Rec Model Protocol

- (void) parse:(NSDictionary*)hash {
    _cid = hash[@"id"];
    _name = hash[@"name"];
    _entryStartDate = [NSDate dateWithDateString: hash[@"entryStartDate"]];
    _entryEndDate = [NSDate dateWithDateString: hash[@"entryEndDate"]];
    _startDate = [NSDate dateWithDateString: hash[@"startDate"]];
    _endDate = [NSDate dateWithDateString: hash[@"endDate"]];
    
    _teams = [[IMTeams alloc] init];
    [_teams parse: hash[@"teams"]];
    
    _games = [[IMGames alloc] init];
    [_games parse: hash[@"games"]];
    [_games sort];
    

    
}

- (NSDictionary*) serialize {
    return nil;
}

@end
