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
    NSMutableArray *datasFace;
    
    FBProfilePictureView *profilePictureView;
    UILabel *nameLabel;
    UILabel *statusLabel;

}

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@end

@implementation LoginViewController
@synthesize pass, email, vistaFace;

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
    [vistaFace setHidden:YES];
    FBLoginView *loginView=[[FBLoginView alloc] initWithReadPermissions:@[@"basic_info", @"email"]];
    if(self.view.frame.size.height == 568){
       loginView.frame=CGRectMake(37, 310, 285, 51);
    }else{
        loginView.frame=CGRectMake(37, 255, 285, 51);
    }
    
    loginView.delegate=self;
    [self.view addSubview:loginView];
    request=[[RequestToJSON alloc]init];
    profilePictureView=[[FBProfilePictureView alloc]initWithFrame:CGRectMake(25,25, 90, 90)];
    UIImageView *circulo=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"circuloFace200.png"]];
    [circulo setFrame:CGRectMake(20, 20, 100, 100)];
    statusLabel=[[UILabel alloc]initWithFrame:CGRectMake(130, 31, 181, 26)];
    nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(130, 80, 181, 26)];
    
    [vistaFace addSubview:profilePictureView];
    [vistaFace addSubview:circulo];
    [vistaFace addSubview:nameLabel];
    [vistaFace addSubview:statusLabel];
    
    
    
}
//methods facebook!!

// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)userFacebook {
    profilePictureView.profileID = userFacebook.id;
    nameLabel.text = userFacebook.name;
    datasFace = [[NSMutableArray alloc]init];
    NSDate *now = [[NSDate alloc] init];
    
    NSArray *tokensArr = [[userFacebook objectForKey:@"birthday"] componentsSeparatedByString: @"/"];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:[[tokensArr objectAtIndex:2]integerValue]];
    [comps setMonth:[[tokensArr objectAtIndex:0]integerValue]];
    [comps setDay:[[tokensArr objectAtIndex:1]integerValue]];
    
    NSDate *tmpDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    NSTimeInterval secondsBetween = [now timeIntervalSinceDate:tmpDate];
    
    int numberOfYears = (secondsBetween / 86400)/365;

    
    [datasFace addObject:userFacebook.id];
    [datasFace addObject:[userFacebook objectForKey:@"email"]];
    [datasFace addObject:[userFacebook objectForKey:@"first_name"]];
    [datasFace addObject:[userFacebook objectForKey:@"last_name"]];
    [datasFace addObject:[[NSString alloc]initWithFormat:@"%d",numberOfYears]];
    [datasFace addObject:[userFacebook objectForKey:@"gender"]];
    [self addUser];
    
}

// Implement the loginViewShowingLoggedInUser: delegate method to modify your app's UI for a logged-in user experience
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    statusLabel.text = @"You're logged in as";
    [vistaFace setHidden:NO];
    
}

// Implement the loginViewShowingLoggedOutUser: delegate method to modify your app's UI for a logged-out user experience
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    profilePictureView.profileID = nil;
    nameLabel.text = @"";
    statusLabel.text= @"You're not logged in!";
    [vistaFace setHidden:YES];
}

// You need to override loginView:handleError in order to handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures since that happen outside of the app.
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}
- (void)addUser{
    
    NSArray *array=[request leerConsultaMysql:17 texto:[datasFace objectAtIndex:1]];
    if([[[array objectAtIndex:0] objectForKey:@"count"] isEqualToString:@"0"]){
       
        [request insert:205 array:@[[datasFace objectAtIndex:1]]];
        NSArray *array2=[request leerConsultaMysql:19 texto:[datasFace objectAtIndex:1]];
        NSString *id_login=[[array2 objectAtIndex:0] objectForKey:@"id_login"];
        [datasFace addObject:id_login];
        [request insert:204 array:datasFace];
        bandera=0;
        
    }else{
        
        
        NSArray *res=[request leerConsultaMysql:20 texto:[datasFace objectAtIndex:1]];
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"iNeedClass" message:@"Login OK" delegate:self cancelButtonTitle:@"Main" otherButtonTitles:@"Account", nil];
         NSLog(@"%@", res);
        NSString *id_user1=[[res objectAtIndex:0] objectForKey:@"id_user"];
        id_user=id_user1;
        // Store the data
        [datasFace addObject:id_user1];
       [request update:501 array:datasFace];
        NSUserDefaults *login = [NSUserDefaults standardUserDefaults];
        [login setObject:[datasFace objectAtIndex:1] forKey:@"mail"];
        [login setObject:id_user1 forKey:@"id_user"];
        [login setObject:@"1" forKey:@"facebook"];
        [login setObject:[datasFace objectAtIndex:2] forKey:@"name"];
        [login setObject:[datasFace objectAtIndex:3] forKey:@"lastname"];
        [login synchronize];
        bandera=1;
        [mes show];
    }
    
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
        // Store the data
        NSUserDefaults *login = [NSUserDefaults standardUserDefaults];
        [login setObject:username forKey:@"mail"];
        [login setObject:id_user1 forKey:@"id_user"];
        [login setObject:name forKey:@"name"];
        [login setObject:@"0" forKey:@"facebook"];
        [login setObject:lastname forKey:@"lastname"];
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
