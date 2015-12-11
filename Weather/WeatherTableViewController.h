//
//  WeatherTableViewController.h
//  Weather
//
//  Created by Nikita on 03.12.15.
//  Copyright © 2015 Nikita. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKAnnotation.h>


@interface WeatherTableViewController : UITableViewController

@property (strong,nonatomic) NSString* cityName;
@property (assign,nonatomic) CLLocationCoordinate2D coordinate;

@end
