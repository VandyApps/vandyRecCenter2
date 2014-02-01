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
#import "NSDate-MyDateClass.h"

@implementation IMLeague


- (IMTeam*) teamWithId:(NSString *)team {
    return nil;
}

- (IMGame*) gameWithId:(NSString *)game {
    return nil;
}


#pragma mark - Rec Model Protocol

- (void) parse:(NSDictionary*)hash {
    _cid = hash[@"id"];
    _name = hash[@"name"];
    _entryStartDate = [NSDate dateWithDateString: hash[@"entryStartDate"]];
    _entryEndDate = [NSDate dateWithDateString: hash[@"entryEndDate"]];
    _startDate = [NSDate dateWithDateString: hash[@"startDate"]];
    _endDate = [NSDate dateWithDateString: hash[@"endDate"]];
}

- (NSDictionary*) serialize {
    return nil;
}
@end
