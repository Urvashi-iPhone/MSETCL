//
//  FAQ's_ViewController.m
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/8/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import "Contractor_FAQs_ViewController.h"
#import "SWRevealViewController.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"
#import "AppMethod.h"
#import "Constant.h"
#import "ContractorTableViewCell.h"

@interface Contractor_FAQs_ViewController()
{
    NSMutableArray *myFaqList;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
@property (weak, nonatomic) IBOutlet UITableView *contractorTbl;

@end

@implementation Contractor_FAQs_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
//        [self.navigationController.view removeGestureRecognizer:self.navigationController.interactivePopGestureRecognizer];
    self.navigationController.navigationBar.hidden =YES;
    
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    [self getFaq_data];
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
      
        [_contractorTbl reloadData];
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
    ContractorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
   cell.txtQue_Contactor.text = [[myFaqList objectAtIndex:indexPath.row] valueForKey:@"question"];
    cell.txtAns_Contractor.text = [[myFaqList objectAtIndex:indexPath.row] valueForKey:@"answer"];
    
    return cell;
}


@end
