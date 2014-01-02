//
//  SignInViewController.h
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 14/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestToJSON.h"

@interface SignInViewController : UIViewController<UIScrollViewDelegate, UITextFieldDelegate, RNFrostedSidebarDelegate, UIPickerViewDelegate>{
    UIScrollView *scroll;
    UIView *vistaScroll;
    
    NSMutableArray *cities;
    NSMutableArray *identificadorCities;
    
    NSMutableArray *states;
    NSMutableArray *identificadorStates;
    
    NSArray *paraPickerState;
    NSArray *paraPickerCity;
    
    UIActivityIndicatorView *activity;
}
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;


@end
