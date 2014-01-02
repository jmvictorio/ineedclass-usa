//
//  AccountModifyViewController.h
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 24/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractActionSheetPicker.h"
#import "RequestToJSON.h"

@interface AccountModifyViewController : UIViewController<RNFrostedSidebarDelegate, UITextFieldDelegate>{
    int bandera;
}
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UILabel *genreLabel;

@property (nonatomic, strong) NSString *id_user;
@property (nonatomic, strong) NSArray *ages;
@property (nonatomic, strong) NSArray *genre;
@property (nonatomic, strong) NSArray *idarrays;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) AbstractActionSheetPicker *actionSheetPicker;
- (IBAction)pressAge:(id)sender;
- (IBAction)pressGenre:(id)sender;
- (IBAction)pressSave:(id)sender;
- (IBAction)dismiss:(id)sender;
- (IBAction)menu:(id)sender;

@end
