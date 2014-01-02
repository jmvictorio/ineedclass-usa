//
//  ChooseLanguageViewController.m
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 06/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "ChooseLanguageViewController.h"
#import "ActionSheetStringPicker.h"
#import "LocationViewController.h"
#import "CollectionViewController.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "AccountViewController.h"

@interface ChooseLanguageViewController (){
    int bandera;
    
    NSString *user;
    
    NSMutableArray *idLevel;
    NSString *citySpace;
    NSMutableArray *names;
    NSString *name_exchange;
    NSString *id_exchange;
    NSString *levelTest;
}

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@end

@implementation ChooseLanguageViewController
@synthesize actionSheetPicker, languages, city, state, levels, idarrays;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)languageWasSelected:(NSNumber *)selectedInde element:(id)element {
    self.selectedIndex = [selectedInde intValue];
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    if(bandera==0){
        bandera=1;
        Language *lang=[self.languages objectAtIndex:self.selectedIndex];
        name_exchange=lang.name;
        id_exchange=lang.id_exchage;
        nameLanguage.text =lang.name;
        go.hidden=YES;
    }else{
        //NSLog(@"levelTest en Choose %lu", self.selectedIndex);
        NSString *nivel=[idLevel objectAtIndex:self.selectedIndex];
        levelTest=nivel;
        //NSLog(@"levelTest en Choose %@", levelTest);
        nameLevel.text =[self.levels objectAtIndex:[nivel intValue]-1];
        go.hidden=NO;
        bandera=0;
    }
    
}
- (void)actionPickerCancelled:(id)sender {
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    user = [defaults objectForKey:@"id_user"];
    go.hidden=YES;
    //self.languages = [NSArray arrayWithObjects:@"English", @"Spanish", @"French", @"Chinese", @"Japanese", @"Thailand", nil];
    self.levels = [NSArray arrayWithObjects:@"Beginner", @"Elementary", @"Pre-Intermediate", @"Intermediate", @"Pre-advanced", @"Advance",@"All Levels", nil];
    self.languages=[[NSMutableArray alloc] init];
    
    self.idLevels=[[NSMutableArray alloc] init];
    idLevel=[[NSMutableArray alloc] init];
    bandera=0;
    nameCity.text=[[NSString alloc]initWithFormat:@"%@, %@", city, state];
    request=[[RequestToJSON alloc]init];
    //city=@"New York";
    //state=@"NY";
    citySpace=[city stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSArray *paraPickerLanguages=[request leerConsultaMysql:6 texto1:citySpace texto2:state];
    
    for (int cont=0;cont<[paraPickerLanguages count];cont++) {
        
        NSString *prov=[[paraPickerLanguages objectAtIndex:cont] objectForKey:@"name"];
        NSString *prov2=[[paraPickerLanguages objectAtIndex:cont] objectForKey:@"id_subject"];
        //NSLog(@"%@",prov);
        Language *lang=[[Language alloc]init];
        lang.name=prov;
        lang.id_exchage=prov2;
        
        [self.languages addObject:lang];
        //NSLog(@"%@", prov);
        
    }

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressLanguage:(UIControl *)sender {
    names=[[NSMutableArray alloc]init];
    for(Language *n in languages){
        [names addObject:n.name];
    }
    //NSLog(@"%lu",languages.count);
    //NSLog(@"%lu",names.count);
    [ActionSheetStringPicker showPickerWithTitle:@"Select Language" rows:names initialSelection:self.selectedIndex target:self successAction:@selector(languageWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];

}
- (IBAction)pressLevel:(id)sender {
    if(bandera==0){
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"iNeedClass" message:@"Choose the Language" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [mes show];
    }else{
        //NSLog(@"%lu",self.selectedIndex);
        
        Language *lang=[languages objectAtIndex:(self.selectedIndex)];
        
        NSString *exchange=lang.id_exchage;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                       {
                           //do something expensive
                           //NSLog(@"%@", state);
                           NSArray *paraPickerLevel=[request leerConsultaMysql:7 texto1:exchange texto2:citySpace texto3:state];
                           [idLevel removeAllObjects];
                           [self.idLevels removeAllObjects];
                           for (int cont=0;cont<[paraPickerLevel count];cont++) {
                               
                               NSString *prov=[[paraPickerLevel objectAtIndex:cont] objectForKey:@"level"];
                               // NSLog(@"%@",prov);
                               [idLevel addObject:prov];
                               
                               [self.idLevels addObject:[levels objectAtIndex:[prov intValue]-1]];
                               
                           }
                           [idLevel addObject:@"7"];
                           [self.idLevels addObject:[levels objectAtIndex:6]];
                           //NSLog(@"%@", self.idLevels);
                           //NSLog(@"%@", idLevel);
                           //dispatch back to the main (UI) thread to stop the activity indicator
                           dispatch_async(dispatch_get_main_queue(), ^
                                          {
                                              /*[activity stopAnimating];
                                               activity.hidden=YES;
                                               [picker reloadComponent:1];
                                               
                                               [picker setUserInteractionEnabled:YES];*/
                                              self.selectedIndex=0;
                                              [ActionSheetStringPicker showPickerWithTitle:@"Select Level" rows:self.idLevels initialSelection:self.selectedIndex target:self successAction:@selector(languageWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
                                              
                                          });
                       });
        
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
- (IBAction)follow:(id)sender{
    CollectionViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"collection"];
    view.state = state;
    view.city = city;
    view.id_exchange = id_exchange;
    view.name_exchange = name_exchange;
    view.levelTest = levelTest;
    [self presentNatGeoViewController:view completion:nil];

}
@end
