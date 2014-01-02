//
//  ChooseLanguageViewController.h
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 06/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractActionSheetPicker.h"
#import "RequestToJSON.h"
#import "Language.h"

@interface ChooseLanguageViewController : UIViewController<RNFrostedSidebarDelegate>{
    
    IBOutlet UILabel *nameLevel;
    IBOutlet UIButton *go;
    IBOutlet UILabel *nameCity;
    IBOutlet UILabel *nameLanguage;
    
    RequestToJSON *request;
}
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSMutableArray *languages;
@property (nonatomic, strong) NSMutableArray *idLevels;
@property (nonatomic, strong) NSArray *levels;
@property (nonatomic, strong) NSArray *idarrays;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) AbstractActionSheetPicker *actionSheetPicker;
- (IBAction)pressLanguage:(id)sender;
- (IBAction)pressLevel:(id)sender;
- (IBAction)menu:(id)sender;
- (IBAction)dismiss:(id)sender;
- (IBAction)follow:(id)sender;

@end
