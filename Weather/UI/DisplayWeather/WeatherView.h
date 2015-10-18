//
//  WeatherView.h
//  Weather
//
//  Created by Igor Kolpachkov on 18.10.15.
//  Copyright (c) 2015 com.ikolpachkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherView : UIView

@property (strong, nonatomic) IBOutlet UIScrollView *mainScroll;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;

@end
