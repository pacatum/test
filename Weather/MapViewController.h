//
//  MapViewController.h
//  Weather
//
//  Created by Nikita on 04.12.15.
//  Copyright © 2015 Nikita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *forecastButton;

- (IBAction)forecastButtonTapped:(UIButton *)sender;

@end
