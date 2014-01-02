//
//  AddSubjectViewController.h
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 22/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddSubjectViewController : UIViewController<RNFrostedSidebarDelegate, UITextFieldDelegate, UIPickerViewDelegate>{
    NSMutableArray *languages;
    
    NSArray *paraPicker;
}
@property (strong, nonatomic) IBOutlet UILabel *subjectLabel;
- (IBAction)menu:(id)sender;
- (IBAction)dismiss:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)cerrarTeclado:(id)sender;
@end
