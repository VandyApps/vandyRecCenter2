//
//  BMInfinitePagerDelegate.h
//  BMInfinitePager
//
//  Created by Brendan McNamara on 11/17/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BMIndexPath;
@class BMInfinitePager;

@protocol BMInfinitePagerDelegate <NSObject>

- (UIView*) pager: (BMInfinitePager*) pager viewForOffset: (BMIndexPath*) offset;

@optional
- (void) pagerDidPageLeft: (BMInfinitePager*) pager;
- (void) pagerDidPageRight: (BMInfinitePager*) pager;
- (void) pagerDidPageUp: (BMInfinitePager*) pager;
- (void) pagerDidPageDown: (BMInfinitePager*) pager;
- (void) pager: (BMInfinitePager*) pager didPageToOffset: (BMIndexPath*) offset;

@end
