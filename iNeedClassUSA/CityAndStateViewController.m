//
//  ChooseLocalViewController.m
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 04/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//


#import "CityAndStateViewController.h"
#import "AddLanguageViewController.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "AccountViewController.h"

@interface CityAndStateViewController (){
    RequestToJSON *webServices;
    NSString *city1;
    NSString *state1;
    NSString *user;
}

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@end

@implementation CityAndStateViewController
@synthesize picker,stateLabel, cityLabel, followButton;

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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    user = [defaults objectForKey:@"id_user"];
	// Do any additional setup after loading the view.
    [self setup];
    
    
}
- (void)setup{
    followButton.hidden=YES;
    states=[[NSMutableArray alloc]init];
    cities=[[NSMutableArray alloc]init];
    webServices=[[RequestToJSON alloc]init];
    identificadorStates=[[NSMutableArray alloc]init];
    identificadorCities=[[NSMutableArray alloc]init];
    paraPickerState=[[NSArray alloc]init];
    paraPickerCity=[[NSArray alloc]init];
    //activity=[[UIActivityIndicatorView alloc]init];
    [self initStatesAndCities];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadCities:(NSString *)state{
    [activity startAnimating];
    activity.hidden=NO;
    [cities removeAllObjects];
    [picker setUserInteractionEnabled:NO];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       //do something expensive
                       //NSLog(@"%@", state);
                       paraPickerCity=[webServices leerConsultaMysql:2 texto:state];
                       
                       for (int cont=0;cont<[paraPickerCity count];cont++) {
                           
                           NSString *prov=[[paraPickerCity objectAtIndex:cont] objectForKey:@"city"];
                           // NSLog(@"%@",prov);
                           
                           [cities addObject:prov];
                           
                       }
                       //dispatch back to the main (UI) thread to stop the activity indicator
                       dispatch_async(dispatch_get_main_queue(), ^
                                      {
                                          [activity stopAnimating];
                                          activity.hidden=YES;
                                          [picker reloadComponent:1];
                                          
                                          [picker setUserInteractionEnabled:YES];
                                      });
                   });
}

- (void)initStatesAndCities{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       //do something expensive
                       paraPickerState=[webServices leerConsultaMysql:1 texto:@""];
                       //int cont=0;
                       //NSLog(@"%@", paraPickerState);
                       for (int cont=0;cont<[paraPickerState count];cont++) {
                           
                           [identificadorStates addObject:[[paraPickerState objectAtIndex:cont] objectForKey:@"state_code"]];
                           
                           NSString *stateTemp=[[paraPickerState objectAtIndex:cont] objectForKey:@"state"];
                           
                           
                           
                           [states addObject:stateTemp];
                           
                       }
                       //dispatch back to the main (UI) thread to stop the activity indicator
                       dispatch_async(dispatch_get_main_queue(), ^
                                      {
                                          [activity stopAnimating];
                                          activity.hidden=YES;
                                          [picker reloadAllComponents];
                                          
                                          //[vistacarga setHidden:YES];
                                      });
                   });
    
}

//PICKER METODOS

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component==0){
        stateLabel.text=[[NSString alloc] initWithString:[identificadorStates objectAtIndex:row]];
        cityLabel.text=@"";
        state1=[[NSString alloc] initWithString:[identificadorStates objectAtIndex:row]];
        [self loadCities:[identificadorStates objectAtIndex:row]];
        //NSLog(@"%@", [identificadorStates objectAtIndex:row]);
    }
    else{
        cityLabel.text=[[NSString alloc] initWithString:[cities objectAtIndex:row]];
        city1=[[NSString alloc] initWithString:[cities objectAtIndex:row]];
        followButton.hidden=NO;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component==0){
        return [states count];
    }
    else{
        return [cities count];
        
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component==0){
        return [states objectAtIndex:row];
    }
    else{
        return [cities objectAtIndex:row];
    }
}


- (IBAction)follow:(id)sender {
    [((AddLanguageViewController *)self.presentingViewController) changeCityAndState:city1 state:state1];
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
@end