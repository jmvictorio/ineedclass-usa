//
//  LanguageAccountViewController.m
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 20/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "LanguageAccountViewController.h"
#import "AddLanguageViewController.h"
#import "CellCollectionExchange.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "AccountViewController.h"

@interface LanguageAccountViewController (){
    NSArray *paraPickerExchanges1;
    NSArray *paraPickerExchanges2;
    
    NSString *user;
    
    NSMutableArray *name1;
    NSMutableArray *name2;
    NSMutableArray *id_exchanges1;
    NSMutableArray *id_exchanges2;
    NSMutableArray *ids_array;
    NSMutableArray *cities;
    NSMutableArray *states;
    
    NSMutableArray *forModify;
    
}
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;

@end

@implementation LanguageAccountViewController
@synthesize collection, addLanguage;

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
    self.collection.delegate = self;
    self.collection.dataSource = self;
    //[self reload];
    name1=[[NSMutableArray alloc]init];
    name2=[[NSMutableArray alloc]init];
    id_exchanges1=[[NSMutableArray alloc]init];
    id_exchanges2=[[NSMutableArray alloc]init];
    ids_array=[[NSMutableArray alloc]init];
    cities=[[NSMutableArray alloc]init];
    states=[[NSMutableArray alloc]init];
    
    request=[[RequestToJSON alloc]init];
    //city=@"New York";
    //state=@"NY";
    exchanges=[[NSMutableArray alloc]init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    user = [defaults objectForKey:@"id_user"];
    paraPickerExchanges1=[request leerConsultaMysql:12 texto:user];
    
    //NSLog(@"%ld", (unsigned long)[paraPickerExchanges1 count]);
    for (int cont=0;cont<[paraPickerExchanges1 count];cont++) {
        
        NSString *exchange1=[[paraPickerExchanges1 objectAtIndex:cont] objectForKey:@"name"];
        NSString *id_exchange1=[[paraPickerExchanges1 objectAtIndex:cont] objectForKey:@"id_exchange1"];
        NSString *ids=[[paraPickerExchanges1 objectAtIndex:cont] objectForKey:@"id_exchange"];
        NSString *cityTemp=[[paraPickerExchanges1 objectAtIndex:cont] objectForKey:@"id_exchange1"];
        NSString *stateTemp=[[paraPickerExchanges1 objectAtIndex:cont] objectForKey:@"id_exchange"];
        //NSLog(@"%@", id_exchange2);
        [name1 addObject:exchange1];
        [id_exchanges1 addObject:id_exchange1];
        [ids_array addObject:ids];
        [cities addObject:cityTemp];
        [states addObject:stateTemp];
        
    }
    paraPickerExchanges2=[request leerConsultaMysql:13 texto:user];
    for (int cont=0;cont<[paraPickerExchanges2 count];cont++) {
        
        NSString *exchange1=[[paraPickerExchanges2 objectAtIndex:cont] objectForKey:@"name"];
        NSString *id_exchange2=[[paraPickerExchanges2 objectAtIndex:cont] objectForKey:@"id_exchange2"];
        //NSLog(@"%@", id_exchange2);
        [name2 addObject:exchange1];
        [id_exchanges2 addObject:id_exchange2];
        
    }

    //NSLog(@"Exchange 1: %@", name1);
    //NSLog(@"Exchange 2: %@", name2);
    
    
    
    [addLanguage addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
	
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
- (IBAction)send:(id)sender {
    AddLanguageViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"addLanguage"];
    view.insert=@"1";
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
#pragma mark - UICollectionViewDataSource & Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [name1 count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CellCollectionExchange *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.exchange2.text=[name2 objectAtIndex:indexPath.row];
    cell.exchange1.text=[name1 objectAtIndex:indexPath.row];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array=@[[name2 objectAtIndex:indexPath.row],
                     [name1 objectAtIndex:indexPath.row],
                     [id_exchanges1 objectAtIndex:indexPath.row],
                     [id_exchanges2 objectAtIndex:indexPath.row],
                     [ids_array objectAtIndex:indexPath.row]];
    forModify=[[NSMutableArray alloc]initWithArray:array];
    [self abrirActionSheet];
    
}
- (IBAction)abrirActionSheet{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]init];
    actionSheet.delegate=self;
    [actionSheet addButtonWithTitle:@"Modify Exchange"];
    [actionSheet addButtonWithTitle:@"Delete"];
    
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    
    [actionSheet showInView:self.view];
    
}
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        AddLanguageViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"addLanguage"];
        view.labelKnow.text=[forModify objectAtIndex:0];
        view.labelLearn.text=[forModify objectAtIndex:1];
        view.exchange1=[forModify objectAtIndex:2];
        view.exchange2=[forModify objectAtIndex:3];
        view.id_exchange=[forModify objectAtIndex:4];
        view.insert=@"0";
        [self presentNatGeoViewController:view completion:nil];
        
        
        
    }else if(buttonIndex == 1){
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"iNeedClass" message:@"Are you sure?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alerta show];
    }
}
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 1)
    {
        [request leerConsultaMysql:301 texto:[forModify objectAtIndex:4]];
        paraPickerExchanges1=[request leerConsultaMysql:12 texto:user];
        
        //NSLog(@"%ld", (unsigned long)[paraPickerExchanges1 count]);
        for (int cont=0;cont<[paraPickerExchanges1 count];cont++) {
            
            NSString *exchange1=[[paraPickerExchanges1 objectAtIndex:cont] objectForKey:@"name"];
            NSString *id_exchange1=[[paraPickerExchanges1 objectAtIndex:cont] objectForKey:@"id_exchange1"];
            NSString *ids=[[paraPickerExchanges1 objectAtIndex:cont] objectForKey:@"id_exchange"];
            NSString *cityTemp=[[paraPickerExchanges1 objectAtIndex:cont] objectForKey:@"id_exchange1"];
            NSString *stateTemp=[[paraPickerExchanges1 objectAtIndex:cont] objectForKey:@"id_exchange"];
            //NSLog(@"%@", id_exchange2);
            [name1 addObject:exchange1];
            [id_exchanges1 addObject:id_exchange1];
            [ids_array addObject:ids];
            [cities addObject:cityTemp];
            [states addObject:stateTemp];
            
        }
        paraPickerExchanges2=[request leerConsultaMysql:13 texto:user];
        for (int cont=0;cont<[paraPickerExchanges2 count];cont++) {
            
            NSString *exchange1=[[paraPickerExchanges2 objectAtIndex:cont] objectForKey:@"name"];
            NSString *id_exchange2=[[paraPickerExchanges2 objectAtIndex:cont] objectForKey:@"id_exchange2"];
            //NSLog(@"%@", id_exchange2);
            [name2 addObject:exchange1];
            [id_exchanges2 addObject:id_exchange2];
            
        }

    }
    
}


@end
