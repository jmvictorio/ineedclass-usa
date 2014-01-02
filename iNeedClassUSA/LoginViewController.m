//
//  LoginViewController.m
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 14/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "LoginViewController.h"
#import "AccountViewController.h"
#import "MainViewController.h"
#import "SignInViewController.h"

@interface LoginViewController (){
    int bandera;
    NSString *id_user;
    NSString *user;
}

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@end

@implementation LoginViewController
@synthesize pass, email;

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
    user=@"0";
    
}
- (IBAction)login:(id)sender {
    request=[[RequestToJSON alloc]init];
    NSArray *res=[request leerConsultaMysql:11 texto1:self.email.text texto2:self.pass.text];
    if([res count]<1){
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"iNeedClass" message:@"Error Login" delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:@"Sign Up", nil];
        bandera=0;
        [mes show];
        
    }else{
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"iNeedClass" message:@"Login OK" delegate:self cancelButtonTitle:@"Main" otherButtonTitles:@"Account", nil];
        
        NSString *username=self.email.text;
        NSString *id_user1=[[res objectAtIndex:0] objectForKey:@"id_user"];
        id_user=id_user1;
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
        bandera=1;
        [mes show];
        
    }
}
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if(bandera==1){
        if (buttonIndex == 1)
        {
            AccountViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"account"];
            view.id_user=id_user;
            [self presentNatGeoViewController:view completion:nil];
            
            
        }else{
            MainViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"main"];
            view.id_user=id_user;
            [self presentNatGeoViewController:view completion:nil];
        }
    }else{
        if (buttonIndex == 1)
        {
            SignInViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"signup"];
            //view.id_user=id_user;
            [self presentNatGeoViewController:view completion:nil];
            
            
        }
    }
}

- (IBAction)cerrarTeclado:(id)sender {
    
    [email resignFirstResponder];
    [pass resignFirstResponder];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
