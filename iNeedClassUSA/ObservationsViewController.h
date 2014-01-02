//
//  ObservationsViewController.h
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 30/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ObservationsViewController : UIViewController<RNFrostedSidebarDelegate>
@property (strong, nonatomic) IBOutlet UITextView *text;
- (IBAction)follow:(id)sender;
- (IBAction)dismiss:(id)sender;

@end
