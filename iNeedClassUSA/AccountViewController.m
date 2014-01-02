//
//  AccountViewController.m
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 20/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "AccountViewController.h"
#import "AccountModifyViewController.h"
#import "MainViewController.h"
#import "LoginViewController.h"

@interface AccountViewController (){
    NSString *user;
}
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

@end

@implementation AccountViewController

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
    self.id_user=user;
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];
	// Do any additional setup after loading the view.
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

- (IBAction)exchanges:(id)sender {
    
}

- (IBAction)exit:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *username=@"guess_inc";
    NSString *id_user=@"0";
    [defaults setObject:username forKey:@"username"];
    [defaults setObject:id_user forKey:@"id_user"];
    [defaults synchronize];
    LoginViewController *view=[self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    [self presentNatGeoViewController:view completion:nil];

}

- (IBAction)account:(id)sender {
    AccountModifyViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"accountModify"];
    view.id_user=self.id_user;
    [self presentNatGeoViewController:view completion:nil];

}

- (IBAction)teachers:(id)sender {
    UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"iNeedClass"
                                                message:@"COMING SOON..." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [mes show];
    
}


@end
