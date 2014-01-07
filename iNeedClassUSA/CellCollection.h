//
//  CellCollection.h
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 23/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface CellCollection : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *cityStateLabel;
@property (strong, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailsExchange;
@property (strong, nonatomic) IBOutlet UIProgressView *progressLevel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;
@end
