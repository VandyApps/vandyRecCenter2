//
//  BMInfinitePagerImplDelegate.h
//  BMInfinitePager
//
//  Created by Brendan McNamara on 11/21/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BMInfinitePagerImpl;
@class BMIndexPath;

@protocol BMInfinitePagerImplDelegate <NSObject>

- (UIView*) impl: (BMInfinitePagerImpl*) impl needsPageForOffset: (BMIndexPath*) offset;
- (void) implDidPageLeft: (BMInfinitePagerImpl*) impl;
- (void) implDidPageRight: (BMInfinitePagerImpl*) impl;
- (void) implDidPageUp: (BMInfinitePagerImpl*) impl;
- (void) implDidPageDown: (BMInfinitePagerImpl*) impl;
- (void) impl: (BMInfinitePagerImpl*) impl didPageToOffset: (BMIndexPath*) offset;


@end
