//
//  RecModelProtocol.h
//  VandyRecCenter
//
//  Created by Brendan McNamra on 1/29/14.
//  Copyright (c) 2014 Brendan McNamara. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RecModelProtocol <NSObject>

//parse and serialize should deal with values that are property lists
// - NSNumber
// - NSString
// - NSDictionary
// - NSArray
// - NSDate
// - NSData

- (void) parse: (id) hash;
- (id) serialize;

@end
