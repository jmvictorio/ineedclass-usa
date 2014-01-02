//
//  TeacherAccountViewController.m
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 20/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "TeacherAccountViewController.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "AccountViewController.h"

@interface TeacherAccountViewController (){
    int bandera;
    NSString *user;
}
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

@end

@implementation TeacherAccountViewController
@synthesize kindSubjects, subjects, subjectsAndPrices, idarrays, collection;
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
    //go.hidden=YES;
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.kindSubjects = [NSArray arrayWithObjects:@"English", @"Spanish", @"French", @"Chinese", @"Japanese", @"Thailand", nil];
    self.subjects = [NSArray arrayWithObjects:@"Beginner", @"Elementary", @"Pre-Intermediate", @"Intermediate", @"Pre-advanced", @"Advance",@"All Levels", nil];
    self.idarrays = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];
    bandera=0;
    //nameCity.text=[[NSString alloc]initWithFormat:@"%@, %@", city, state];
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
#pragma mark - UICollectionViewDataSource & Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    // cell customization
    return cell;
    //NSString *datoString = [ArrayRN objectAtIndex:indexPath.row];
    //cell.texto.text=datoString;
    
    /*cell.backgroundColor = indexPath.row % 2 == 0 ? [UIColor redColor] : [UIColor greenColor];*/
    //[ArrayCeldas addObject:cell];
    //return nil;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*InfoPeopleViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"infoPeople"];
    view.idperson=[idpeople objectAtIndex:indexPath.row];
    view.state=state;
    view.city=city;
    [self presentNatGeoViewController:view completion:nil];*/
    
}

@end
