//
//  MapViewController.m
//  checkins-uw-ios-hw6
//
//  Created by Parker, Carl (HBO) on 5/29/15.
//  Copyright (c) 2015 Parker, Carl (HBO). All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) MKLocalSearch *localSearch;
@property (strong, nonatomic) IBOutlet MKMapView *mkMapView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.delegate = self;
    
    self.mkMapView.delegate = self;
    self.searchBar.delegate = self;
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    //    [self.locationManager startUpdatingLocation];
    self.mkMapView.showsUserLocation = YES;
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    //
    // The ...10, 10... here is the "zoom level"
    //
    [mapView setRegion:MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 10, 10) animated:YES];
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        MKPinAnnotationView *greenPin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"GreenPin"];
        if (greenPin == nil) {
            greenPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"GreenPin" ];
            greenPin.pinColor = MKPinAnnotationColorGreen;
            greenPin.animatesDrop = YES;
            greenPin.canShowCallout = YES;
            
            UIButton *calloutButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            
            [calloutButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            
            greenPin.leftCalloutAccessoryView = calloutButton;
            return  greenPin;
        }
        else {
            greenPin.annotation = annotation;
            return greenPin;
        }
    }
    
    if ([annotation isKindOfClass:[MKPlacemark class]]) {
        MKPinAnnotationView *purplePin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"PurplePin"];
        if (purplePin == nil) {
            purplePin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"GreenPin" ];
            purplePin.pinColor = MKPinAnnotationColorPurple;
            purplePin.animatesDrop = YES;
            purplePin.canShowCallout = YES;
            
            UIButton *calloutButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            
            [calloutButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            
            purplePin.leftCalloutAccessoryView = calloutButton;
            return  purplePin;
        }
        else {
            purplePin.annotation = annotation;
            return purplePin;
        }
    }
    
    return nil;
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NSLog(@"%@", view.annotation.title);
    
    CheckinInfo *checkinInfo = [[CheckinInfo alloc] initWithLocation:view.annotation.title];
    
    [self.delegate mapViewController:self didGetCheckinInfo:checkinInfo];
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    NSLog(@"Location Authorization Status Changed");
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [self.locationManager startUpdatingLocation];
    
    NSLog(@"Location: %@", locations);
    
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc] init];
    searchRequest.region = self.mkMapView.region;
    searchRequest.naturalLanguageQuery = searchBar.text;
    
    if (self.localSearch.isSearching) {
        [self.localSearch cancel];
        self.localSearch = nil;
    }
    
    self.localSearch = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    
    [self.localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        for (id<MKAnnotation> annotation in self.mkMapView.annotations )  {
            [self.mkMapView removeAnnotation:annotation];
        }
        
        for (MKMapItem *mapItem in response.mapItems) {
            
            [self.mkMapView addAnnotation:mapItem.placemark];
            
        }
    }];
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
