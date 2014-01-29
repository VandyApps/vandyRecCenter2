//
//  RecModelProtocol.h
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/29/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RecModelProtocol <NSObject>

- (void) parse: (NSDictionary*) hash;
- (NSDictionary*) serialize;

@end
