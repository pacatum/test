//
//  WeatherCell.h
//  Weather
//
//  Created by Nikita on 03.12.15.
//  Copyright © 2015 Nikita. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *fullDecriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *shortDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;

@end
