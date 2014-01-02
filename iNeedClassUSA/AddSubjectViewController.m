//
//  AddSubjectViewController.m
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 22/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "AddSubjectViewController.h"
#import "LoginViewController.h"
#import "AccountViewController.h"
#import "MainViewController.h"

@interface AddSubjectViewController (){
    UIPickerView *picker;
    
    UITextField *price;
    
    NSString *user;
}

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@end

@implementation AddSubjectViewController
@synthesize subjectLabel;
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
	// Do any additional setup after loading the view.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    user = [defaults objectForKey:@"id_user"];
    
    picker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 220, 320, 162)];
    [picker setMultipleTouchEnabled:NO];
    //[stateAndCity setBackgroundColor:[UIColor blackColor]];
    picker.delegate=self;
    
    [self.view addSubview:picker];
    
    price = [[UITextField alloc]initWithFrame:CGRectMake(112, 150, 100, 30)];
    price.autocapitalizationType = UITextAutocapitalizationTypeWords;
    price.borderStyle = UITextBorderStyleLine;
    price.placeholder = @"X.X";
    price.font = [UIFont systemFontOfSize:13];
    price.keyboardType = UIKeyboardTypeDecimalPad;
    price.clearButtonMode = UITextFieldViewModeWhileEditing;
    price.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    price.delegate = self;
    [price setReturnKeyType:UIReturnKeyDefault];
    [price addTarget:self action:@selector(cerrarTeclado:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:price];
    
}
- (IBAction)cerrarTeclado:(id)sender {
    [price resignFirstResponder];
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


//PICKER METODOS

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component==0){
    }
    else{
        subjectLabel.text=[[NSString alloc] initWithString:[paraPicker objectAtIndex:row]];
        
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component==0){
        return 1;
    }
    else{
        return [paraPicker count];
        
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component==0){
        return @"Language";
    }
    else{
        return [paraPicker objectAtIndex:row];
    }
}
- (IBAction)save:(id)sender{
    
}
@end
