//
//  ContractorIssue_ViewController.m
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/10/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import "ContractorIssue_ViewController.h"
#import <AFNetworking.h>
#import "Constant.h"
#import "AppMethod.h"
#import <TPSSquareDropDown.h>
#import "ProgressHUD.h"
#import "ContractorTableViewCell.h"
#import "SWRevealViewController.h"
#import "UIView+Toast.h"

@interface ContractorIssue_ViewController ()<TPSDropDownDelegate>
{
    NSMutableDictionary *issueDic,*projectDic;
    NSMutableArray *myIssueList,*myIssueFieldList,*myProjectList;
}
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
@property (weak, nonatomic) IBOutlet TPSSquareDropDown *txtIssueType;
@property (weak, nonatomic) IBOutlet TPSSquareDropDown *txtPrjList;
@property (weak, nonatomic) IBOutlet UIWebView *wvIssueField;

@end

@implementation ContractorIssue_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        [self.navigationController.view removeGestureRecognizer:self.navigationController.interactivePopGestureRecognizer];
    self.navigationController.navigationBar.hidden =YES;

    [self getProjectList];
    [_wvIssueField setDelegate:self];
}


-(void)getProjectList
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[AppMethod getStringDefault:DEF_USER_TOKEN] forHTTPHeaderField:@"User-Token"];
    [ProgressHUD show:@"Please wait..."];
    
    [manager GET:[BASE_URL stringByAppendingString:URL_PROJECTS_LIST_CONTRACTOR] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        projectDic = responseObject;
        myProjectList = [[NSMutableArray alloc] init];
        NSMutableArray *prjTitle = [projectDic valueForKey:@"data"];
        
        for (int i=0; i<[prjTitle count]; i++)
        {
            NSString *value = [NSString stringWithFormat:@"%@(%@)",[[prjTitle objectAtIndex:i] valueForKey:@"project_name"],[[prjTitle objectAtIndex:i] valueForKey:@"sub_wbs_element"]];
        
            NSLog(@"%@",value);
            [myProjectList addObject:value];

        }
        _txtPrjList.items = myProjectList;
        _txtPrjList.selectedItemIndex = 0;
        [ProgressHUD dismiss];
        
    } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"MSETCL" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
         [al show];
         [ProgressHUD dismiss];
     }];
}

- (void)dropDown:(TPSDropDown *)dropDown didSelectItemAtIndex:(NSInteger)index
{
    if ([dropDown isEqual:_txtPrjList])
    {
          NSMutableArray *prjTitle = [projectDic valueForKey:@"data"];
        
        [self getContractorIssueType_data:[[[prjTitle objectAtIndex:index] valueForKey:@"project_id"] intValue]];
        
    }
    else
    {
    NSInteger issueTypeId = [[[[issueDic valueForKey:@"data"] objectAtIndex:index] valueForKey:@"id"] integerValue];
        
    NSMutableArray *prjTitle = [projectDic valueForKey:@"data"];
        
    NSInteger prjID = [[[prjTitle objectAtIndex:[_txtPrjList selectedItemIndex]]valueForKey:@"id"] intValue];
        
    NSString *urlAddress =  [NSString stringWithFormat:@"http://192.168.0.105/laravel/MSETCL/project/public/contractor/getcontractorissueform?id=%d&sapid=%@&password=%@&projects=%d",issueTypeId,[AppMethod getStringDefault:DEF_SAP_ID],[AppMethod getStringDefault:DEF_PASSWORD],prjID];
    
    [self.wvIssueField loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlAddress]]];
    }
}

-(void)getContractorIssueType_data:(int)project_id
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[AppMethod getStringDefault:DEF_USER_TOKEN] forHTTPHeaderField:@"User-Token"];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setObject:[NSString stringWithFormat:@"%d",project_id] forKey:@"project_id"];
    
    [manager GET:[BASE_URL stringByAppendingString:URL_GET_CONTRACTOR_ISSUE_TYPE] parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        issueDic = responseObject;
        
        NSMutableArray *issueList = [issueDic valueForKey:@"data"];
        myIssueList = [[NSMutableArray alloc] init];
        for (int i =0; i<[issueList count]; i++)
        {
            NSString *value = [[issueList objectAtIndex:i] valueForKey:@"name"];
            NSLog(@"get = %@",value);
            [myIssueList addObject:value];
        }
        _txtIssueType.items = myIssueList;
        _txtIssueType.selectedItemIndex = 0;
        
        
        [ProgressHUD dismiss];
        
    }failure:^(NSURLSessionTask *operation, NSError *error)
     {
         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"MSETCL" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
         [al show];
         [ProgressHUD dismiss];
     }];
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"Loading URL :%@",request.URL.absoluteString);
    //return FALSE; //to stop loading
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [ProgressHUD show:@"wait"];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [ProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Failed to load with error :%@",[error debugDescription]);
    
}
- (IBAction)backBtn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


//-(void)getIssueType_data
//{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager.requestSerializer setValue:[AppMethod getStringDefault:DEF_USER_TOKEN] forHTTPHeaderField:@"user_token"];
//    
 //   [manager GET:[BASE_URL stringByAppendingString:URL_GET_ISSUE_TYPE] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        issueDic = responseObject;
//        
//        NSMutableArray *issueList = [issueDic valueForKey:@"data"];
//        myIssueList = [[NSMutableArray alloc] init];
//        for (int i =0; i<[issueList count]; i++)
//        {
//            NSString *value = [[issueList objectAtIndex:i] valueForKey:@"issue_name"];
//            NSLog(@"get = %@",value);
//            [myIssueList addObject:value];
//        }
//        _txtIssueType.items = myIssueList;
//        _txtIssueType.selectedItemIndex = 0;
//        [_issueFieldTbl reloadData];
//        
//        if ([[issueDic valueForKey:@"data"] count]>0) {
//            NSDictionary *issueType = [[issueDic valueForKey:@"data"] objectAtIndex:0];
//            NSInteger issueType_Id =[[issueType valueForKey:@"id"] integerValue];
//            [self getIssueTypeField_data:issueType_Id];
//        }
//        
//        [ProgressHUD dismiss];
//        
//    }failure:^(NSURLSessionTask *operation, NSError *error)
//     {
//         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"MSETCL" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//         [al show];
//         [ProgressHUD dismiss];
//     }];
//    
//}
//- (void)dropDown:(TPSDropDown *)dropDown didSelectItemAtIndex:(NSInteger)index
//{
//    NSDictionary *issueType = [[issueDic valueForKey:@"data"] objectAtIndex:index];
//    NSInteger issueType_Id =[[issueType valueForKey:@"id"] integerValue];
//    [self getIssueTypeField_data:issueType_Id];
//}
//
//-(void)getIssueTypeField_data:(NSInteger)issueTypeId
//{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager.requestSerializer setValue:[AppMethod getStringDefault:DEF_USER_TOKEN] forHTTPHeaderField:@"user_token"];
//    
//    NSString *issueField = [NSString stringWithFormat:@"%@%d",[BASE_URL stringByAppendingString:URL_GET_ISSUE_TYPE_FIELDS],issueTypeId];
//    
//    [manager GET:issueField parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        
//        NSDictionary *response = responseObject;
//        NSMutableArray *issueFieldList = [response valueForKey:@"data"];
//        myIssueFieldList = [[NSMutableArray alloc] init];
//        for (int i =0; i<[issueFieldList count]; i++)
//        {
//            NSString *value = [[issueFieldList objectAtIndex:i] valueForKey:@"field_name"];
//            NSLog(@"get = %@",value);
//            [myIssueFieldList addObject:value];
//        }
//        [_issueFieldTbl reloadData];
//        [ProgressHUD dismiss];
//        
//    }failure:^(NSURLSessionTask *operation, NSError *error)
//     {
//         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"MSETCL" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//         [al show];
//         [ProgressHUD dismiss];
//     }];
//    
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [myIssueFieldList count];
//}
//
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    ContractorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    
//    cell.txtIssueFieldType.placeholder = [myIssueFieldList objectAtIndex:indexPath.row];
//    
//    return cell;
//}
//- (IBAction)submitbtn:(id)sender
//{
//    if ([myIssueFieldList count]>0) {
//        
//        NSMutableDictionary *submitIsuueDic = [[NSMutableDictionary alloc] init];
//        NSMutableDictionary *issueDetail = [[NSMutableDictionary alloc] init];
//        for (int i = 0; i<[myIssueFieldList count]; i++)
//        {
//            ContractorTableViewCell *cell = [_issueFieldTbl cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//            NSString *key = [myIssueFieldList objectAtIndex:i];
//            NSString *value = cell.txtIssueFieldType.text;
//            [issueDetail setObject:value forKey:key];
//        }
//        NSLog(@"%@",issueDetail);
//        NSDictionary *issueType = [[issueDic valueForKey:@"data"] objectAtIndex:_txtIssueType.selectedItemIndex];
//        NSString *issueType_Id = [NSString stringWithFormat:@"%d",[[issueType valueForKey:@"id"] integerValue]];
//        NSString *sap_id = [NSString stringWithFormat:@"%d",[AppMethod getIntegerDefault:DEF_SAP_ID]];
//        
//        [submitIsuueDic setObject:issueType_Id forKey:@"issue_type_id"];
//        [submitIsuueDic setObject:sap_id forKey:@"employee_sap_id"];
//        [submitIsuueDic setObject:issueDetail forKey:@"issue_details"];
//        
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        [manager.requestSerializer setValue:[AppMethod getStringDefault:DEF_USER_TOKEN] forHTTPHeaderField:@"user_token"];
//        
//        [manager POST:[BASE_URL stringByAppendingString:URL_SUBMIT_ISSUE] parameters:submitIsuueDic progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//            
//            NSDictionary *response = responseObject;
//            
//            UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"MSETCL" message:@"Submitted SuccesFully" delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
//            [al show];
//            
//            //        NSMutableArray *issueFieldList = [response valueForKey:@"data"];
//            //        myIssueFieldList = [[NSMutableArray alloc] init];
//            //        for (int i =0; i<[issueFieldList count]; i++)
//            //        {
//            //            NSString *value = [[issueFieldList objectAtIndex:i] valueForKey:@"field_name"];
//            //            NSLog(@"get = %@",value);
//            //            [myIssueFieldList addObject:value];
//            //        }
//            //        [_issueFieldTbl reloadData];
//            [ProgressHUD dismiss];
//            
//        }failure:^(NSURLSessionTask *operation, NSError *error)
//         {
//             UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"MSETCL" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
//             [al show];
//             [ProgressHUD dismiss];
//         }];
//        
//    }
//    else
//    {
//        [self.view makeToast:@"Select Issue Type"];
//    }
    
//}


@end
