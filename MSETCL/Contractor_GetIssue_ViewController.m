//
//  Contractor_GetIssue_ViewController.m
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/8/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import "Contractor_GetIssue_ViewController.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"
#import "Constant.h"
#import "AppMethod.h"
#import "ContractorTableViewCell.h"
@interface Contractor_GetIssue_ViewController ()
{
    NSDictionary *responseDic;
    NSMutableArray *myIssueList;
}
@property (weak, nonatomic) IBOutlet UITableView *issueTbl;
@end

@implementation Contractor_GetIssue_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    NSMutableArray *distList = [responseDic valueForKey:@"data"];
    [self getIssueList:[[[distList objectAtIndex:index] valueForKey:@"id"] intValue]];
}

-(void)getIssueList:(int)district_id
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     [manager.requestSerializer setValue:[AppMethod getStringDefault:DEF_USER_TOKEN] forHTTPHeaderField:@"User-Token"];
    
    [ProgressHUD show:@"Please wait..."];
    
    NSString *url=[BASE_URL stringByAppendingString:URL_CONTRACTOR_GET_ISSUE];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setObject:[NSString stringWithFormat:@"%d",district_id] forKey:@"district_id"];
    
    [manager GET:url parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        responseDic = responseObject;
        
        NSMutableArray *issueList = [responseDic valueForKey:@"data"];
        
        myIssueList = [[NSMutableArray alloc] init];
        for (int i =0; i<[issueList count]; i++)
        {
            NSString *value = [issueList objectAtIndex:i];
            NSLog(@"get = %@",value);
          [myIssueList addObject:value];
        }
      
        [_issueTbl reloadData];
        [ProgressHUD dismiss];
        
    } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"MSETCL" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
         [al show];
         [ProgressHUD dismiss];
     }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [myIssueList count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContractorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
   cell.issueName.text = [[[myIssueList objectAtIndex:indexPath.row]valueForKey:@"issuetype"] valueForKey:@"issue_name"];
   cell.issueNumber.text = [[myIssueList objectAtIndex:indexPath.row]valueForKey:@"employee_sap_id"];
    NSString *issueDetail = [[myIssueList objectAtIndex:indexPath.row]valueForKey:@"issue_details"];
    issueDetail = [issueDetail stringByReplacingOccurrencesOfString:@"{" withString:@""];
     issueDetail = [issueDetail stringByReplacingOccurrencesOfString:@"}" withString:@""];
     issueDetail = [issueDetail stringByReplacingOccurrencesOfString:@"\"" withString:@""];
     issueDetail = [issueDetail stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
    cell.billName_Number_UserName.text = issueDetail;
    
    return cell;
}

@end
