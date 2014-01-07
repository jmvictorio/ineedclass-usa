//
//  InfoPeopleViewController.m
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 11/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "InfoPeopleViewController.h"
#import "SignInViewController.h"
#import "MainViewController.h"
#import "AccountViewController.h"
#import "LoginViewController.h"

@interface InfoPeopleViewController (){
    NSString *num;
    NSString *mail;
    NSArray *datas;
    int bandera;
}

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@end

@implementation InfoPeopleViewController
@synthesize city, state, idperson, id_exchange;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)startup{
    self.state=@"NY";
    self.city=@"New York";
    self.idperson=@"2";
    self.exchange1=@"English";

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self startup];
    //NSLog(@"%@", idperson);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    user = [defaults objectForKey:@"id_user"];
	// Do any additional setup after loading the view.
    levels = [NSArray arrayWithObjects:@"Beginner", @"Elementary", @"Pre-Intermediate", @"Intermediate", @"Pre-advanced", @"Advance", nil];
    request=[[RequestToJSON alloc]init];
    datas=[request leerConsultaMysql:9 texto:id_exchange];
    //NSLog(@"%@", [[datas objectAtIndex:0] objectForKey:@"name"]);
    NSString *name=[[datas objectAtIndex:0] objectForKey:@"name"];
    NSString *lastname=[[datas objectAtIndex:0] objectForKey:@"lastname"];
    mail=[[datas objectAtIndex:0] objectForKey:@"email"];
    NSString *exchange=[[datas objectAtIndex:0] objectForKey:@"exchange"];
    NSString *age=[[datas objectAtIndex:0] objectForKey:@"age"];
    num=[[datas objectAtIndex:0] objectForKey:@"tel"];
    NSString *level=[[datas objectAtIndex:0] objectForKey:@"level"];
    NSString *observations=[[datas objectAtIndex:0] objectForKey:@"observations"];
    NSString *genre;
    
    if([[[datas objectAtIndex:0] objectForKey:@"genre"] isEqualToString:@"1"]){
        genre=@"Male";
    }else if([[[datas objectAtIndex:0] objectForKey:@"genre"] isEqualToString:@"2"]){
        genre=@"Female";
    }else{
        self.genreLabelMuestra.hidden=YES;
    }
    self.genreLabel.text=genre;
    self.fullNameLabel.text=[[NSString alloc]initWithFormat:@"%@ %@",name, lastname];
    self.namePrincipal.text=[[NSString alloc]initWithFormat:@"%@ - %@",self.exchange1, exchange];
    if([age isEqualToString:@"0"]){
        self.ageLabel.hidden=YES;
    }else{
        
        self.ageLabel.text=age;
    }
    if([num isEqualToString:@"0"]){
        self.callButton.hidden=YES;
    }else{
        
        self.callButton.hidden=NO;
    }
    [self.levelProgress setProgress:((double)[level integerValue]/6) animated:YES];
    self.levelLabel.text=[levels objectAtIndex:[level integerValue]-1];
    self.observationsText.text=observations;
    
    FBProfilePictureView *pictureProfile=[[FBProfilePictureView alloc]initWithProfileID:self.picture pictureCropping:FBProfilePictureCroppingOriginal];
    [pictureProfile setFrame:CGRectMake(125, 100, 70, 70)];
    [self.view addSubview:pictureProfile];
    UIImageView *circulo;
    if([self.picture isEqualToString:@"0"]){
        circulo=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"circuloFace200Person.png"]];
        
    }else{
        circulo=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"circuloFace200.png"]];
        
    }
    [circulo setFrame:CGRectMake(122, 97, 75, 75)];
    [self.view addSubview:circulo];

    
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

- (IBAction)mail:(id)sender {
    if([user isEqualToString:@"0"]){
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"iNeedClass"
                                                    message:@"You must Sign Up for to access here" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Sign Up", nil];
        bandera=0;
        [mes show];
    }
    else{
        NSString *emailTitle = @"About your ad in iNeedClass";
        // Email Content
        NSString *messageBody = @"I'm interesting in your iNeedClass's ad";
        // To address
        NSArray *toRecipents = [NSArray arrayWithObject:mail];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:nil];
    }
    // Email Subject
    
    
}
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if(bandera==0){
        if (buttonIndex == 1)
        {
            SignInViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"signup"];
            //view.id_user=id_user;
            [self presentNatGeoViewController:view completion:nil];
            
        }
    }
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)call:(id)sender {
    if([user isEqualToString:@"0"]){
        bandera=0;
        
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"iNeedClass"
                                                    message:@"You must Sign Up for to access here" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Sign Up", nil];
        
        [mes show];
    }
    else{
        [self llamada];
    }
}


-(void)llamada {
    NSString *marcar=[[NSString alloc]initWithFormat:@"tel:%@", num];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:marcar]];
}

@end
