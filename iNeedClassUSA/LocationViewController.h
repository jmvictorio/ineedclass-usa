//
//  LocationViewController.h
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 01/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "RequestToJSON.h"

@interface LocationViewController : UIViewController<CLLocationManagerDelegate, RNFrostedSidebarDelegate>{
    CLLocationManager *locationManager;
    
    float longitud;
    float latitud;
    
    IBOutlet UILabel *cityChoose;
    IBOutlet UILabel *cityLocation;
    
    RequestToJSON *request;
}
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, retain) CLLocationManager *locationManager;
- (IBAction)detectLocation:(id)sender;
- (IBAction)menu:(id)sender;
- (IBAction)dismiss:(id)sender;

@end
