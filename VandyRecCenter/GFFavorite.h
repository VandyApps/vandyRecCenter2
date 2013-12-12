//
//  GFFavorite.h
//  VandyRecCenter
//
//  Created by Brendan McNamra on 12/12/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFFavorite : NSObject

@property (nonatomic, strong, readonly) NSString* identification;
@property (nonatomic, copy) NSDictionary* GFClass;

- (id) initWithGFClass: (NSDictionary*) GFClass;
- (BOOL) isEqualToGFClass: (NSDictionary*) GFClass;

- (NSComparisonResult) compare: (GFFavorite*) favorite;
@end
