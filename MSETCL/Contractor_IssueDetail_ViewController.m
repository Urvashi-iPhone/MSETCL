//
//  Contractor_IssueDetail_ViewController.m
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/15/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import "Contractor_IssueDetail_ViewController.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"
#import "Constant.h"
#import "AppMethod.h"
#import "ContractorTableViewCell.h"
#import "Contractor_Issue_Stage_ViewController.h"
@interface Contractor_IssueDetail_ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSDictionary *responseDic;
     NSMutableArray *issueList;
    
}
@property (weak, nonatomic) IBOutlet UITableView *mytbl;
@end

@implementation Contractor_IssueDetail_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getIssueDetailList];
}
-(void)getIssueDetailList
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[AppMethod getStringDefault:DEF_USER_TOKEN] forHTTPHeaderField:@"User-Token"];
    
    [ProgressHUD show:@"Please wait..."];
    
    NSLog(@"%d",_issueID);
    
    
    NSString *url=[NSString stringWithFormat:@"%@%d",[BASE_URL stringByAppendingString:URL_CONTRACTOR_ISSUE_DETAILS],_issueID];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        responseDic = responseObject;
        
        issueList = [responseDic valueForKey:@"data"];
        
        [_mytbl reloadData];
        
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
    return [issueList count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContractorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSMutableDictionary *dic = [issueList objectAtIndex:indexPath.row];
    cell.contractorIssueType.text = [[[issueList objectAtIndex:indexPath.row]valueForKey:@"contractor_issue_type"] valueForKey:@"name"];
    
    cell.issue_progress.hidden = YES;
    cell.layer.borderColor = [[UIColor whiteColor] CGColor];
    cell.layer.cornerRadius = 10.0f;
    cell.layer.borderWidth = 3.0f;
    
    cell.issue_date.text = [[issueList objectAtIndex:indexPath.row]valueForKey:@"created_at"] ;
   
    if ([[[issueList objectAtIndex:indexPath.row] valueForKey:@"is_solved"] integerValue] ==  1)
    {
        cell.issueStatus.text = @"Completed";
    }
    else {
        if (([[[issueList objectAtIndex:indexPath.row]valueForKey:@"is_started"] integerValue] ==  1)) {
            cell.issueStatus.text = @"Running";
            cell.issue_progress.hidden = NO;
            
        }
        else
        {
            cell.issueStatus.text = @"Pending";
        }
    }
    
    NSString *stageDetail =  [[issueList objectAtIndex:indexPath.row] valueForKey:@"stage_details"];
    
    NSInteger issueID =  [[[issueList objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue];
    
    cell.issue_progress.tag = indexPath.row;
    
    [cell.issue_progress addTarget:self action:@selector(viewBtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)viewBtn:(UIButton*)sender
{
    
    Contractor_Issue_Stage_ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Contractor_Issue_Stage_ViewController"];
    
    NSString *issue = [[issueList objectAtIndex:sender.tag] valueForKey:@"stage_details"];
    
    vc.stage = issue;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
