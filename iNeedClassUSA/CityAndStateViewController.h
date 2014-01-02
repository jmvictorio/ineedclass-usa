//
//  CityAndStateViewController.h
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 30/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestToJSON.h"

@interface CityAndStateViewController : UIViewController<RNFrostedSidebarDelegate,UIPickerViewDelegate, UIPickerViewDataSource>
{
    
    NSMutableArray *cities;
    NSMutableArray *identificadorCities;
    
    NSMutableArray *states;
    NSMutableArray *identificadorStates;
    
    NSArray *paraPickerState;
    NSArray *paraPickerCity;
    
    IBOutlet UIActivityIndicatorView *activity;
}
- (IBAction)follow:(id)sender;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UIButton *followButton;

- (IBAction)dismiss:(id)sender;

@end