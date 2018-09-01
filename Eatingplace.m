//
//  Eatingplace.m
//  WhereToEat
//
//  Created by Yu Xin on 4/16/17.
//  Email: yuxin@usc.edu
//  Copyright © 2017 Yu Xin. All rights reserved.
//

#import "Eatingplace.h"

@implementation Eatingplace

// Initializing the eatingplace
- (instancetype) initWithName:(NSString *)name address:(NSString *)addr
{
    self = [super init];
    
    if (self)
    {
        _name = name;
        _address = addr;
    }
    
    return self;
}

@end
