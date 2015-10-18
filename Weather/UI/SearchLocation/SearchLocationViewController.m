//
//  SearchLocationViewController.m
//  Weather
//
//  Created by Igor Kolpachkov on 18.10.15.
//  Copyright (c) 2015 com.ikolpachkov. All rights reserved.
//

#import "SearchLocationViewController.h"
#import "SearchLocationDataBroker.h"
#import "SearchLocationView.h"



NSString *locationTableViewCellReuseIdeitifier = @"locationTableViewCellReuseIdeitifier";

@interface SearchLocationViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, SearchLocationDataBrokerDelegate>

@property (nonatomic, strong) SearchLocationView *searchLocationView;
@property (nonatomic, strong) SearchLocationDataBroker *dataBroker;

@end

@implementation SearchLocationViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataBroker = [[SearchLocationDataBroker alloc] init];
        _dataBroker.delegate = self;
    }
    return self;
}

- (void)loadView
{
    _searchLocationView = [[UINib nibWithNibName:@"SearchLocationView" bundle:nil] instantiateWithOwner:self options:nil][0];
    self.view = _searchLocationView;
    
    [_searchLocationView.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:locationTableViewCellReuseIdeitifier];
    _searchLocationView.tableView.delegate = self;
    _searchLocationView.tableView.dataSource = self;
    
    [_searchLocationView.cancelButton addTarget:self action:@selector(onTapCancel) forControlEvents:UIControlEventTouchUpInside];
    
    [_searchLocationView.inputTextField addTarget:self action:@selector(onTextChanged:) forControlEvents:UIControlEventEditingChanged];
    _searchLocationView.inputTextField.delegate = self;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_searchLocationView.inputTextField resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _searchLocationView.cancelButton.enabled = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""])
    {
        _searchLocationView.cancelButton.enabled = NO;
    }
}

- (void)onTextChanged:(UITextField *)textField
{
    [_dataBroker requestGeocodeAutocompletion:textField.text];
}

- (void)onTapCancel
{
    _searchLocationView.inputTextField.text = @"";
    [_dataBroker requestGeocodeAutocompletion:@""];
    [_searchLocationView.inputTextField resignFirstResponder];
    _searchLocationView.cancelButton.enabled = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataBroker.lastRequestResult count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:locationTableViewCellReuseIdeitifier forIndexPath:indexPath];
    CLPlacemark *placemark = [_dataBroker.lastRequestResult objectAtIndex:indexPath.row];
    NSString *city = placemark.locality;
    NSString *countryCode = placemark.ISOcountryCode;
    NSString *location = [[city stringByAppendingString:@", "] stringByAppendingString:countryCode];
    [cell.textLabel setText:location];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CLPlacemark *placemark = [_dataBroker.lastRequestResult objectAtIndex:indexPath.row];
    [self.delegate locationHasBeenSelected:placemark];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onDataUpdated:(NSArray *)placemarks
{
    [_searchLocationView.tableView reloadData];
}

@end
