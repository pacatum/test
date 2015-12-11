//
//  WeatherTableViewController.m
//  Weather
//
//  Created by Nikita on 03.12.15.
//  Copyright © 2015 Nikita. All rights reserved.
//

#import "WeatherTableViewController.h"
#import "PlaceModel.h"
#import "WeatherCell.h"
#import "DailyWeatherController.h"



@interface WeatherTableViewController () <WeatherDelegate>

@property(strong,nonatomic)PlaceModel* model;
@property(strong,nonatomic)NSArray* listArray;

@end

@implementation WeatherTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[PlaceModel alloc]init];
    self.model.delegate = self;
    if (self.cityName == nil) {
        [self.model getWeatherForWeekWithCoordinate:self.coordinate];
    }else{
        [self.model getWeatherForWeekWithCity:self.cityName];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)weatherUpdate:(NSDictionary *)weatherJSON{
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeatherCell* cell = [tableView dequeueReusableCellWithIdentifier:@"weather"];
    NSDictionary* temp = self.listArray[indexPath.row];
    cell.fullDecriptionLabel.text = [self getFullDescription:temp];
    cell.shortDescriptionLabel.text = [self getShortDescription:temp];
    cell.weatherIcon.image = [self getIcon:temp];
    cell.dateLabel.text = [self getDate:temp];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
#pragma mark - UITableViewDelegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DailyWeatherController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DailyWeatherController"];
    vc.listArray = self.listArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}



#pragma mark - parsing listArray

-(NSString*)getFullDescription:(NSDictionary*) dict{
    NSArray* weather = dict[@"weather"];
    NSDictionary* weatherDict = weather[0];
    return weatherDict[@"description"];
}
-(NSString*)getShortDescription:(NSDictionary*) dict{
    NSArray* weather = dict[@"weather"];
    NSDictionary* weatherDict = weather[0];
    return weatherDict[@"main"];
}
-(UIImage*)getIcon:(NSDictionary*) dict{
    NSArray* weather = dict[@"weather"];
    NSDictionary* weatherDict = weather[0];
    return [self.model iconWithName:weatherDict[@"icon"]] ;
}
-(NSString*)getDate:(NSDictionary*) dict{
    return [self.model time:[dict[@"dt"] integerValue]];
}

#pragma mark - weatherDelegate

-(void)weatherUpdateForWeek:(NSArray *)list{
    self.listArray = [NSArray arrayWithArray:list];
    [self.tableView reloadData];
}
- (void) showAlert{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Description" message:@"No connection" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}



@end
