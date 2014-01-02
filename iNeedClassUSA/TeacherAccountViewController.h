//
//  TeacherAccountViewController.h
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 20/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherAccountViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, RNFrostedSidebarDelegate>
- (IBAction)dismiss:(id)sender;
- (IBAction)menu:(id)sender;

@property (strong, nonatomic) IBOutlet UICollectionView *collection;
@property (nonatomic, strong) NSArray *kindSubjects;
@property (nonatomic, strong) NSArray *subjects;
@property (nonatomic, strong) NSArray *idarrays;
@property (strong, nonatomic) IBOutlet UIPickerView *subjectsAndPrices;
@end
