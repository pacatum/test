//
//  ViewController.h
//  Weather
//
//  Created by Nikita on 02.12.15.
//  Copyright © 2015 Nikita. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


- (IBAction)searchTappedButton:(UIButton *)sender;
- (IBAction)mapButton:(UIButton *)sender;


@end

