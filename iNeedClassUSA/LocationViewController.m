//
//  LocationViewController.m
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 01/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "LocationViewController.h"
#import "ChooseLanguageViewController.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "AccountViewController.h"

@interface LocationViewController (){
    int bandera;
    NSString *user;
}

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@property (readonly) CLLocationCoordinate2D currentUserCoordinate;
@end

@implementation LocationViewController
@synthesize locationManager, city, state;
@synthesize currentUserCoordinate=_currentUserCoordinate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    bandera=0;
    request=[[RequestToJSON alloc]init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    user = [defaults objectForKey:@"id_user"];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)detectLocation:(id)sender {
    self.locationManager = [[CLLocationManager alloc] init];
    /*
     
     Los posibles valores para la precisión (desiredAccuracy) del GPS son:
     
     - kCLLocationAccuracyBestForNavigation:
     Pensado para la navegación por GPS ofrece la máxima precisión combinada con información de otros sensores. Está pensada para utilizarse con el dispotivio conectado por el alto consumo de batería.
     
     - kCLLocationAccuracyBest:
     Usa el mayor nivel de precisión posible.
     
     - kCLLocationAccuracyNearestTenMeters:
     Utiliza una precisión de 10 metros sobre la posición real.
     
     - kCLLocationAccuracyHundredMeters:
     Utiliza una precisión de 100 metros sobre la posición real.
     
     - kCLLocationAccuracyKilometer:
     Utiliza una precisión de 1 kilómetro sobre la posición real.
     
     - kCLLocationAccuracyThreeKilometers:
     Utiliza un precisión de 3 kilómetros sobre la posición real.
     
     Cuanto menos precisa es la localización, menos batería consumirá.
     
     */
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    
    if([CLLocationManager locationServicesEnabled]){
        self.locationManager.delegate = self;
        
        
        [self.locationManager startUpdatingLocation];
        
    }
    BOOL locationAvailable = self.locationManager.location!=nil;
    if(locationAvailable){
        latitud = self.locationManager.location.coordinate.latitude;
        longitud = self.locationManager.location.coordinate.longitude;
        //NSLog(@"%f,%f",latitud, longitud);
        CLLocation *location = [[CLLocation alloc] initWithLatitude:latitud longitude:longitud];
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            
            //NSLog(@"Received placemarks: %@", [placemarks objectAtIndex:0]);
            //[self displayPlacemarks:placemarks];
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            city = [placemark performSelector:NSSelectorFromString(@"subAdministrativeArea")];
            state=[placemark performSelector:NSSelectorFromString(@"administrativeArea")];
            NSString *address=[[NSString alloc]initWithFormat:@"%@, %@",city, state];
            cityLocation.text=address;
            NSString *citySpace=[city stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            NSArray *cuenta=[request leerConsultaMysql:5 texto1:citySpace texto2:state];
            
            
            if([[[cuenta objectAtIndex:0] objectForKey:@"count"] isEqualToString:@"0"]){
                UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"iNeedClass" message:[[NSString alloc]initWithFormat:@"There isn't exchanges now in %@",address] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done", nil];
                
                [mes show];
                bandera=1;
            }else{
                UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"iNeedClass" message:address delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done", nil];
                
                [mes show];
            }
            
            
            
        }];
        
        //NSLog(@"test1 %@",city);
        /*NSURL *url = [NSURL URLWithString:[[NSString alloc] initWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true", latitud, longitud]];
        //NSURL *url = [NSURL URLWithString:[[NSString alloc] initWithFormat:@"http://api.geonames.org/findNearbyJSON?lat=%f&lng=%f&style=FULL&username=jmvictorio", latitud, longitud]];
        
        
        NSString *jsonreturn= [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        //NSLog(@"%@",jsonreturn);
    
        NSData *jsonData=[jsonreturn dataUsingEncoding:NSUTF32BigEndianStringEncoding];
    
    
        NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:jsonData options:NSUTF32BigEndianStringEncoding error:nil];
        
        //GOOGLE MAPS 2500 request
        NSArray *requestGoogle=[[[dict objectForKey:@"results"] objectAtIndex:0] objectForKey:@"address_components"];
        NSString *sublocality=@"";
        NSString *citytest=@"";
        NSString *statetest=@"";
        for(NSDictionary *partes in requestGoogle){
            if([[[partes objectForKey:@"types"] objectAtIndex:0] isEqualToString:@"sublocality"]){
                sublocality=[[partes objectForKey:@"types"] objectAtIndex:0];
                citytest=[partes objectForKey:@"short_name"];
            }else if([[[partes objectForKey:@"types"] objectAtIndex:0] isEqualToString:@"locality"]){
                if([sublocality length]==0){
                    citytest=[partes objectForKey:@"long_name"];
                }
            }else if([[[partes objectForKey:@"types"] objectAtIndex:0] isEqualToString:@"administrative_area_level_1"]){
                statetest=[partes objectForKey:@"short_name"];
            }
            
        }*/
        
        
        
        //GEOCODE ??
        //NSString *citytest=[[[dict objectForKey:@"geonames"] objectAtIndex:0] objectForKey:@"adminName2"];
        //NSString *statetest=[[[dict objectForKey:@"geonames"] objectAtIndex:0] objectForKey:@"adminCode1"];
        
        //NSString *address=[[NSString alloc]initWithFormat:@"%@, %@",city, state];
        //cityLocation.text=address;
        //city=cityLocation.text;
        //state=statetest;
        //city=citytest;
        //NSLog(@"LOCATION %@")
        /*UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"iNeedClass" message:address delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done", nil];
        
        [mes show];*/
        
        
    }else{
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"iNeedClass"
                                                    message:@"LOCATION MISSED" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [mes show];
        
    }

}
- (IBAction)menu:(id)sender {
    NSArray *images = @[
                        [UIImage imageNamed:@"globe"],
                        [UIImage imageNamed:@"profile"]
                        //[UIImage imageNamed:@"star"],
                        //[UIImage imageNamed:@"gear"]
                        ];
    NSArray *colors = @[
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1]];
    //[UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
    //[UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1]];
    
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors];
    callout.delegate = self;
    [callout show];
}
#pragma mark - RNFrostedSidebarDelegate

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    //NSLog(@"Tapped item at index %lu",(unsigned long)index);
    if (index == 0) {
        MainViewController *view= [self.storyboard instantiateViewControllerWithIdentifier:@"main"];
        [self presentNatGeoViewController:view completion:nil];
    }
    if (index == 1) {
        if([user isEqualToString:@"0"]){
            LoginViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
            [self presentNatGeoViewController:view completion:nil];
            
        }else{
            AccountViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"account"];
            view.id_user=user;
            [self presentNatGeoViewController:view completion:nil];
        }
        
        
    }
    
    /*if (index == 2) {
     
     
     }
     if (index == 3) {
     
     }*/
    
    [sidebar dismiss];
}
- (IBAction)dismiss:(id)sender {
    [self dismissNatGeoViewControllerWithCompletion:^(BOOL finished) {
    }];
}
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if(bandera==0){
        if (buttonIndex == 1)
        {
            ChooseLanguageViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"chooseLanguageExchage"];
            view.state = state;
            view.city = city;
            [self presentNatGeoViewController:view completion:nil];

            
        }
    }
}

@end
