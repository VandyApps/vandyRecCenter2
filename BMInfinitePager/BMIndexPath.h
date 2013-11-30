//
//  BMIndexPath.h
//  BMInfinitePager
//
//  Created by Brendan McNamara on 11/25/13.
//  Copyright (c) 2013 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMIndexPath : NSObject

@property (nonatomic) NSInteger row;
@property (nonatomic) NSInteger column;


+ (BMIndexPath*) indexPathWithRow: (NSInteger) row column: (NSInteger) column;
+ (BMIndexPath*) indexPathWithRow: (NSInteger) row;
+ (BMIndexPath*) indexPathWithColumn: (NSInteger) column;

- (id) init;
- (id) initWithRow: (NSInteger) row column: (NSInteger) column;
@end
