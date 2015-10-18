//
//  SearchLocationView.h
//  Weather
//
//  Created by Igor Kolpachkov on 18.10.15.
//  Copyright (c) 2015 com.ikolpachkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchLocationView : UIView

@property (strong, nonatomic) IBOutlet UIView *fadeView;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UITextField *inputTextField;

@property (strong, nonatomic) UITableView *tableView;

@end
