//
//  MapViewController.m
//  Weather
//
//  Created by Nikita on 04.12.15.
//  Copyright © 2015 Nikita. All rights reserved.
//

#import "MapViewController.h"
#import "ForecastAnnotation.h"
#import "UIView+MKAnnotationView.h"
#import "WeatherTableViewController.h"



@interface MapViewController () <MKMapViewDelegate>

@property (strong, nonatomic) CLGeocoder* geoCoder;
@property (assign, nonatomic) CLLocationCoordinate2D currentPinCoordinate;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self addPin];
    });

    self.geoCoder = [[CLGeocoder alloc] init];


}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Annotation

- (void) addPin{
    ForecastAnnotation* annotation = [[ForecastAnnotation alloc] init];
    annotation.title = @"Place";
    annotation.coordinate = self.mapView.region.center;
    [self.mapView addAnnotation:annotation];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString* identifier = @"Annotation";
    
    MKPinAnnotationView* pin = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!pin) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        pin.animatesDrop = YES;
        pin.canShowCallout = YES;
        pin.draggable = YES;
        
        UIButton* descriptionButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [descriptionButton addTarget:self action:@selector(actionDescription:) forControlEvents:UIControlEventTouchUpInside];
        pin.rightCalloutAccessoryView = descriptionButton;
        
    } else {
        pin.annotation = annotation;
    }
    
    return pin;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState {
    
    if (newState == MKAnnotationViewDragStateEnding) {
        CLLocationCoordinate2D location = view.annotation.coordinate;
        NSLog(@"\nlocation = {%f, %f}", location.latitude, location.longitude);
        self.currentPinCoordinate = location;
    }
    
}

- (void) showAlertWithTitle:(NSString*) title andMessage:(NSString*) message {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Description" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) actionDescription:(UIButton*) sender {
    
    MKAnnotationView* annotationView = [sender superAnnotationView];
    
    if (!annotationView) {
        return;
    }
    
    CLLocationCoordinate2D coordinate = annotationView.annotation.coordinate;
    
    CLLocation* location = [[CLLocation alloc] initWithLatitude:coordinate.latitude
                                                      longitude:coordinate.longitude];
    
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
    [self.geoCoder
     reverseGeocodeLocation:location
     completionHandler:^(NSArray *placemarks, NSError *error) {
         
         NSString* message = nil;
         if (error) {
             message = [error localizedDescription];
         } else {
             if ([placemarks count] > 0) {
                 MKPlacemark* placeMark = [placemarks firstObject];
                 message = [placeMark.addressDictionary description];
             } else {
                 message = @"No Placemarks Found";
             }
         }
         [self showAlertWithTitle:@"Location" andMessage:message];
     }];
    
}

- (IBAction)forecastButtonTapped:(UIButton *)sender {
    WeatherTableViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WeatherTableViewController"];
    vc.coordinate = self.currentPinCoordinate;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
