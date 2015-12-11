//
//  ForecastAnnotation.h
//  Weather
//
//  Created by Nikita on 04.12.15.
//  Copyright © 2015 Nikita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>


@interface ForecastAnnotation :  NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
