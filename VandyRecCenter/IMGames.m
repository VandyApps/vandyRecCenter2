//
//  IMGames.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/31/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "IMGames.h"
#import "IMGame.h"
#import "IMTeams.h"
#import "NSArray+MyArrayClass.h"
#import "TimeString.h"

@implementation IMGames

@synthesize games = _games;
@synthesize isTeamsResolved = _isTeamsResolved;

@dynamic count;


- (IMGame*) gameWithId:(NSString *)cid {
    for (IMGame* game in self.games) {
        if ([game.cid isEqualToString: cid]) {
            return game;
        }
    }
    return nil;
}


- (void) sort {
    _games = [_games sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        IMGame* game1 = obj1;
        IMGame* game2 = obj2;
        if ([game1.date compare: game2.date] == NSOrderedSame) {
            return [game1.startTime compareTimeString: game2.startTime];
        } else {
            return [game1.date compare: game2.date];
        }
    }];
}

- (NSArray*) newGames {
    return [self.games filter:^BOOL(id element, NSUInteger index) {
        return [(IMGame*) element status] == IMGameStatusGameNotPlayed;
    }];
}

- (NSArray*) oldGames {
    return [self.games filter:^BOOL(id element, NSUInteger index) {
        return [(IMGame*) element status] != IMGameStatusGameNotPlayed;
    }];
}

- (void) resolveTeamsWithCollection:(IMTeams *)teams {
    if (!_isTeamsResolved) {
        for (IMGame* game in self.games) {
            [game resolveTeamsWithCollection: teams];
        }
        _isTeamsResolved = YES;
    }
}

#pragma mark - Rec Model Protocol

- (void) parse:(NSArray*)hash {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    for (NSDictionary* gameHash in hash) {
        IMGame* game = [[IMGame alloc] init];
        [game parse: gameHash];
        [array addObject: game];
        
    }
    
    _games = [array copy];
}

- (NSArray*) serialize {
    return nil;
}

- (NSUInteger) count {
    return self.games.count;
}

@end


