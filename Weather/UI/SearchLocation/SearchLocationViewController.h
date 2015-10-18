//
//  SearchLocationViewController.h
//  Weather
//
//  Created by Igor Kolpachkov on 18.10.15.
//  Copyright (c) 2015 com.ikolpachkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol SearchLocationViewControllerDelegate <NSObject>

- (void)locationHasBeenSelected:(CLPlacemark *)pacemark;

@end

@interface SearchLocationViewController : UIViewController

@property (nonatomic, assign) id<SearchLocationViewControllerDelegate> delegate;

@end
