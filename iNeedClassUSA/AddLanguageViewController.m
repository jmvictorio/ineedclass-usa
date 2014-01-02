//
//  AddLanguageViewController.m
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 21/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "AddLanguageViewController.h"
#import "LanguageAccountViewController.h"
#import "CityAndStateViewController.h"
#import "ObservationsViewController.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "AccountViewController.h"

@interface AddLanguageViewController (){
    UIPickerView *picker;
    NSArray *paraPickerLanguage;
    NSString *level;
    NSMutableArray *id_subjects;
    NSMutableArray *nameSubjects;
    NSString *user;
}

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@end

@implementation AddLanguageViewController
@synthesize sliderLevel,levelLabel, labelKnow, labelLearn, tipoLevel;

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
    
    NSLog(@"user: %@, id_exchange: %@, exchange1: %@, exchange2: %@",user, self.id_exchange, self.exchange1, self.exchange2);
	// Do any additional setup after loading the view.
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //user = [defaults objectForKey:@"id_user"];
    request=[[RequestToJSON alloc]init];
    //user=@"1";
    id_subjects=[[NSMutableArray alloc]init];
    nameSubjects=[[NSMutableArray alloc]init];
    
    NSArray *pre=[request leerConsultaMysql:15];

    for (int cont=0;cont<[pre count];cont++) {
        
        NSString *idTemp=[[pre objectAtIndex:cont] objectForKey:@"id_subject"];
        NSString *languageTemp=[[pre objectAtIndex:cont] objectForKey:@"name"];
        [id_subjects addObject:idTemp];
        [nameSubjects addObject:languageTemp];
    }
    if(self.view.frame.size.height == 568){
        picker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 210, 320, 162)];
    }else{
        picker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 175, 320, 162)];
    }

    
    [picker setMultipleTouchEnabled:NO];
    //[stateAndCity setBackgroundColor:[UIColor blackColor]];
    picker.delegate=self;
    
    [self.view addSubview:picker];
    
    if([self.insert isEqualToString:@"0"]){
        [self loadDatas];
    }else{
        [self addDatas];
    }
    
    //[sliderLevel addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
}
- (void)addDatas{
    self.labelLearn.text=@"English";
    self.labelKnow.text=@"English";
    self.labelCity.text=@"New York";
    self.labelState.text=@"NY";
    observation=@"No Comments";
    level=@"4";
    city1=self.labelCity.text;
    state1=self.labelState.text;
    self.exchange1=@"1";
    self.exchange1=@"1";
    
}
- (void)loadDatas{
    paraPickerLanguage=[request leerConsultaMysql:14 texto:self.id_exchange];
    
    level=[[paraPickerLanguage objectAtIndex:0] objectForKey:@"level"];
    sliderLevel.value=([level integerValue]);
    [self changeValue:level];
    observation=[[paraPickerLanguage objectAtIndex:0] objectForKey:@"observations"];
    city1=[[paraPickerLanguage objectAtIndex:0] objectForKey:@"city"];
    state1=[[paraPickerLanguage objectAtIndex:0] objectForKey:@"state_code"];
    self.labelCity.text=city1;
    self.labelState.text=state1;
    self.labelKnow.text=[nameSubjects objectAtIndex:[self.exchange2 integerValue]-1];
    self.labelLearn.text=[nameSubjects objectAtIndex:[self.exchange1 integerValue]-1];
    [picker selectRow:[self.exchange1 integerValue]-1 inComponent:0 animated:YES];
    [picker selectRow:[self.exchange2 integerValue]-1 inComponent:1 animated:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeValue:(id)sender {
    
    levelLabel.text=[[NSString alloc] initWithFormat:@"%d",[[[NSString alloc] initWithFormat:@"%f",sliderLevel.value] intValue]];
    level=levelLabel.text;
    //NSLog(@"%@",levelLabel.text);
    switch ([[[NSString alloc] initWithFormat:@"%f",sliderLevel.value] integerValue]) {
        case 1:
            tipoLevel.text=@"Beginer";
            break;
        case 2:
            tipoLevel.text=@"Elementary";
            break;
        case 3:
            tipoLevel.text=@"Pre-Intermediate";
            break;
        case 4:
            tipoLevel.text=@"Intermediate";
            break;
        case 5:
            tipoLevel.text=@"Pre-advanced";
            break;
        case 6:
            tipoLevel.text=@"Advance";
            break;
        default:
            break;
         
    }
    
}

- (IBAction)dismiss:(id)sender {
    [self dismissNatGeoViewControllerWithCompletion:^(BOOL finished) {
    }];
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


//PICKER METODOS

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component==0){
        labelLearn.text=[[NSString alloc] initWithString:[nameSubjects objectAtIndex:row]];
        self.exchange1=[id_subjects objectAtIndex:row];
        //NSLog(@"%@", [identificadorStates objectAtIndex:row]);
    }
    else{
        labelKnow.text=[[NSString alloc] initWithString:[nameSubjects objectAtIndex:row]];
        self.exchange2=[id_subjects objectAtIndex:row];
        
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [nameSubjects count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if(component==0){
        return [nameSubjects objectAtIndex:row];
        
    }
    else{
        return [nameSubjects objectAtIndex:row];
    }
}
- (IBAction)save:(id)sender{
    NSString *citySpace=[city1 stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSString *textSpace=[observation stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    if([self.insert isEqualToString:@"0"]){//UPDATE
        [request insert:102 array:@[self.id_exchange, self.exchange1, self.exchange2, level, citySpace, state1, textSpace]];
    }else{//INSERT
        [request insert:202 array:@[user, self.exchange1, self.exchange2, level, citySpace, state1, textSpace]];
    }
    LanguageAccountViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"exchangeMain"];
    //view.collection.reloadData;
    [self presentNatGeoViewController:view completion:nil];
}
- (void)changeCityAndState:(NSString *)city state:(NSString *)state{
    city1=city;
    state1=state;
    self.labelState.text=state1;
    self.labelCity.text=city1;
}
- (void)changeObservation:(NSString *)obser{
    observation=obser;
}

- (IBAction)chooseLocation:(id)sender {
    CityAndStateViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"locationChoose"];
    [view setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:view animated:YES completion:nil];
}


- (IBAction)openObservation:(id)sender {
    ObservationsViewController *view=[self.storyboard instantiateViewControllerWithIdentifier:@"observationChange"];
    [view setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:view animated:YES completion:nil];
}
@end
