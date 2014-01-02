//
//  CollectionViewController.m
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 08/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "CollectionViewController.h"
#import "InfoPeopleViewController.h"
#import "People.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "AccountViewController.h"

@interface CollectionViewController (){
    NSMutableArray *datasPeople;
    NSMutableArray *nameExchange2;
    
}
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@end

@implementation CollectionViewController
@synthesize collection, state, city;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - UICollectionViewDataSource & Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [people count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CellCollection *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //NSLog(@"%ld", [people count]);
    //if(indexPath.row < [people count]){
        People *person=[people objectAtIndex:indexPath.row];
        //NSLog(@"%ld", [person.level integerValue]);
        //NSLog(@"%f", (double)[person.level integerValue]/6);
        cell.fullNameLabel.text=[[NSString alloc] initWithFormat:@"%@ %@",person.name, person.lastName ];
        [cell.progressLevel setProgress:((double)[person.level integerValue]/6) animated:YES];
        cell.ageLabel.text=person.age;
        cell.cityStateLabel.text=[[NSString alloc] initWithFormat:@"%@, %@",person.city, person.state];
    
        cell.detailsExchange.text=[[NSString alloc] initWithFormat:@"%@ - %@", self.name_exchange, [nameExchange2 objectAtIndex:indexPath.row]];
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
    InfoPeopleViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"infoPeople"];
    People *person=[people objectAtIndex:indexPath.row];
    
    view.idperson=person.id_user;
    view.state=state;
    view.city=city;
    view.exchange1=self.name_exchange;
    view.id_exchange=person.id_exchange;
    [self presentNatGeoViewController:view completion:nil];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    user = [defaults objectForKey:@"id_user"];
	// Do any additional setup after loading the view.
    self.collection.delegate = self;
    self.collection.dataSource = self;
    //NSLog(@"city: %@", city);
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:2];
    
    request=[[RequestToJSON alloc]init];
    //city=@"New York";
    //state=@"NY";
    people=[[NSMutableArray alloc]init];
    citySpace=[city stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    if([self.levelTest isEqualToString:@"7"]){
       paraPickerPeople=[request leerConsultaMysql:8 texto1:citySpace texto2:state texto3:self.id_exchange];
    }else{
        paraPickerPeople=[request leerConsultaMysql:81 texto1:citySpace texto2:state texto3:self.id_exchange texto4:self.levelTest];
    }
    nameExchange2=[[NSMutableArray alloc]init];
    for (int cont=0;cont<[paraPickerPeople count];cont++) {
        
        NSString *id_user=[[paraPickerPeople objectAtIndex:cont] objectForKey:@"id_user"];
        NSString *name=[[paraPickerPeople objectAtIndex:cont] objectForKey:@"name"];
        NSString *lastName=[[paraPickerPeople objectAtIndex:cont] objectForKey:@"lastname"];
        NSString *level=[[paraPickerPeople objectAtIndex:cont] objectForKey:@"level"];
        NSString *age=[[paraPickerPeople objectAtIndex:cont] objectForKey:@"age"];
        NSString *city_person=[[paraPickerPeople objectAtIndex:cont] objectForKey:@"city"];
        NSString *state_code=[[paraPickerPeople objectAtIndex:cont] objectForKey:@"state_code"];
        NSString *exchangetemp=[[paraPickerPeople objectAtIndex:cont] objectForKey:@"id_exchange"];
        NSString *exchange2temp=[[paraPickerPeople objectAtIndex:cont] objectForKey:@"id_exchange2"];
        NSArray *paraPickerExchanges2=[request leerConsultaMysql:18 texto:exchange2temp];
        //NSLog(@"exachange2 ID: %@", exchange2temp);
        //NSLog(@"exachange2 ARRAY: %@", paraPickerExchanges2);
        [nameExchange2 addObject:[[paraPickerExchanges2 objectAtIndex:0] objectForKey:@"name"]];
        //NSLog(@"exachange2 NAME: %@", nameExchange2);
        //NSLog(@"%@",prov);
        People *person=[[People alloc]init];
        person.name=name;
        person.id_user=id_user;
        person.lastName=lastName;
        person.level=level;
        person.age=age;
        person.city=city_person;
        person.state=state_code;
        person.id_exchange=exchangetemp;
        [people addObject:person];
        
        
    }
//NSLog(@"%@", people);
    
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
@end
