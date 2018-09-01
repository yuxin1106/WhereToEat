//
//  MapViewController.h
//  WhereToEat
//
//  Created by Yu Xin on 4/18/17.
//  Email: yuxin@usc.edu
//  Copyright © 2017 Yu Xin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapViewController : UIViewController //<CLLocationManagerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *name;

@property (nonatomic) float destLat;
@property (nonatomic) float destLong;
@property (nonatomic) float srcLat;
@property (nonatomic) float srcLong;

@end
