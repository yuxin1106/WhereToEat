//
//  AppDelegate.h
//  WhereToEat
//
//  Created by Yu Xin on 4/15/17.
//  Copyright © 2017 Yu Xin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLPClient;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(YLPClient *)sharedClient;

@end

