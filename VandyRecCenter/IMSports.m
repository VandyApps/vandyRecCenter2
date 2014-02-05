//
//  IMSports.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 2/2/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "IMSports.h"
#import "IMSport.h"


@implementation IMSports

@synthesize sports = _sports;
@dynamic count;


- (NSUInteger) count {
    return self.sports.count;
}
#pragma mark - Rec Model Protocol

- (void) parse:(id)hash {
    if ([hash isKindOfClass: [NSArray class]]) {
        NSMutableArray* array = [[NSMutableArray alloc] init];
        for (NSDictionary* sportHash in hash) {
            IMSport* sport = [[IMSport alloc] init];
            [sport parse: sportHash];
            [array addObject: sportHash];
        }
        //immutable copy
        _sports = [array copy];
    }
}

- (id) serialize {
    return nil;
}

@end
