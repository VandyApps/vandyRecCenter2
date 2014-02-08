//
//  IMTeams.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/29/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "IMTeams.h"
#import "IMTeam.h"

@implementation IMTeams

- (NSUInteger) count {
    return _teams.count;
}

- (IMTeam*) at: (NSUInteger) index {
    return [self.teams objectAtIndex: index];
}

- (IMTeam*) teamWithId:(NSString *)id {
    for (IMTeam* team in self.teams) {
        if ([team.cid isEqualToString: id]) {
            return team;
        }
    }
    return nil;
}

#pragma mark - Rec Model Protocol

- (void) parse:(NSArray*)hash {
    NSMutableArray* teamsArray = [[NSMutableArray alloc] init];
    for (NSDictionary* teamHash in hash) {
        IMTeam* newTeam = [[IMTeam alloc] init];
        [newTeam parse: teamHash];
        [teamsArray addObject: newTeam];
    }
    //immutable copy
    _teams = [teamsArray copy];
    
}

- (NSArray*) serialize {
    return nil;
}



@end
