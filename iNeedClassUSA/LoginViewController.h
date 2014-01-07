//
//  LoginViewController.h
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 14/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "RequestToJSON.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate,RNFrostedSidebarDelegate, FBLoginViewDelegate>{
    RequestToJSON *request;
}

@property (strong, nonatomic) IBOutlet UIView *vistaFace;
@property (strong, nonatomic) IBOutlet UITextField *pass;
@property (strong, nonatomic) IBOutlet UITextField *email;
- (IBAction)login:(id)sender;
- (IBAction)cerrarTeclado:(id)sender;
- (IBAction)dismiss:(id)sender;
- (IBAction)menu:(id)sender;
@end
