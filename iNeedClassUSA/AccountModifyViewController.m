//
//  AccountModifyViewController.m
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 24/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "AccountModifyViewController.h"
#import "ActionSheetStringPicker.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "AccountViewController.h"

@interface AccountModifyViewController (){
    UITextField *pass;
    UITextField *tel;
    NSArray *datas;
    NSString *genreName;
    RequestToJSON *request;
    NSString *id_login;
    NSString *user;
}
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

@end

@implementation AccountModifyViewController
@synthesize ages=_ages;
@synthesize genre=_genre;
@synthesize nameLabel, lastNameLabel, emailLabel, ageLabel, genreLabel;

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
    request=[[RequestToJSON alloc]init];
    datas=[request leerConsultaMysql:10 texto:user];
    //NSLog(@"%@", [[datas objectAtIndex:0] objectForKey:@"name"]);
    nameLabel.text=[[datas objectAtIndex:0] objectForKey:@"name"];
    id_login=[[datas objectAtIndex:0] objectForKey:@"id_login"];
    lastNameLabel.text=[[datas objectAtIndex:0] objectForKey:@"lastname"];
    emailLabel.text=[[datas objectAtIndex:0] objectForKey:@"email"];
    ageLabel.text=[[datas objectAtIndex:0] objectForKey:@"age"];
    if([[[datas objectAtIndex:0] objectForKey:@"genre"] isEqualToString:@"1"]){
        genreName=@"Male";
    }else{
        genreName=@"Female";
    }
    genreLabel.text=genreName;
    
    
    
    pass = [[UITextField alloc]initWithFrame:CGRectMake(100, 203, 170, 25)];
    pass.autocapitalizationType = UITextAutocapitalizationTypeWords;
    pass.borderStyle = UITextBorderStyleLine;
    pass.placeholder = @"Pass";
    pass.font = [UIFont systemFontOfSize:13];
    pass.keyboardType = UIKeyboardTypeDefault;
    pass.clearButtonMode = UITextFieldViewModeWhileEditing;
    pass.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    pass.delegate = self;
    [pass setReturnKeyType:UIReturnKeyDone];
    [pass addTarget:self action:@selector(cerrarTeclado:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:pass];
    [pass setText:[[datas objectAtIndex:0] objectForKey:@"pass"]];
    
    tel = [[UITextField alloc]initWithFrame:CGRectMake(100, 344, 170, 25)];
    tel.autocapitalizationType = UITextAutocapitalizationTypeWords;
    tel.borderStyle = UITextBorderStyleLine;
    tel.placeholder = @"(999) 999 9999";
    tel.font = [UIFont systemFontOfSize:13];
    tel.keyboardType = UIKeyboardTypeNamePhonePad;
    tel.clearButtonMode = UITextFieldViewModeWhileEditing;
    tel.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    tel.delegate = self;
    [tel setReturnKeyType:UIReturnKeyDone];
    [tel addTarget:self action:@selector(cerrarTeclado:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:tel];
    [tel setText:[[datas objectAtIndex:0] objectForKey:@"tel"]];

    _ages=@[@"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"38", @"39", @"40", @"41", @"42", @"43", @"44", @"45", @"46", @"47", @"48", @"49", @"50", @"51", @"52", @"53", @"54", @"55", @"56", @"57", @"58", @"59", @"60", @"61", @"62", @"63", @"64", @"65", @"66", @"67", @"68", @"69", @"70", @"71", @"72", @"73", @"74", @"75", @"76", @"77", @"78", @"79", @"80"];
    _genre=@[@"Male", @"Female"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (void)languageWasSelected:(NSNumber *)selectedInde element:(id)element {
    self.selectedIndex = [selectedInde intValue];
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    if(bandera==0){
        bandera=1;
        self.ageLabel.text = [self.ages objectAtIndex:self.selectedIndex];
    }else{
        if(self.selectedIndex>1){
            
        }else{
            self.genreLabel.text = [self.genre objectAtIndex:self.selectedIndex];
            bandera=0;
        }
    }
    
}
- (IBAction)cerrarTeclado:(id)sender {
}
- (void)actionPickerCancelled:(id)sender {
}
- (IBAction)pressAge:(UIControl *)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"Select Age" rows:self.ages initialSelection:self.selectedIndex target:self successAction:@selector(languageWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
    bandera=0;
    
}

- (IBAction)pressGenre:(id)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"Select Genre" rows:self.genre initialSelection:self.selectedIndex target:self successAction:@selector(languageWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
    bandera=1;
}
- (IBAction)pressSave:(id)sender {
    NSString *gen;
    if([genreLabel.text isEqualToString:@"Male"]){
        gen=@"1";
    }else{
        gen=@"2";
    }
    [request insert:101 array:@[id_login, pass.text, tel.text, ageLabel.text, gen]];
    //[self dismissNatGeoViewControllerWithCompletion:^(BOOL finished) {}];
    
}

@end
