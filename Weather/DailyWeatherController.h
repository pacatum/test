//
//  DailyWeatherController.h
//  Weather
//
//  Created by Nikita on 03.12.15.
//  Copyright © 2015 Nikita. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyWeatherController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UILabel *maxTemp;
@property (weak, nonatomic) IBOutlet UILabel *minTemp;
@property (weak, nonatomic) IBOutlet UILabel *eveningTemp;
@property (weak, nonatomic) IBOutlet UILabel *morningTemp;
@property (weak, nonatomic) IBOutlet UILabel *dayTemp;
@property (weak, nonatomic) IBOutlet UILabel *nightTemp;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UIImageView *windIcon;
@property (weak, nonatomic) IBOutlet UILabel *preassureLabel;
@property (weak, nonatomic) IBOutlet UILabel *HumidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *cloudLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property(strong,nonatomic)NSDictionary* listArray;

@end
