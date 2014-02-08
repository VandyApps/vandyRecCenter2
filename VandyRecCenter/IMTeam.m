//
//  IMTeam.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/29/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import "IMTeam.h"

@implementation IMTeam


- (void) parse:(NSDictionary *)hash {
    _cid = hash[@"id"];
    _name = hash[@"name"];
    _wins = [hash[@"wins"] intValue];
    _losses = [hash[@"losses"] intValue];
    _ties = [hash[@"ties"] intValue];
    _dropped = [hash[@"dropped"] boolValue];
    
}

- (NSDictionary*) serialize {
    return nil;
}

@end
