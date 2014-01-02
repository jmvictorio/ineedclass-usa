//
//  MainViewController.m
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 13/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"
#import "AccountViewController.h"

@interface MainViewController (){
    NSString *user;
}
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@end

@implementation MainViewController

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
    [self save];
    [super viewDidLoad];
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:0];
	// Do any additional setup after loading the view.
}
- (void)save
{
    // Create strings and integer to store the text info
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    user = [defaults objectForKey:@"id_user"];
    //NSLog(@"%@", user);
    if([user integerValue] <1){
        NSString *username=@"guess_inc";
        user=@"0";
        [defaults setObject:username forKey:@"username"];
        [defaults setObject:user forKey:@"id_user"];
        [defaults synchronize];
        //NSLog(@"Data saved");
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    [sidebar dismiss];
}

@end
