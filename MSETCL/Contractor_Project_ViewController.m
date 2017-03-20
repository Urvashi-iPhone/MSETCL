//
//  Contractor_Project_ViewController.m
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/10/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import "Contractor_Project_ViewController.h"
#import <AFNetworking.h>
#import "Constant.h"
#import "ProgressHUD.h"
#import "AppMethod.h"
#import "STCollapseTableView.h"
#import "ContractorTableViewCell.h"
#import "Contractor_IssueDetail_ViewController.h"
#import "ContractorIssue_ViewController.h"
@interface Contractor_Project_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary *responseDic;
    NSInteger issueid;
}

-(void)segueIdentifierReceivedFromParent:(NSString*)button;
@property NSString *segueIdentifier;

@property (weak, nonatomic) IBOutlet STCollapseTableView *tableview;
@property (nonatomic, strong) NSMutableArray* data;
@property (nonatomic, strong) NSMutableArray* headers;

@end

@implementation Contractor_Project_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getProjectList];
   

}

-(void)getProjectList
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     [manager.requestSerializer setValue:[AppMethod getStringDefault:DEF_USER_TOKEN] forHTTPHeaderField:@"User-Token"];
    [ProgressHUD show:@"Please wait..."];
  
    [manager GET:[BASE_URL stringByAppendingString:URL_PROJECTS_CONTRACTOR] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        responseDic = responseObject;
        
        [self setupViewController];
        [self.tableview reloadData];
        [self.tableview openSection:0 animated:NO];
        
        [ProgressHUD dismiss];
        
    } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"MSETCL" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
         [al show];
         [ProgressHUD dismiss];
     }];
}


- (void)setupViewController
{
    NSMutableArray *title = [[NSMutableArray alloc] init];
    for (int i=0; i<[[responseDic valueForKey:@"data"] count]; i++) {
        [title addObject:[[[[responseDic valueForKey:@"data"] objectAtIndex:i] objectAtIndex:0] valueForKey:@"project_name"]];
    }
    
    _data = [[NSMutableArray alloc] init];
    //_data = [[responseDic valueForKey:@"data"] ];
    
    for (int i = 0 ; i < [title count] ; i++)
    {
        NSMutableArray* section = [[NSMutableArray alloc] init];
        
        for (int j = 0 ; j < [[[responseDic valueForKey:@"data"] objectAtIndex:i] count] ; j++)
        {
            [section addObject:[[[responseDic valueForKey:@"data"] objectAtIndex:i] objectAtIndex:j]];
        }
        //_data = [[responseDic valueForKey:@"data"] objectAtIndex:i];
        [self.data addObject:section];
    }
    
    _headers = [[NSMutableArray alloc] init];
    
    for (int i = 0 ; i < [title count] ; i++)
    {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
//        CGFloat screenHeight = screenRect.size.height;
        UILabel* header = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, screenWidth-40, 40)];
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
        
        header.backgroundColor = [UIColor colorWithRed:143.0f/255.0f green:143.0f/255.0f blue:143.0f/255.0f alpha:1.0];
         view.backgroundColor = [UIColor colorWithRed:143.0f/255.0f green:143.0f/255.0f blue:143.0f/255.0f alpha:1.0];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth-33.5, 7.5, 25, 25)];
        img.image = [UIImage imageNamed:@"next.png"];
        header.font = [UIFont fontWithName:@"Raleway" size:20];
        [header setTextColor:[UIColor whiteColor]];
        view.layer.borderColor = [[UIColor whiteColor] CGColor];
        view.layer.borderWidth = 2.0f;

        [header setHighlighted:YES];
        header.text = [title objectAtIndex:i];
        [view addSubview:header];
        [view addSubview:img];
        [self.headers addObject:view];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"section:-%d",[self.data count]);
    return [self.data count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"Cell";
    
    ContractorTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    
    cell.contentView.layer.borderColor = [[UIColor whiteColor] CGColor];
    cell.contentView.layer.borderWidth = 2.0f;

    
    NSMutableArray *data = [[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
     cell.projectname.text = [data valueForKey:@"project_name"];
     cell.sapid.text = [data valueForKey:@"project_sap_id"];
     cell.WBSelement.text = [data valueForKey:@"wbs_element"];
     cell.subWBSelement.text = [data valueForKey:@"sub_wbs_element"];
     cell.contractorName.text = [data valueForKey:@"contractor_name"];
    
     NSInteger issuetag =  [[data valueForKey:@"id"] integerValue];
    
    cell.issuebtn.tag=issuetag;
    [cell.issuebtn addTarget:self action:@selector(issuebtn:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
-(void)issuebtn:(UIButton*)sender
{
    issueid = sender.tag;
    
    Contractor_IssueDetail_ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Contractor_IssueDetail_ViewController"];
    vc.issueID = issueid;
    // NSLog(@"%d",vc.issueID);
    [self.navigationController pushViewController:vc animated:YES];
    // [self segueIdentifierReceivedFromParent:@"buttonIssueDetail"];
    
    
}
-(IBAction)AddNewissuebtn:(id)sender
{
    ContractorIssue_ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ContractorIssue_ViewController"];
     [self.navigationController pushViewController:vc animated:YES];
 //   [self segueIdentifierReceivedFromParent:@"buttonIssue"];
    
}
//-(void)segueIdentifierReceivedFromParent:(NSString*)button{
//    
//    
//    if ([button  isEqual: @"buttonIssue"]){
//        
//        
//        self.segueIdentifier = @"issue";
//        [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
//    }
//    
////    if ([button  isEqual: @"buttonIssueDetail"]){
////        
////        
////        self.segueIdentifier = @"issuedetail";
////        [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
////    }
//}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"issue"])
//    {
//        UIViewController  *lastViewController, *vc;
//        //  vc = [[UIViewController alloc]init];
//        // Make sure your segue name in storyboard is the same as this line
//        
//        if ([[segue identifier] isEqual: self.segueIdentifier]){
//            if(lastViewController != nil){
//                [lastViewController.view removeFromSuperview];
//                
//                
//            }
//            
//            
//            // Get reference to the destination view controller
//            vc = (UIViewController *)[segue destinationViewController];
//            [self addChildViewController:(vc)];
//            
//            
//            vc. view.frame  = CGRectMake(0,0, self.view.frame.size.width , self.view.frame.size.height);
//            
//            [self.view addSubview:vc.view];
//            lastViewController = vc;
//            // Pass any objects to the view controller here, like...
//            
//        }
//
//    }
//else
//    {
//    UIViewController  *lastViewController, *vc;
//    //  vc = [[UIViewController alloc]init];
//    // Make sure your segue name in storyboard is the same as this line
//    
//    
//    if ([[segue identifier] isEqual: self.segueIdentifier]){
//        if(lastViewController != nil){
//            [lastViewController.view removeFromSuperview];
//            
//            
//        }
//        
//        
//        // Get reference to the destination view controller
//        Contractor_IssueDetail_ViewController *vc = (Contractor_IssueDetail_ViewController *)[segue destinationViewController];
//        
//        vc.issueID = issueid;
//        NSLog(@"%d",vc.issueID);
//        [self addChildViewController:(vc)];
//        
//        
//        vc. view.frame  = CGRectMake(0,0, self.view.frame.size.width , self.view.frame.size.height);
//        
//        [self.view addSubview:vc.view];
//        lastViewController = vc;
//        // Pass any objects to the view controller here, like...
//        
//    }
//}
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"section%d",section);
    return [[self.data objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSLog(@"header:%d",section);

    return [self.headers objectAtIndex:section];
}


@end

