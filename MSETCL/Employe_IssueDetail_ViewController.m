//
//  Employe_IssueDetail_ViewController.m
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/15/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import "Employe_IssueDetail_ViewController.h"
#import "Employee_TableViewCell.h"
#import <AFNetworking.h>
#import "Constant.h"
#import "ProgressHUD.h"
#import "AppMethod.h"
#import "STCollapseTableView.h"
#import "KOPopupView.h"
#import <IQTextView.h>
#import "UIView+Toast.h"
@interface Employe_IssueDetail_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary *responseDic;
    NSArray *issueDetailList;
}
@property (weak, nonatomic) IBOutlet UIButton *r2;
@property (weak, nonatomic) IBOutlet UIButton *r1;

@property (weak, nonatomic) IBOutlet UIButton *proceedIssue;
@property (weak, nonatomic) IBOutlet STCollapseTableView *tableview;
@property (nonatomic, strong) NSMutableArray* data;
@property (nonatomic, strong) NSMutableArray* headers;

@property (weak, nonatomic) IBOutlet IQTextView *txtReason;
@property (nonatomic, strong) KOPopupView *popup;
@property (weak, nonatomic) IBOutlet KOPopupView *popupView;

@end

@implementation Employe_IssueDetail_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
    NSLog(@"issue ID:%d",_issueId);
    
    //string to dictionary
    
    NSError *jsonError;
    NSData *objectData = [_stage dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
     issueDetailList = [json allValues];
    
    
    
    [self setupViewController];
    [self.tableview reloadData];
    [self.tableview openSection:0 animated:NO];
    
//    NSArray *jsonKeys = [json allKeys];
//    for (int i = 0; i<[jsonKeys count]; i++) {
//        [issueDetailList addObject:[json valueForKey:[jsonKeys objectAtIndex:i]]];
//       
//    }
    
    NSLog(@"issuedetaillist%@",issueDetailList);
    _popupView.hidden = YES;
    _popupView.layer.masksToBounds = NO;
    _popupView.layer.shadowColor = [[UIColor blackColor] CGColor];
    _popupView.layer.shadowOffset = CGSizeMake(2, 2);
    _popupView.layer.shadowRadius = 5;
    _popupView.layer.shadowOpacity = 0.8;
    
    _txtReason.layer.borderColor= [[UIColor grayColor] CGColor];
    _txtReason.layer.borderWidth = 1.0f;
    _txtReason.layer.cornerRadius = 5.0f;
    
    
}

-(void)proccedIssueDetail:(NSString*)current_stage_id:(int)issue_id
{
    NSString *reason = _txtReason.text;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[AppMethod getStringDefault:DEF_USER_TOKEN] forHTTPHeaderField:@"User-Token"];
    [ProgressHUD show:@"Please wait..."];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setObject:current_stage_id forKey:@"current_stage_id"];
    [param setObject:[NSString stringWithFormat:@"%d",issue_id] forKey:@"issue_id"];
    if ([_r1 isSelected])
    {
        [param setObject:@"hold" forKey:@"type"];
        [param setObject:reason forKey:@"hold_reason"];
    }
    else
    {
        [param setObject:@"forward" forKey:@"type"];
        [param setObject:reason forKey:@"forward_reason"];
    }
    
    [manager POST:[BASE_URL stringByAppendingString:URL_EMPLOYEE_PROCEED_ASSIGN_ISSUE] parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        responseDic = responseObject;
        
        [self.view makeToast:[responseDic valueForKey:@"message"]];
        
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
    
    for (int i=0; i<[issueDetailList count]; i++)
    {
        NSString *stagedata = [NSString stringWithFormat:@"Total Time : %@",[[issueDetailList objectAtIndex:i] valueForKey:@"total_time"]];
        [title addObject:stagedata];
        
    }
    
    _data = [[NSMutableArray alloc] init];
    
   
     for (int i = 0 ; i < [title count] ; i++)
    {
        NSMutableArray* section = [[NSMutableArray alloc] init];
        
        for (int j = 0 ; j < [[[issueDetailList objectAtIndex:i]valueForKey:@"stage_data"] count] ; j++)
        {
            [section addObject:[[[issueDetailList objectAtIndex:i]valueForKey:@"stage_data"] objectAtIndex:j]];
        }

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
        
        header.backgroundColor = [UIColor colorWithRed:52.0f/255.0f green:46.0f/255.0f blue:46.0f/255.0f alpha:1.0];
        view.backgroundColor = [UIColor colorWithRed:52.0f/255.0f green:46.0f/255.0f blue:46.0f/255.0f alpha:1.0];

        
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"section%d",section);
    return [[self.data objectAtIndex:section] count];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"Cell";
    
    Employee_TableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.issue_view.layer.cornerRadius = 10.0f;
    cell.issue_view.layer.borderColor = [[UIColor whiteColor] CGColor];
    cell.layer.borderColor = [[UIColor whiteColor] CGColor];
    cell.layer.cornerRadius = 10.0f;
    cell.layer.borderWidth = 3.0f;

    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    
    NSMutableArray* data = [[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.issue_id.text = [data valueForKey:@"id"];
    cell.issue_time.text = [data valueForKey:@"time"];
    cell.issue_val.text = [data valueForKey:@"val"];
    cell.issue_emp.text = [data valueForKey:@"employee"];
    
    cell.issue_view.layer.backgroundColor = [[UIColor colorWithRed:52.0f/255.0f green:47.0f/255.0f blue:47.0f/255.0f alpha:1.0f] CGColor];
    
    if ([[data valueForKey:@"is_current_stage"] integerValue] == 1)
    {
        cell.issue_view.layer.backgroundColor = [[UIColor colorWithRed:199.0f/255.0f green:24.0f/255.0f blue:24.0f/255.0f alpha:1.0f] CGColor];
        
        _proceedIssue.hidden = NO;
        
    }
    else
    {
        cell.issue_view.layer.backgroundColor = [[UIColor colorWithRed:52.0f/255.0f green:47.0f/255.0f blue:47.0f/255.0f alpha:1.0f] CGColor];
        _proceedIssue.hidden = YES;
    }

    
    return cell;
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
- (IBAction)proceed_issue:(id)sender
{
    
    NSString *current_stage_id = @"";
    
    for (int i = 0; i < [issueDetailList count]; i++)
    {
        for (int j = 0; j < [[[issueDetailList objectAtIndex:i] valueForKey:@"stage_data"] count]; j++)
        {
            NSString *assignUser = [[[[issueDetailList objectAtIndex:i] valueForKey:@"stage_data"] valueForKey:@"assign_user"] objectAtIndex:j];
            
            NSString *sapID = [AppMethod getStringDefault:DEF_SAP_ID];
            
            if ([assignUser isEqualToString:sapID])
            {
                NSLog(@"value:%@",[[[issueDetailList objectAtIndex:i] valueForKey:@"stage_data"] valueForKey:@"id"] );
                
                current_stage_id = [[[[issueDetailList objectAtIndex:i] valueForKey:@"stage_data"] valueForKey:@"id"] objectAtIndex:j];
                break;
            }
        }
    }
    if (![current_stage_id isEqualToString:@""])
    {
        _popupView.hidden = NO;
        
        if(!self.popup)
            self.popup = [KOPopupView popupView];
        [self.popup.handleView addSubview:self.popupView];
        self.popupView.center = CGPointMake(self.popup.handleView.frame.size.width/2.0,self.popup.handleView.frame.size.height/2.0);
        [self.popup show];
        
    }
 

}
- (IBAction)submitIssue:(id)sender
{
   [self.popup hideAnimated:YES];
    NSString *current_stage_id = @"";
    
    for (int i = 0; i < [issueDetailList count]; i++)
    {
        for (int j = 0; j < [[[issueDetailList objectAtIndex:i] valueForKey:@"stage_data"] count]; j++)
        {
            NSString *assignUser = [[[[issueDetailList objectAtIndex:i] valueForKey:@"stage_data"] valueForKey:@"assign_user"] objectAtIndex:j];
            
            NSString *sapID = [AppMethod getStringDefault:DEF_SAP_ID];
            
            if ([assignUser isEqualToString:sapID])
            {
                NSLog(@"value:%@",[[[issueDetailList objectAtIndex:i] valueForKey:@"stage_data"] valueForKey:@"id"] );
                
                current_stage_id = [[[[issueDetailList objectAtIndex:i] valueForKey:@"stage_data"] valueForKey:@"id"] objectAtIndex:j];
                break;
            }
        }
    }
    if (![current_stage_id isEqualToString:@""])
    {
        [self proccedIssueDetail:current_stage_id :_issueId];
        
    }
    
}
- (IBAction)cancleIssue:(id)sender
{
    [self.popup hideAnimated:YES];
}
//Radio Button

-(void)radiobuttonSelected:(id)sender
{
    switch ([sender tag])
    {
        case 0:
            if([_r1 isSelected]==YES)
            {
                [_r1 setSelected:NO];
                [_r2 setSelected:YES];
            }
            else{
                [_r1 setSelected:YES];
                [_r2 setSelected:NO];
            }
            
            break;
        case 1:
            if([_r2 isSelected]==YES)
            {
                [_r2 setSelected:NO];
                [_r1 setSelected:YES];
            }
            else{
                [_r2 setSelected:YES];
                [_r1 setSelected:NO];
            }
            
            break;
            
        default:
            break;
    }
    
}
-(void)viewDidAppear:(BOOL)animated

{
    
    [_r1 setTag:0];
    [_r1 setBackgroundImage:[UIImage imageNamed:@"radio.png"] forState:UIControlStateNormal];
    [_r1 setBackgroundImage:[UIImage imageNamed:@"radio-checked.png"] forState:UIControlStateSelected];
    [_r1 addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    [_r2 setTag:1];
    [_r2 setBackgroundImage:[UIImage imageNamed:@"radio.png"] forState:UIControlStateNormal];
    [_r2 setBackgroundImage:[UIImage imageNamed:@"radio-checked.png"] forState:UIControlStateSelected];
    [_r2 addTarget:self action:@selector(radiobuttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (IBAction)backbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    _tableview.delegate =nil;
}

@end
