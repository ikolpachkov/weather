//
//  SearchLocationDataBroker.m
//  Weather
//
//  Created by Igor Kolpachkov on 18.10.15.
//  Copyright (c) 2015 com.ikolpachkov. All rights reserved.
//

#import "SearchLocationDataBroker.h"
#import <AddressBookUI/AddressBookUI.h>
#import <CoreLocation/CoreLocation.h>

@interface SearchLocationDataBroker()

@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation SearchLocationDataBroker

- (instancetype)init
{
    self = [super init];
    if (self) {
        _geocoder = [[CLGeocoder alloc] init];
        _lastRequestResult = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)requestGeocodeAutocompletion:(NSString *)location
{
    __block __weak typeof(self) weakSelf = self;
    [_geocoder geocodeAddressString:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error != nil)
        {
            NSLog(@"Geocode address failed with error: %@", error);
            //other error handling methods
            [weakSelf.lastRequestResult removeAllObjects];
            [weakSelf.delegate onDataUpdated:weakSelf.lastRequestResult];
        }
        else
        {
            //TODO: parse the result and create internal data structure
            [weakSelf.lastRequestResult removeAllObjects];
            for(CLPlacemark *placemark in placemarks)
            {
                if (placemark.locality != nil && placemark.ISOcountryCode != nil)
                    [weakSelf.lastRequestResult addObject:placemark];
            }
            [weakSelf.delegate onDataUpdated:weakSelf.lastRequestResult];
        }
    }];
}

@end
