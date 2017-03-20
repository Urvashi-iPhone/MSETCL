//
//  Employe_GetIssue_ViewController.m
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/14/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import "Employe_GetIssue_ViewController.h"
#import <AFNetworking.h>
#import "Constant.h"
#import "AppMethod.h"
#import <TPSSquareDropDown.h>
#import "ProgressHUD.h"
#import "Employee_TableViewCell.h"
#import "SWRevealViewController.h"
#import "UIView+Toast.h"
#import "Employe_IssueDetail_ViewController.h"

@interface Employe_GetIssue_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary *issueDic;
    NSMutableArray *issueList;
    NSString *stageDetail;
    NSInteger issueID;
}
-(void)segueIdentifierReceivedFromParent:(NSString*)button;
@property NSString *segueIdentifier;
@property (weak, nonatomic) IBOutlet UITableView *issueTbl;

@end

@implementation Employe_GetIssue_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getEmployeeIssueType_data];
}

-(void)getEmployeeIssueType_data
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[AppMethod getStringDefault:DEF_USER_TOKEN] forHTTPHeaderField:@"User-Token"];
    
    [manager GET:[BASE_URL stringByAppendingString:URL_EMPLOYEE_ISSUE_TYPE] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        issueDic = responseObject;
        issueList = [issueDic valueForKey:@"data"];
        [_issueTbl reloadData];
        [ProgressHUD dismiss];
        
    }failure:^(NSURLSessionTask *operation, NSError *error)
     {
         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"MSETCL" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
         [al show];
         [ProgressHUD dismiss];
     }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [issueList count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"Cell";
    
    Employee_TableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    cell.layer.borderColor = [[UIColor whiteColor] CGColor];
    cell.layer.cornerRadius = 10.0f;
    cell.layer.borderWidth = 3.0f;
    
    cell.prjName.text = [[[issueList objectAtIndex:indexPath.row] valueForKey:@"project"] valueForKey:@"project_name"];
    cell.issueType.text = [[[issueList objectAtIndex:indexPath.row] valueForKey:@"issuetype"] valueForKey:@"issue_name"];
    cell.startedTime.text = [[issueList objectAtIndex:indexPath.row] valueForKey:@"started_date"] ;
     cell.quantityRs.text = [NSString stringWithFormat:@"\u20B9%@",[[issueList objectAtIndex:indexPath.row] valueForKey:@"quantity_variation_rupees"]];
    
     cell.QuantityPer.text = [NSString stringWithFormat:@"%@",[[issueList objectAtIndex:indexPath.row] valueForKey:@"quantity_variation_percentage"]];
    
    cell.tenderAuth.text = [[issueList objectAtIndex:indexPath.row] valueForKey:@"tender_approve_authority"];
    
    NSString *isAssign =  [NSString stringWithFormat:@"%@",[[issueList objectAtIndex:indexPath.row] valueForKey:@"current_assign_issue"] ];
    
    cell.queRslbl.text = @"Quantity Variation(\u20B9)";
    
    cell.isAssign.text = isAssign;
    
    
   stageDetail =  [[issueList objectAtIndex:indexPath.row] valueForKey:@"stage_details"];
    
      issueID =  [[[issueList objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue];
    
//    if ([isAssign isEqualToString:@"1"])
//    {
//        cell.isAssign.text = @"Yes";
//    }
//    else
//    {
//        cell.isAssign.text = @"No";
//    }
//    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   //   [self segueIdentifierReceivedFromParent:@"buttonIssueDetail"];
    Employe_IssueDetail_ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Employe_IssueDetail_ViewController"];
     vc.stage = stageDetail;
     vc.issueId = issueID;
     [self.navigationController pushViewController:vc animated:YES];
    
}
//-(void)segueIdentifierReceivedFromParent:(NSString*)button{
//    
//    
//    if ([button  isEqual: @"buttonIssueDetail"]){
//        
//        
//        self.segueIdentifier = @"issueDetail";
//        [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
//    }
//}
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//
//    
//    UIViewController  *lastViewController;
//    
//    if ([[segue identifier] isEqual: self.segueIdentifier])
//    {
//        if(lastViewController != nil)
//        {
//            [lastViewController.view removeFromSuperview];
//            
//            
//        }
//        
//        
//        // Get reference to the destination view controller
//        Employe_IssueDetail_ViewController *vc = (Employe_IssueDetail_ViewController *)[segue destinationViewController];
//        vc.stage = stageDetail;
//        vc.issueId = issueID;
//        [self addChildViewController:(vc)];
//       
//        vc. view.frame  = CGRectMake(0,0, self.view.frame.size.width , self.view.frame.size.height);
//        
//        [self.view addSubview:vc.view];
//        lastViewController = vc;
//        // Pass any objects to the view controller here, like...
//        
//    }
//}

@end

