//
//  GFFavorite.m
//  VandyRecCenter
//
//  Created by Brendan McNamra on 12/12/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import "GFFavorite.h"

@implementation GFFavorite

- (id) initWithGFClass: (NSDictionary*) GFClass {
    self = [super init];
    if (self) {
        self.GFClass = GFClass;
    }
    return self;
}

- (BOOL) isEqualToGFClass: (NSDictionary*) GFClass {
    NSLog(@"%@", [GFClass objectForKey: @"_id"]);
    return [[self.GFClass objectForKey: @"_id"] isEqualToString: [GFClass objectForKey: @"_id"]];
}

- (NSComparisonResult) compare: (GFFavorite*) favorite {
    return NSOrderedSame;
}
@end
