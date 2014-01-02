//
//  LanguageAccountViewController.h
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 20/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestToJSON.h"

@interface LanguageAccountViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, RNFrostedSidebarDelegate, UIActionSheetDelegate>{
    NSMutableArray *exchanges;
    RequestToJSON *request;
}
@property (strong, nonatomic) IBOutlet UIButton *addLanguage;
@property (strong, nonatomic) IBOutlet UICollectionView *collection;
- (IBAction)dismiss:(id)sender;
- (IBAction)menu:(id)sender;
@end
