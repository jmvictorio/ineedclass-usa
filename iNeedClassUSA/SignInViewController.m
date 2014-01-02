//
//  SignInViewController.m
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 14/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "SignInViewController.h"
#import "AccountViewController.h"
#import "LoginViewController.h"
#import "MainViewController.h"

//define maxScroll=1.671;

@interface SignInViewController (){
    UITextField *firstName;
    UITextField *lastName;
    UITextField *email;
    UITextField *pass;
    UITextField *repass;
    NSString *user;
    
    UIPickerView *stateAndCity;
    UILabel *stateLabel;
    UILabel *cityLabel;
    
    UIButton *follow;
    
    RequestToJSON *webServices;
}

@end

@implementation SignInViewController
//@synthesize scroll, pickerAgeGenre, pickerExchange, pickerStateCity, pickerTeacher, pass, repass, firstName, LastName, email, vistaScroll;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setup];
    

    
}

- (void)setup{
    //Cabecera
    user=@"0";
    UIView *header;
    
    if(self.view.frame.size.height == 568){
       header =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
    }else{
        header =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
    }
    [self.view addSubview:header];
    
    //backgroundLabel iNeedClass
    UILabel *fondoINC;
    UILabel *signUpLabel;
    UIButton *back;
    if(self.view.frame.size.height == 568){
        fondoINC=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, 320, 63)];
        signUpLabel=[[UILabel alloc]initWithFrame:CGRectMake(66, 42, 189, 39)];
        back=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [back setFrame:CGRectMake(0, 42, 63, 40)];
    }else{
        fondoINC=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 63)];
        signUpLabel=[[UILabel alloc]initWithFrame:CGRectMake(66, 32, 189, 39)];
        back=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [back setFrame:CGRectMake(0, 32, 63, 40)];
    }
    
    [fondoINC setTextColor:[UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0]];
    [fondoINC setText:@"iNeedClass"];
    [fondoINC setTextAlignment:NSTextAlignmentCenter];
    [fondoINC setFont:[UIFont systemFontOfSize:63]];
    [fondoINC setAdjustsFontSizeToFitWidth:YES];
    [fondoINC setBackgroundColor:[UIColor whiteColor]];
    [header addSubview:fondoINC];
    
    //text Sign Up
    
    [signUpLabel setTextColor:[UIColor blackColor]];
    [signUpLabel setText:@"Sign Up"];
    [signUpLabel setTextAlignment:NSTextAlignmentCenter];
    [signUpLabel setFont:[UIFont systemFontOfSize:32]];
    [signUpLabel setAdjustsFontSizeToFitWidth:YES];
    [signUpLabel setBackgroundColor:[UIColor clearColor]];
    [header addSubview:signUpLabel];
    
    
    [back setTitle:@"<" forState:UIControlStateNormal];
    [[back titleLabel] setFont:[UIFont systemFontOfSize:23]];
    [back addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:back];
    
    //Parte principal, scroll
    UIView *main;
    if(self.view.frame.size.height == 568){
        main=[[UIView alloc]initWithFrame:CGRectMake(0, 100, 320, 450)];
    }else{
        main=[[UIView alloc]initWithFrame:CGRectMake(0, 80, 320, 400)];
    }
    [self.view addSubview:main];
    scroll = [[UIScrollView alloc] initWithFrame:
              CGRectMake(0,0,self.view.bounds.size.width,
                         self.view.bounds.size.height)];
    [main addSubview:scroll];
    
    UIView *iv = [[UIView alloc] initWithFrame:
                  CGRectMake(0,0,self.view.bounds.size.width,
                             800)];
    
    
    UILabel *header1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 270, 45)];
    header1.text=@"First Name            Last Name";
    [header1 setFont:[UIFont systemFontOfSize:16]];
    header1.backgroundColor=[UIColor colorWithRed:50.0/255.0 green:79.0/255.0 blue:133.0/255.0 alpha:1.0];
    header1.textColor=[UIColor whiteColor];
    header1.textAlignment=NSTextAlignmentCenter;
    
    firstName = [[UITextField alloc]initWithFrame:CGRectMake(20, 60, 100, 25)];
    firstName.autocapitalizationType = UITextAutocapitalizationTypeWords;
    firstName.borderStyle = UITextBorderStyleLine;
    firstName.placeholder = @"First Name";
    firstName.font = [UIFont systemFontOfSize:13];
    firstName.keyboardType = UIKeyboardTypeDefault;
    firstName.clearButtonMode = UITextFieldViewModeWhileEditing;
    firstName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    firstName.delegate = self;
    [firstName setReturnKeyType:UIReturnKeyDone];
    [firstName addTarget:self action:@selector(cerrarTeclado:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    lastName = [[UITextField alloc]initWithFrame:CGRectMake(150, 60, 120, 25)];
    lastName.autocapitalizationType = UITextAutocapitalizationTypeWords;
    lastName.borderStyle = UITextBorderStyleLine;
    lastName.placeholder = @"Last Name";
    lastName.font = [UIFont systemFontOfSize:13];
    lastName.keyboardType = UIKeyboardTypeDefault;
    lastName.clearButtonMode = UITextFieldViewModeWhileEditing;
    lastName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    lastName.delegate = self;
    [lastName setReturnKeyType:UIReturnKeyDone];
    [lastName addTarget:self action:@selector(cerrarTeclado:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    UILabel *header2=[[UILabel alloc]initWithFrame:CGRectMake(50, 100, 270, 45)];
    header2.text=@"                Email";
    [header2 setFont:[UIFont systemFontOfSize:16]];
    header2.backgroundColor=[UIColor colorWithRed:50.0/255.0 green:79.0/255.0 blue:133.0/255.0 alpha:1.0];
    header2.textColor=[UIColor whiteColor];
    header2.textAlignment=NSTextAlignmentLeft;
    
    email = [[UITextField alloc]initWithFrame:CGRectMake(50, 160, 200, 25)];
    email.autocapitalizationType = UITextAutocapitalizationTypeWords;
    email.borderStyle = UITextBorderStyleLine;
    email.placeholder = @"Email";
    email.font = [UIFont systemFontOfSize:13];
    email.keyboardType = UIKeyboardTypeEmailAddress;
    email.clearButtonMode = UITextFieldViewModeWhileEditing;
    email.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    email.delegate = self;
    [email setReturnKeyType:UIReturnKeyDone];
    [email addTarget:self action:@selector(cerrarTeclado:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    UILabel *header3=[[UILabel alloc]initWithFrame:CGRectMake(50, 200, 270, 45)];
    header3.text=@"                Password";
    [header3 setFont:[UIFont systemFontOfSize:16]];
    header3.backgroundColor=[UIColor colorWithRed:50.0/255.0 green:79.0/255.0 blue:133.0/255.0 alpha:1.0];
    header3.textColor=[UIColor whiteColor];
    header3.textAlignment=NSTextAlignmentLeft;
    
    pass = [[UITextField alloc]initWithFrame:CGRectMake(50, 260, 200, 25)];
    pass.autocapitalizationType = UITextAutocapitalizationTypeWords;
    pass.borderStyle = UITextBorderStyleLine;
    pass.placeholder = @"Password";
    pass.font = [UIFont systemFontOfSize:13];
    pass.keyboardType = UIKeyboardTypeDefault;
    pass.clearButtonMode = UITextFieldViewModeWhileEditing;
    pass.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    pass.delegate = self;
    [pass setSecureTextEntry:YES];
    [pass setReturnKeyType:UIReturnKeyDone];
    [pass addTarget:self action:@selector(cerrarTeclado:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    repass = [[UITextField alloc]initWithFrame:CGRectMake(50, 300, 200, 25)];
    repass.autocapitalizationType = UITextAutocapitalizationTypeWords;
    repass.borderStyle = UITextBorderStyleLine;
    repass.placeholder = @"Password Again";
    repass.font = [UIFont systemFontOfSize:13];
    repass.keyboardType = UIKeyboardTypeDefault;
    repass.clearButtonMode = UITextFieldViewModeWhileEditing;
    repass.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    repass.delegate = self;
    [repass setSecureTextEntry:YES];
    [repass setReturnKeyType:UIReturnKeyDone];
    [repass addTarget:self action:@selector(cerrarTeclado:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    UILabel *header4=[[UILabel alloc]initWithFrame:CGRectMake(0, 340, 270, 45)];
    header4.text=@"     State                         City";
    [header4 setFont:[UIFont systemFontOfSize:16]];
    header4.backgroundColor=[UIColor colorWithRed:50.0/255.0 green:79.0/255.0 blue:133.0/255.0 alpha:1.0];
    header4.textColor=[UIColor whiteColor];
    header4.textAlignment=NSTextAlignmentCenter;
    
    stateLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 390, 150, 45)];
    [stateLabel setFont:[UIFont systemFontOfSize:13]];
    stateLabel.textColor=[UIColor blackColor];
    stateLabel.textAlignment=NSTextAlignmentCenter;
    
    cityLabel=[[UILabel alloc]initWithFrame:CGRectMake(150, 390, 150, 45)];
    [cityLabel setFont:[UIFont systemFontOfSize:13]];
    cityLabel.textColor=[UIColor blackColor];
    cityLabel.textAlignment=NSTextAlignmentCenter;
    
    stateAndCity=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 425, 320, 162)];
    [stateAndCity setMultipleTouchEnabled:NO];
    //[stateAndCity setBackgroundColor:[UIColor blackColor]];
    stateAndCity.delegate=self;
    activity=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activity setFrame:CGRectMake(65, 400, 200, 200)];
    
    states=[[NSMutableArray alloc]init];
    cities=[[NSMutableArray alloc]init];
    webServices=[[RequestToJSON alloc]init];
    identificadorStates=[[NSMutableArray alloc]init];
    identificadorCities=[[NSMutableArray alloc]init];
    paraPickerState=[[NSArray alloc]init];
    paraPickerCity=[[NSArray alloc]init];
    [self initStatesAndCities];
    
    [iv setBackgroundColor:[UIColor whiteColor]];
    [iv addSubview:header1];
    [iv addSubview:firstName];
    [iv addSubview:lastName];
    [iv addSubview:header2];
    [iv addSubview:email];
    [iv addSubview:header3];
    [iv addSubview:pass];
    [iv addSubview:repass];
    [iv addSubview:header4];
    [iv addSubview:stateLabel];
    [iv addSubview:cityLabel];
    [iv addSubview:stateAndCity];
    [iv addSubview:activity];
    
    [scroll addSubview:iv];
    [scroll setContentSize:CGSizeMake(iv.bounds.size.width, iv.bounds.size.height)];
    [scroll setShowsHorizontalScrollIndicator:NO];
    [scroll setBounces:YES];
    [scroll setDelegate:self];
    
    //FOOTER
    UIView *footer;
    if(self.view.frame.size.height == 568){
        footer=[[UIView alloc]initWithFrame:CGRectMake(0, 524, 320, 44)];
    }else{
        footer=[[UIView alloc]initWithFrame:CGRectMake(0, 436, 320, 44)];
    }
    
    [self.view addSubview:footer];
    [footer setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *menuButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [menuButton setFrame:CGRectMake(0, 0, 64, 44)];
    [menuButton setTitle:@"+" forState:UIControlStateNormal];
    [[menuButton titleLabel] setFont:[UIFont systemFontOfSize:23]];
    [menuButton addTarget:self action:@selector(menu:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:menuButton];
    
    follow=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [follow setFrame:CGRectMake(100, 5, 100, 40)];
    [follow setTitle:@"Alright!" forState:UIControlStateNormal];
    [follow setHidden:YES];
    [[follow titleLabel] setFont:[UIFont systemFontOfSize:20]];
    [follow addTarget:self action:@selector(verify:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:follow];
    
    UILabel *logo=[[UILabel alloc]initWithFrame:CGRectMake(271, 25, 49, 21)];
    [logo setTextColor:[UIColor blackColor]];
    [logo setText:@".idapp"];
    [logo setTextAlignment:NSTextAlignmentCenter];
    [logo setFont:[UIFont systemFontOfSize:17]];
    [logo setAdjustsFontSizeToFitWidth:YES];
    [logo setBackgroundColor:[UIColor clearColor]];
    [footer addSubview:logo];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cerrarTeclado:(id)sender {
}

- (IBAction)dismiss:(id)sender {
    [self dismissNatGeoViewControllerWithCompletion:^(BOOL finished) {
    }];
}

- (IBAction)verify:(id)sender{
    int bandera=0;
    UIAlertView* mes;
    if([pass.text isEqualToString:repass.text]){
        
        
    }else{
        bandera=1;
        mes=[[UIAlertView alloc] initWithTitle:@"iNeedClass"
                                       message:@"Password does not match" delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles: nil];
    }
    if(pass.text.length < 4){
        bandera=1;
        mes=[[UIAlertView alloc] initWithTitle:@"iNeedClass"
                                       message:@"Password can't be less 4 characters" delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles: nil];
    }
    if(email.text.length < 6){
        bandera=1;
        mes=[[UIAlertView alloc] initWithTitle:@"iNeedClass"
                                       message:@"Email isn't correct" delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles: nil];
    }
    if(lastName.text.length==0){
        bandera=1;
        mes=[[UIAlertView alloc] initWithTitle:@"iNeedClass"
                                       message:@"LastName can't be empty" delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles: nil];
    }
    if(firstName.text.length==0){
        bandera=1;
        mes=[[UIAlertView alloc] initWithTitle:@"iNeedClass"
                                       message:@"First name can't be empty" delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles: nil];
    }
    
    if(bandera==1){
        
        [mes show];

    }
    if(bandera==0){
        [self addUser];
    }
}
- (void)addUser{
    
    NSArray *array=[webServices leerConsultaMysql:17 texto:email.text];
    if([[[array objectAtIndex:0] objectForKey:@"count"] isEqualToString:@"0"]){
        
            NSString *param1=email.text;
            NSString *param2=pass.text;
            NSArray *array3=@[param1, param2];
            [webServices insert:201 array:array3];
            NSArray *array2=[webServices leerConsultaMysql:16 texto1:email.text texto2:pass.text];
            NSString *id_login=[[array2 objectAtIndex:0] objectForKey:@"id_login"];
            NSLog(@"%@", id_login);
            NSArray *array4=@[id_login, firstName.text, lastName.text, @"0",@"0",@"0",cityLabel.text, stateLabel.text];
            [webServices insert:203 array:array4];
            [self save];
            [self send];
        
    }else{
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"iNeedClass"
                                                    message:@"Email Used" delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles: nil];
        
        [mes show];
    }

}
- (void)save
{
    // Create strings and integer to store the text info
    NSArray *res=[webServices leerConsultaMysql:11 texto1:email.text texto2:pass.text];
    NSString *username=email.text;
    NSString *id_user1=[[res objectAtIndex:0] objectForKey:@"id_user"];
    user=id_user1;
    NSString *name=[[res objectAtIndex:0] objectForKey:@"name"];
    NSString *lastname=[[res objectAtIndex:0] objectForKey:@"lastname"];
    NSString *city=[[res objectAtIndex:0] objectForKey:@"city"];
    NSString *state=[[res objectAtIndex:0] objectForKey:@"state_code"];
    // Store the data
    NSUserDefaults *login = [NSUserDefaults standardUserDefaults];
    [login setObject:username forKey:@"mail"];
    [login setObject:id_user1 forKey:@"id_user"];
    [login setObject:name forKey:@"name"];
    [login setObject:lastname forKey:@"lastname"];
    [login setObject:state forKey:@"state_code"];
    [login setObject:city forKey:@"city"];
    [login synchronize];

}
- (void)send{
    
    AccountViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"account"];
    [self presentNatGeoViewController:view completion:nil];
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
        stateLabel.text=[[NSString alloc] initWithString:[states objectAtIndex:row]];
        cityLabel.text=@"";
        [self loadCities:[identificadorStates objectAtIndex:row]];
        //NSLog(@"%@", [identificadorStates objectAtIndex:row]);
    }
    else{
        cityLabel.text=[[NSString alloc] initWithString:[cities objectAtIndex:row]];
        [follow setHidden:NO];
        
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


- (void)loadCities:(NSString *)state{
    [activity startAnimating];
    activity.hidden=NO;
    [cities removeAllObjects];
    [stateAndCity setUserInteractionEnabled:NO];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       //do something expensive
                       paraPickerCity=[webServices leerConsultaMysql:2 texto:state];
                       
                       for (int cont=0;cont<[paraPickerCity count];cont++) {
                           [identificadorCities addObject:state];
                           
                           NSString *prov=[[paraPickerCity objectAtIndex:cont] objectForKey:@"city"];
                           // NSLog(@"%@",prov);
                           
                           [cities addObject:prov];
                           
                       }
                       //dispatch back to the main (UI) thread to stop the activity indicator
                       dispatch_async(dispatch_get_main_queue(), ^
                                      {
                                          
                                          [activity stopAnimating];
                                          activity.hidden=YES;
                                          
                                          [stateAndCity reloadComponent:1];
                                          
                                          [stateAndCity setUserInteractionEnabled:YES];
                                      });
                   });
}

- (void)initStatesAndCities{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       //do something expensive
                       paraPickerState=[webServices leerConsultaMysql:1 texto:@""];
                       //int cont=0;
                       for (int cont=0;cont<[paraPickerState count];cont++) {
                           
                           [identificadorStates addObject:[[paraPickerState objectAtIndex:cont] objectForKey:@"state_code"]];
                           
                           NSString *prov=[[paraPickerState objectAtIndex:cont] objectForKey:@"state"];
                           
                           
                           [states addObject:prov];
                           
                       }
                       //dispatch back to the main (UI) thread to stop the activity indicator
                       dispatch_async(dispatch_get_main_queue(), ^
                                      {
                                          [activity stopAnimating];
                                          activity.hidden=YES;
                                          [stateAndCity reloadAllComponents];
                                      });
                   });
    
}
@end
