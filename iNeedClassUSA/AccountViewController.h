//
//  AccountViewController.h
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 20/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface AccountViewController : UIViewController<RNFrostedSidebarDelegate, FBLoginViewDelegate>
@property (nonatomic, strong) NSString *id_user;
- (IBAction)dismiss:(id)sender;
- (IBAction)menu:(id)sender;
- (IBAction)exchanges:(id)sender;
- (IBAction)exit:(id)sender;
- (IBAction)account:(id)sender;
- (IBAction)teachers:(id)sender;
@end
