//
//  AddLanguageViewController.h
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 21/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestToJSON.h"

@interface AddLanguageViewController : UIViewController<UIPickerViewDelegate, RNFrostedSidebarDelegate>{
    
    NSMutableArray *languages;
    
    NSArray *paraPicker;
    RequestToJSON *request;
    
    NSString *city1;
    NSString *state1;
    
    NSString *observation;
}

- (IBAction)openObservation:(id)sender;
@property (strong, nonatomic) IBOutlet NSString *insert;
@property (strong, nonatomic) IBOutlet NSString *id_exchange;
@property (strong, nonatomic) IBOutlet NSString *exchange1;
@property (strong, nonatomic) IBOutlet NSString *exchange2;
@property (strong, nonatomic) IBOutlet UILabel *labelLearn;
@property (strong, nonatomic) IBOutlet UILabel *labelKnow;
@property (strong, nonatomic) IBOutlet UILabel *tipoLevel;
@property (strong, nonatomic) IBOutlet UISlider *sliderLevel;
@property (strong, nonatomic) IBOutlet UILabel *labelCity;
@property (strong, nonatomic) IBOutlet UILabel *labelState;
@property (strong, nonatomic) IBOutlet UILabel *levelLabel;
- (IBAction)menu:(id)sender;
- (IBAction)changeValue:(id)sender;
- (IBAction)dismiss:(id)sender;
- (IBAction)save:(id)sender;
- (void)changeCityAndState:(NSString *)city state:(NSString *)state;
- (void)changeObservation:(NSString *)obser;
- (IBAction)chooseLocation:(id)sender;

@end
