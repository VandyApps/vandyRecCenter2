//
//  IMGame.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/29/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "IMGame.h"
#import "IMTeam.h"
#import "NSDate+DateHelper.h"

#import "TimeString.h"

@implementation IMGame

- (void) parse:(NSDictionary *)hash {
    _cid = hash[@"id"];
    _date = [NSDate dateWithDateString: hash[@"date"]];
    _startTime = [[TimeString alloc] initWithString: hash[@"startTime"]];
    _endTime = [[TimeString alloc] initWithString: hash[@"endTime"]];
    
    _homeTeam = [[IMTeam alloc] init];
    [_homeTeam parse: hash [@"homeTeam"]];
    
    _awayTeam = [[IMTeam alloc] init];
    [_awayTeam parse: hash[@"awayTeam"]];
    
    _homeScore = [hash[@"homeScore"] intValue];
    _awayScore = [hash[@"awayScore"] intValue];
    
    _status = [hash[@"status"] intValue];
    
    _location = hash[@"location"];
    
    
}

- (NSDictionary*) serialize {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject: self.cid forKey: @"id"];
#warning Missing date hash
    [dict setObject: [self.startTime stringValue] forKey: @"startTime"];
    [dict setObject: [self.endTime stringValue] forKey: @"endTime"];
    
    [dict setObject: @(self.homeScore) forKey: @"homeScore"];
    [dict setObject: @(self.awayScore) forKey: @"awayScore"];
    
    [dict setObject: @(self.status) forKey: @"status"];
    
    [dict setObject: self.location forKey: @"location"];
    
    //immutable copy
    return [dict copy];
}

@end
