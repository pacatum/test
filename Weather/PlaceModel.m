//
//  PlaceModel.m
//  Weather
//
//  Created by Nikita on 03.12.15.
//  Copyright © 2015 Nikita. All rights reserved.
//

#import "PlaceModel.h"
#import "AFNetworking.h"

static NSString* urlString = @"http://api.openweathermap.org/data/2.5/weather";
static NSString* urlStringForWeek = @"http://api.openweathermap.org/data/2.5/forecast/daily";
static NSString* appid = @"1faf867387ba978874f546b16a53110d";

@implementation PlaceModel


-(void)getWeatherForCity:(NSString*) city{
    
    NSURL* url = [NSURL URLWithString:urlString];
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:url];
    NSDictionary* params = @{@"q": city, @"appid" : appid};
    [manager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        [self getInfoFromJson:responseObject];
        [self.delegate weatherUpdate:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.description);
        [self.delegate showAlert];
    }];

}
-(void)getInfoFromJson:(NSDictionary*) responseObject{
    NSDictionary* dict = responseObject;
    //get city name
    _city = dict[@"name"];
    //NSDictionary* main = dict[@"main"];
    //get temperature
    _temp = [self temperature:dict];
    NSArray* weather = dict[@"weather"];
    NSDictionary* weatherDict = weather[0];
    //get decription
    _descr = weatherDict[@"description"];
    //get current time
    _currentTime = [self time:[dict[@"dt"] integerValue]];
    //get image icon
    _icon = [self iconWithName:weatherDict[@"icon"]];
    //get country
    NSDictionary* sys = dict[@"sys"];
    _country = sys[@"country"];
}
-(void)getWeatherForCoordinate:(CLLocationCoordinate2D) qeo{
    
    NSURL* url = [NSURL URLWithString:urlString];
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:url];
    NSDictionary* params = @{@"lat": @(qeo.latitude), @"lon": @(qeo.longitude), @"appid" : appid};
    [manager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        [self getInfoFromJson:responseObject];
        [self.delegate weatherUpdate:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.description);
        [self.delegate showAlert];
    }];
}
-(void)getWeatherForWeekWithCoordinate:(CLLocationCoordinate2D) qeo{
    
    NSURL* url = [NSURL URLWithString:urlStringForWeek];
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:url];
    NSDictionary* params = @{@"lat": @(qeo.latitude), @"lon": @(qeo.longitude), @"appid" : appid, @"cnt" : @(16)};
    [manager GET:urlStringForWeek parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary* dict = responseObject;
        NSArray* list = dict[@"list"];
        [self.delegate weatherUpdateForWeek:list];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.description);
        [self.delegate showAlert];
    }];
    
}

-(void)getWeatherForWeekWithCity:(NSString*) city{
    
    NSURL* url = [NSURL URLWithString:urlStringForWeek];
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:url];
    NSDictionary* params = @{@"q": city, @"appid" : appid, @"cnt" : @(16)};
    [manager GET:urlStringForWeek parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary* dict = responseObject;
        NSArray* list = dict[@"list"];
        [self.delegate weatherUpdateForWeek:list];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.description);
        [self.delegate showAlert];
    }];
}

-(NSString*)time:(NSInteger) unixTime{
    
    NSDate* date = [[NSDate alloc]initWithTimeIntervalSince1970:unixTime];
    NSDateFormatter* formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = @"MMM dd";
    return [formater stringFromDate:date];
}

-(double)temperature:(NSDictionary*)weatherJSON{
    NSDictionary* main = weatherJSON[@"main"];
    double temp = [main[@"temp"] doubleValue];
    NSDictionary* sys = weatherJSON[@"sys"];
    if ([sys[@"country"] isEqualToString:@"US"]) {
        return round((temp - 273.15) * 1.8 + 32);
    }else{
        return round(temp - 273.15);
    }
}
-(UIImage*)iconWithName:(NSString*)stringIcon{
    NSString* imageName = [NSString stringWithFormat:@"%@.png",stringIcon];
    UIImage* icon = [UIImage imageNamed:imageName];
    return icon;
}

@end
