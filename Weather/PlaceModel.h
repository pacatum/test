//
//  PlaceModel.h
//  Weather
//
//  Created by Nikita on 03.12.15.
//  Copyright © 2015 Nikita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@protocol WeatherDelegate <NSObject>

-(void)showAlert;

@optional

-(void)weatherUpdate:(NSDictionary*) weatherJSON;
-(void)weatherUpdateForWeek:(NSArray *)list;

@end

@interface PlaceModel : NSObject

@property(strong,nonatomic) NSString* city;
@property(assign,nonatomic) NSInteger temp;
@property(strong,nonatomic) NSString* descr;
@property(strong,nonatomic) NSString* country;
@property(strong,nonatomic) NSString* currentTime;
@property(strong,nonatomic) UIImage* icon;
@property(strong,nonatomic) id <WeatherDelegate> delegate;


-(void)getWeatherForCity:(NSString*) city;
-(void)getWeatherForCoordinate:(CLLocationCoordinate2D) qeo;

-(void)getWeatherForWeekWithCity:(NSString*) city;
-(void)getWeatherForWeekWithCoordinate:(CLLocationCoordinate2D) qeo;

-(UIImage*)iconWithName:(NSString*)stringIcon;
-(NSString*)time:(NSInteger) unixTime;

@end
