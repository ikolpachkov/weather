//
//  SearchLocationView.m
//  Weather
//
//  Created by Igor Kolpachkov on 18.10.15.
//  Copyright (c) 2015 com.ikolpachkov. All rights reserved.
//

#import "SearchLocationView.h"
#import <Chameleon.h>

@implementation SearchLocationView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _inputTextField.backgroundColor = [UIColor clearColor];
    _inputTextField.textColor = [UIColor whiteColor];
    _inputTextField.tintColor = [UIColor flatGreenColor];
    _inputTextField.textAlignment = NSTextAlignmentLeft;
    _inputTextField.borderStyle = UITextBorderStyleNone;
    
    [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[[UIColor alloc] initWithWhite:1.0 alpha:0.5] forState:UIControlStateDisabled];

    
    CGRect tableFrame = CGRectMake(0, 52, self.frame.size.width, self.frame.size.height);
    _tableView = [[UITableView alloc] initWithFrame:tableFrame];
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self addSubview:_tableView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _tableView.frame = CGRectMake(0, 52, self.frame.size.width, self.frame.size.height);
}

@end
