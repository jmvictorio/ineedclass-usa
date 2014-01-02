//
//  InfoPeopleViewController.h
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 11/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "RequestToJSON.h"

@interface InfoPeopleViewController : UIViewController<RNFrostedSidebarDelegate, MFMailComposeViewControllerDelegate>{
    RequestToJSON *request;
    NSArray *levels;
    NSString *user;
}

@property (strong, nonatomic) IBOutlet UIProgressView *levelProgress;
@property (strong, nonatomic) IBOutlet UILabel *levelLabel;
@property (strong, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *genreLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UITextView *observationsText;
@property (strong, nonatomic) IBOutlet UILabel *namePrincipal;
@property (strong, nonatomic) IBOutlet UIButton *callButton;
@property (strong, nonatomic) IBOutlet UILabel *ageLabelMuestra;
@property (strong, nonatomic) IBOutlet UILabel *genreLabelMuestra;

@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *idperson;
@property (nonatomic, strong) NSString *exchange1;
@property (nonatomic, strong) NSString *id_exchange;
- (IBAction)dismiss:(id)sender;
- (IBAction)menu:(id)sender;
- (IBAction)call:(id)sender;
- (IBAction)mail:(id)sender;
@end
