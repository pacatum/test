//
//  ViewController.m
//  Weather
//
//  Created by Nikita on 02.12.15.
//  Copyright © 2015 Nikita. All rights reserved.
//

#import "ViewController.h"
#import "PlaceModel.h"
#import "MBProgressHUD.h"
#import <CoreLocation/CoreLocation.h>
#import "CityCell.h"
#import "WeatherTableViewController.h"
#import "MapViewController.h"



@interface ViewController () <WeatherDelegate, CLLocationManagerDelegate>

@property(strong,nonatomic)PlaceModel* model;
@property(strong,nonatomic)NSDictionary* jsonObject;
@property(strong,nonatomic)MBProgressHUD* hud;
@property(strong,nonatomic)CLLocationManager* locationManager;
@property(strong,nonatomic)NSArray* modelArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[PlaceModel alloc]init];
    self.model.delegate = self;
    self.hud = [[MBProgressHUD alloc]init];
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    [self activityIndicatore];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchTappedButton:(UIButton *)sender {
    [self.model getWeatherForCity:self.cityTextField.text];
    NSLog(@"%@",self.cityTextField.text);
    [self activityIndicatore];
}

- (IBAction)mapButton:(UIButton *)sender {
    MapViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - activityIndicatore

-(void)activityIndicatore{
    self.hud.labelText = @"Loading...";
    self.hud.dimBackground = true;
    [self.view addSubview:self.hud];
    [self.hud show:YES];
}
#pragma mark - weatherDelegate

-(void)weatherUpdate:(NSDictionary*) weatherJSON{
    [self.hud hide:YES];
    NSLog(@"%@", self.model.city);
    NSLog(@"%ld", (long)self.model.temp);
    NSLog(@"%@", self.model.currentTime);
    NSLog(@"%@", self.model.descr);
    self.modelArray = @[self.model];
    [self.tableView reloadData];
    
}
#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSLog(@"cant finde location, error%@", error.description);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"%@",manager.location);
    CLLocation* currentLocation = [locations lastObject];
    
    if (currentLocation.horizontalAccuracy > 0) {
        [manager stopUpdatingLocation];
        CLLocationCoordinate2D qeo = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
        [self.model getWeatherForCoordinate:qeo];
    }
    [manager stopUpdatingLocation];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CityCell* cell = [tableView dequeueReusableCellWithIdentifier:@"city"];
    cell.countryLabe.text = self.model.country;
    cell.cityLabel.text = self.model.city;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WeatherTableViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WeatherTableViewController"];
    vc.cityName = self.model.city;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void) showAlert {
    [self.hud hide:YES];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Description" message:@"No connection" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}



@end
