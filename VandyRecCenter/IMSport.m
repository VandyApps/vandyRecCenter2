//
//  IMSport.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 2/1/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "IMSport.h"
#import "IMLeague.h"

@implementation IMSport

@dynamic leaguesResolved;
@dynamic count;

#pragma mark - Getters

- (BOOL) leaguesResolved {
    return self.leagues != nil;
}

- (NSUInteger) count {
    return self.leagues.count;
}
#pragma mark - Public Methods

- (void) resolveLeague:(void (^)(IMSport *))block {
    if (!self.leaguesResolved) {
        #warning - call the api
    } else {
        block(self);
    }
}

#pragma mark - Rec Model Protocol

- (void) parse:(id)plist {
    if ([plist isKindOfClass: [NSDictionary class]]) {
        _cid = plist[@"cid"];
        _season = [plist[@"season"] intValue];
        _name = plist[@"name"];
        
        NSMutableArray* leagues = [[NSMutableArray alloc] init];
        for (NSDictionary* leagueData in (NSArray*) plist[@"leagues"]) {
            IMLeague* league = [[IMLeague alloc] init];
            [league parse: leagueData];
            [leagues addObject: league];
        }
        //immutable copy
        _leagues = [leagues copy];
    }
}

- (id) serialize {
    return nil;
}
@end
