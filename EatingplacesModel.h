//
//  EatingplacesModel.h
//  WhereToEat
//
//  Created by Yu Xin on 4/16/17.
//  Email: yuxin@usc.edu
//  Copyright © 2017 Yu Xin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Eatingplace.h"

@interface EatingplacesModel : NSObject

// Public Properties
@property (readonly) NSUInteger currentIndex;

// Public Methods

// Creating the model
+(instancetype)sharedModel;

// Accessing the number of eatingplaces in model
-(NSUInteger)numberOfEatingplaces;

// Accessing an eatingplace
-(Eatingplace*)eatingplaceAtIndex:(NSUInteger)index;

// Inserting an eatingplace
-(void)insertWithName:(NSString*)name address:(NSString*)addr;
-(void)insertWithName:(NSString *)name address:(NSString *)addr atIndex:(NSUInteger)index;

// Removing an eatingplace
-(void)removeEatingplace;
-(void)removeEatingplaceAtIndex:(NSUInteger)index;

@end
