//
//  MainViewController.h
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 13/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<RNFrostedSidebarDelegate>
@property (nonatomic, strong) NSString *id_user;
- (IBAction)menu:(id)sender;

@end
