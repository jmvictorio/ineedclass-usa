//
//  CollectionViewController.h
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 08/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellCollection.h"
#import "RequestToJSON.h"

@interface CollectionViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, RNFrostedSidebarDelegate>{
    NSMutableArray *idpeople;
    NSMutableArray *names;
    NSMutableArray *experiences;
    NSMutableArray *people;
    
    NSString *user;
    
    NSString *citySpace;
    NSArray *paraPickerPeople;
    
    RequestToJSON *request;
}

@property (strong, nonatomic) IBOutlet UICollectionView *collection;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *levelTest;
@property (strong, nonatomic) NSString *id_exchange;
@property (strong, nonatomic) NSString *name_exchange;

- (IBAction)menu:(id)sender;
- (IBAction)dismiss:(id)sender;
@end
