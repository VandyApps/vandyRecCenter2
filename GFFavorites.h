//
//  GFFavorites.h
//  vandyRecCenter
//
//  Created by Brendan McNamara on 5/29/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimeString.h"

@interface GFFavorites : NSObject

//classes that are marked as favorites
@property (nonatomic, strong) NSArray* GFClasses;
//path at which data is loaded and removed
@property (nonatomic, strong, readonly) NSString* pathName;

- (void) load;
- (void) save;


+ (GFFavorites*) sharedInstance;

- (void) add: (NSDictionary*) GFClass;
- (void) remove: (NSDictionary*) GFClass;



//sorts the elements in the list of favorites
//the GFClasses are sorted so that those with earlier
//starting dates come first
//if two elements have the same starting date
//then they are sorted based on the times the classes start
- (void) sort;

- (BOOL) contains: (NSDictionary*) GFClass;

//array-like methods
- (NSDictionary*) GFClassForIndex: (NSUInteger) index;
- (NSUInteger) count;
@end
