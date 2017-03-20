//
//  Contractor_Issue_Stage_ViewController.m
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/16/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import "Contractor_Issue_Stage_ViewController.h"
#import <AFNetworking.h>
#import "Constant.h"
#import "ProgressHUD.h"
#import "AppMethod.h"
#import "STCollapseTableView.h"
#import "KOPopupView.h"
#import <IQTextView.h>
#import "UIView+Toast.h"
#import "ContractorTableViewCell.h"
#import "Contractor_IssueDetail_ViewController.h"
@interface Contractor_Issue_Stage_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary *responseDic;
    NSArray *issueDetailList;
}
-(void)segueIdentifierReceivedFromParent:(NSString*)button;
@property NSString *segueIdentifier;

@property (weak, nonatomic) IBOutlet STCollapseTableView *tableview;
@property (nonatomic, strong) NSMutableArray* data;
@property (nonatomic, strong) NSMutableArray* headers;

@end

@implementation Contractor_Issue_Stage_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"stage:%@",_stage);
    NSError *jsonError;
    NSData *objectData = [_stage dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    issueDetailList = [json allValues];
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [self setupViewController];
    [self.tableview reloadData];
    [self.tableview openSection:0 animated:NO];
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
    
    ContractorTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
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
    cell.issue_employee.text = [data valueForKey:@"employee"];
    
   
    
    if ([[data valueForKey:@"is_current_stage"] integerValue] == 1)
    {
        cell.issue_view.layer.backgroundColor = [[UIColor colorWithRed:199.0f/255.0f green:24.0f/255.0f blue:24.0f/255.0f alpha:1.0f] CGColor];
        
    }
    else
    {
         cell.issue_view.layer.backgroundColor = [[UIColor colorWithRed:52.0f/255.0f green:47.0f/255.0f blue:47.0f/255.0f alpha:1.0f] CGColor];
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

- (IBAction)back:(id)sender
{
   
   [self.navigationController popViewControllerAnimated:YES];
    _tableview.delegate = nil;
}

@end
