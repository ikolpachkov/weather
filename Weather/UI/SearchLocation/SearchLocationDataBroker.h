//
//  SearchLocationDataBroker.h
//  Weather
//
//  Created by Igor Kolpachkov on 18.10.15.
//  Copyright (c) 2015 com.ikolpachkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SearchLocationDataBrokerDelegate <NSObject>

- (void)onDataUpdated:(NSArray *)placemarks;

@end

@interface SearchLocationDataBroker : NSObject

@property (nonatomic, assign) id<SearchLocationDataBrokerDelegate> delegate;
@property (nonatomic, strong, readonly) NSMutableArray *lastRequestResult;

- (void)requestGeocodeAutocompletion:(NSString *)location;

@end
