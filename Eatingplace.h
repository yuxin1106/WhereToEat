//
//  Eatingplace.h
//  WhereToEat
//
//  Created by Yu Xin on 4/16/17.
//  Email: yuxin@usc.edu
//  Copyright © 2017 Yu Xin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Eatingplace : NSObject

// Public Properties want other classes to access
@property (readonly) NSString* name;
@property (readonly) NSString* address;

// Initializing the eatingplace
- (instancetype) initWithName:(NSString *)name address:(NSString*) addr;

@end
