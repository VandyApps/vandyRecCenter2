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


#pragma mark - Rec Model Protocol

- (void) parse:(id)plist {
    if ([plist isKindOfClass: [NSDictionary class]]) {
        _season = [plist[@"season"] intValue];
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
