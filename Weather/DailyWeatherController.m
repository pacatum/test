//
//  DailyWeatherController.m
//  Weather
//
//  Created by Nikita on 03.12.15.
//  Copyright © 2015 Nikita. All rights reserved.
//

#import "DailyWeatherController.h"

@interface DailyWeatherController ()

@end

@implementation DailyWeatherController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary* temp = self.listArray[@"temp"];
    NSArray* weatherArray = self.listArray[@"weather"];
    NSDictionary* weatherDict = weatherArray[0];
    //set info
    self.windSpeedLabel.text = [NSString stringWithFormat:@"%0.1f m/s",[self.listArray[@"speed"] doubleValue]];
    self.cloudLabel.text = [NSString stringWithFormat:@"%ld%%",[self.listArray[@"clouds"] integerValue]];
    self.HumidityLabel.text = [NSString stringWithFormat:@"%ld%%",[self.listArray[@"humidity"] integerValue]];
    self.preassureLabel.text = [NSString stringWithFormat:@"%ld hPa",[self.listArray[@"pressure"] integerValue]];
    self.maxTemp.text = [NSString stringWithFormat:@"Max %ld°C",(long)[self temperature:[temp[@"max"] integerValue]]];
    self.minTemp.text = [NSString stringWithFormat:@"Min %ld°C",(long)[self temperature:[temp[@"min"] integerValue]]];
    self.temperature.text = [NSString stringWithFormat:@"%ld°C",(long)[self temperature:[temp[@"day"] integerValue]]];
    self.dayTemp.text = [NSString stringWithFormat:@"%ld°C",(long)[self temperature:[temp[@"day"] integerValue]]];
    self.morningTemp.text = [NSString stringWithFormat:@"%ld°C",(long)[self temperature:[temp[@"morn"] integerValue]]];
    self.eveningTemp.text = [NSString stringWithFormat:@"%ld°C",(long)[self temperature:[temp[@"eve"] integerValue]]];
    self.nightTemp.text = [NSString stringWithFormat:@"%ld°C",(long)[self temperature:[temp[@"night"] integerValue]]];
    self.weatherIcon.image = [self iconWithName:weatherDict[@"icon"]];
    self.dateLabel.text = [self time:[self.listArray[@"dt"] longLongValue]];
    [self iconForWind];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - converte values

-(void)iconForWind{
    double deg = [self.listArray[@"deg"] doubleValue];
    if (deg >= 315 && deg <= 45) {
        self.windIcon.image = [UIImage imageNamed:@"east.png"];
    }
    if (deg >= 225 && deg <= 315) {
        self.windIcon.image = [UIImage imageNamed:@"north.png"];
    }
    if (deg >= 135 && deg <= 225) {
        self.windIcon.image = [UIImage imageNamed:@"south.png"];
    }
    if (deg >= 45 && deg <= 135) {
        self.windIcon.image = [UIImage imageNamed:@"west.png"];
    }
    [self.windIcon clipsToBounds];
}
-(NSString*)time:(NSInteger) unixTime{
    
    NSDate* date = [[NSDate alloc]initWithTimeIntervalSince1970:unixTime];
    NSDateFormatter* formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = @"MMMM dd";
    return [formater stringFromDate:date];
}

-(NSInteger)temperature:(double)temp{
    return round(temp - 273.15);
}
-(UIImage*)iconWithName:(NSString*)stringIcon{
    NSString* imageName = [NSString stringWithFormat:@"%@.png",stringIcon];
    UIImage* icon = [UIImage imageNamed:imageName];
    return icon;
}


@end
