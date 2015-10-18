//
//  ViewController.m
//  Weather
//
//  Created by Igor Kolpachkov on 18.10.15.
//  Copyright (c) 2015 com.ikolpachkov. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherView.h"
#import "SearchLocationViewController.h"

#import <CoreLocation/CoreLocation.h>
#import <INTULocationManager.h>

@interface WeatherViewController () <SearchLocationViewControllerDelegate>

@property (nonatomic, strong) WeatherView *weatherView;

@end

@implementation WeatherViewController

-(void)loadView
{
    [super loadView];
    _weatherView = [[UINib nibWithNibName:@"WeatherView" bundle:nil] instantiateWithOwner:self options:nil][0];
    self.view = _weatherView;
    
    [_weatherView.searchButton addTarget:self action:@selector(onTapSearch) forControlEvents:UIControlEventTouchUpInside];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)onTapSearch
{
    SearchLocationViewController *seachLocationVC = [[SearchLocationViewController alloc] init];
    seachLocationVC.delegate = self;
    [self.navigationController pushViewController:seachLocationVC animated:YES];
}

- (void)locationHasBeenSelected:(CLPlacemark *)pacemark
{
    [self displayWeatherForPlace:pacemark];
}

- (void)updateCurrentLocation
{
    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
    __block __weak typeof(self) weakSelf = self;
    [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyCity timeout:30.0 delayUntilAuthorized:YES block:
        ^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
            if (status == INTULocationStatusSuccess)
            {
                [weakSelf updateCurrentPlace:currentLocation];
            }
            else if (status == INTULocationStatusTimedOut) {
                //TODO: handle timeout error
            }
            else
            {
                //TODO: handle other errors
            }
    }];
}

- (void)updateCurrentPlace:(CLLocation*)location
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    __block __weak typeof(self) weakSelf = self;
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
    {
        if (error != nil)
        {
            NSLog(@"failed with error: %@", error);
        }
        else
        {
            CLPlacemark *currentPlacemark = [placemarks firstObject];
            [weakSelf displayCurrentLocationWeather:currentPlacemark];
        }
    }];
}

- (void)displayCurrentLocationWeather:(CLPlacemark *)placemark
{
    
}

- (void)displayWeatherForPlace:(CLPlacemark *)placemark
{
    
}

@end
