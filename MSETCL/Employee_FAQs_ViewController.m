//
//  Employee_FAQs_ViewController.m
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/8/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import "Employee_FAQs_ViewController.h"
#import "SWRevealViewController.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"
#import "AppMethod.h"
#import "Constant.h"
#import "Employee_TableViewCell.h"

@interface Employee_FAQs_ViewController ()
{
    NSMutableArray *myFaqList;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
@property (weak, nonatomic) IBOutlet UITableView *emplyeTbl;

@end

@implementation Employee_FAQs_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        [self.navigationController.view removeGestureRecognizer:self.navigationController.interactivePopGestureRecognizer];
    self.navigationController.navigationBar.hidden =YES;
    
    [self getFaq_data];
 
    
}
-(void)viewDidAppear:(BOOL)animated
{
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

-(void)getFaq_data
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[AppMethod getStringDefault:DEF_USER_TOKEN] forHTTPHeaderField:@"User-Token"];
    
    [manager GET:[BASE_URL stringByAppendingString:URL_GET_FAQ] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSDictionary *faqDic = responseObject;
        
        NSMutableArray *FaqList = [faqDic valueForKey:@"data"];
        myFaqList = [[NSMutableArray alloc] init];
        for (int i =0; i<[FaqList count]; i++)
        {
            NSDictionary *data = [FaqList objectAtIndex:i];
            NSLog(@"get = %@",data);
            [myFaqList addObject:data];
        }
        
        [_emplyeTbl reloadData];
        [ProgressHUD dismiss];
        
    }failure:^(NSURLSessionTask *operation, NSError *error)
     {
         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"MSETCL" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
         [al show];
         [ProgressHUD dismiss];
     }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [myFaqList count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Employee_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.txtQue_Employee.text = [[myFaqList objectAtIndex:indexPath.row] valueForKey:@"question"];
    cell.txtAns_Employee.text = [[myFaqList objectAtIndex:indexPath.row] valueForKey:@"answer"];
    
    return cell;
}


@end
