//
//  MapViewController.m
//  WhereToEat
//
//  Created by Yu Xin on 4/18/17.
//  Email: yuxin@usc.edu
//  Copyright © 2017 Yu Xin. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "XYZMarker.h"

@interface MapViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    //self.navigationItem.title = self.name;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    self.locationManager.distanceFilter = 10.0f;
    self.locationManager.delegate = self;
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", _address);
    
   // MKUserLocation *userLocation = self.mapView.userLocation;
    
    //[self.mapView setRegion:region animated:NO];
    
    [self getLatLong:self.address];
    NSLog(@"coordinate = (%f,%f)", self.destLat, self.destLong);
    
    
    
   // if (self.destLat != 0 & self.destLong != 0)
    //{
        //CLLocationCoordinate2D sourceCoordinate = CLLocationCoordinate2DMake(self.srcLat, self.srcLong);
      //  CLLocationCoordinate2D sourceCoordinate = userLocation.coordinate;
      //  CLLocationCoordinate2D destCoordinate = CLLocationCoordinate2DMake(self.destLat, self.destLong);
       // [self getPathDirections:sourceCoordinate withDestination:destCoordinate];
    //}
   
    // not enough time for the geocoding to finish before the view is loaded
    // tries viewwillappear, gencode in tableview controller
    // so change to directions requested by the user
}

- (void)viewWillAppear:(BOOL)animated{
      
    //[self getLatLong:self.address];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", self.address);
    
    CLLocation *location = [locations lastObject];
    
    self.navigationItem.title = self.name;
    
    NSLog(@"Lat: %f, Lng: %f, Altitude: %f, Horizontal Accuracy %f, Vertical Accuracy %f", location.coordinate.latitude, location.coordinate.longitude, location.altitude, location.horizontalAccuracy, location.verticalAccuracy);
    
    XYZMarker *myLocation = [[XYZMarker alloc] init];
    myLocation.coordinate = location.coordinate;
    myLocation.title = @"Start Point";
    myLocation.subtitle = @"This is where we started!";
    
    self.srcLat = location.coordinate.latitude;
    self.srcLong = location.coordinate.longitude;
    
    [self.mapView addAnnotation:myLocation];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 10000, 10000);
  
    [self getLatLong:self.address];
    NSLog(@"coordinate = (%f,%f)", self.destLat, self.destLong);
    
    //if (self.destLat != 0 & self.destLong != 0)
    //{
    
   
       // CLLocationCoordinate2D destCoordinate = CLLocationCoordinate2DMake(self.destLat, self.destLong);
      //  [self getPathDirections:myLocation.coordinate withDestination:destCoordinate];
   // }
    
    [self.mapView setRegion:region animated:YES];
}

- (IBAction)directionsDidPressed:(UIButton *)sender {
    MKUserLocation *userLocation = self.mapView.userLocation;
    
    CLLocationCoordinate2D sourceCoordinate = userLocation.coordinate;
    CLLocationCoordinate2D destCoordinate = CLLocationCoordinate2DMake(self.destLat, self.destLong);
    [self getPathDirections:sourceCoordinate withDestination:destCoordinate];
    
}

- (void)getLatLong:(NSString *)address {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error){
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        CLLocation *location = placemark.location;
        CLLocationCoordinate2D coordinate = location.coordinate;
        
        self.destLat = coordinate.latitude;
        self.destLong = coordinate.longitude;
        //NSLog(@"coordinate = (%f,%f)", coordinate.latitude, coordinate.longitude);
        //NSLog(@"coordinate = (%f,%f)", self.destLat, self.destLong);
        
        XYZMarker *destLocation = [[XYZMarker alloc] init];
        destLocation.coordinate = coordinate;
        destLocation.title = @"End Point";
        destLocation.subtitle = self.name;
        
        [self.mapView addAnnotation:destLocation];
        MKCoordinateRegion destRegion = MKCoordinateRegionMakeWithDistance(coordinate, 10000, 10000);
        
        [self.mapView setRegion:destRegion animated:YES];
    }];
    
}

- (void)getPathDirections:(CLLocationCoordinate2D)source withDestination:(CLLocationCoordinate2D)destination {
    MKPlacemark *placemarkSrc = [[MKPlacemark alloc] initWithCoordinate:source addressDictionary:nil];
    MKMapItem *mapItemSrc = [[MKMapItem alloc] initWithPlacemark:placemarkSrc];
    MKPlacemark *placemarkDest = [[MKPlacemark alloc] initWithCoordinate:destination addressDictionary:nil];
    MKMapItem *mapItemDest = [[MKMapItem alloc] initWithPlacemark:placemarkDest];
   
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    [request setSource:mapItemSrc];
    [request setDestination:mapItemDest];
    [request setTransportType:MKDirectionsTransportTypeAutomobile];
    request.requestsAlternateRoutes = NO;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler: ^(MKDirectionsResponse *response, NSError *error){
        if (!error){
            /*for (MKRoute *route in [response routes]){
                [self.mapView addOverlay:[route polyline] level:MKOverlayLevelAboveRoads];
            }
            //[self showRoute:response];*/
            if (error)
            {
                
            }else{
                [self showRoute:response];
            }
        }
    }];
}

- (void)showRoute:(MKDirectionsResponse *)response {
    for (MKRoute *route in response.routes)
    {
        [self.mapView addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        
        for (MKRouteStep *step in route.steps)
        {
            NSLog(@"%@", step.instructions);
        }
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(nonnull id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]){
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay: overlay];
        [renderer setStrokeColor:[UIColor blueColor]];
        [renderer setLineWidth:5.0];
        return renderer;
    }
    return nil;
}

- (IBAction)cancelButtonDidPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%s", __FUNCTION__);
    
    [self.locationManager stopUpdatingLocation];
    NSLog(@"error%@",error);
   /* switch([error code])
    {
        case kCLErrorNetwork: // general, network-related error
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"please check your network connection or that you are not in airplane mode" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            
        }
            break;
        case kCLErrorDenied:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"user has denied to use current Location " delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
                    }
            break;
        default:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"unknown network error" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            
        }
            break;
    }*/


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
