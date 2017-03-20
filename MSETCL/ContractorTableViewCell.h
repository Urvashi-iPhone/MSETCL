//
//  ContractorTableViewCell.h
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/7/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContractorTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *txtIssueFieldType;

@property (weak, nonatomic) IBOutlet UILabel *txtQue_Contactor;
@property (weak, nonatomic) IBOutlet UITextView *txtAns_Contractor;

//Issue
@property (weak, nonatomic) IBOutlet UILabel *issueName;
@property (weak, nonatomic) IBOutlet UILabel *issueNumber;
@property (weak, nonatomic) IBOutlet UITextView *billName_Number_UserName;


@property (weak, nonatomic) IBOutlet UILabel *sapid;
@property (weak, nonatomic) IBOutlet UILabel *projectname;
@property (weak, nonatomic) IBOutlet UILabel *WBSelement;
@property (weak, nonatomic) IBOutlet UILabel *subWBSelement;
@property (weak, nonatomic) IBOutlet UILabel *contractorName;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *issuebtn;

@property (weak, nonatomic) IBOutlet UILabel *contractorIssueType;
@property (weak, nonatomic) IBOutlet UILabel *issueStatus;
@property (weak, nonatomic) IBOutlet UILabel *issue_date;
@property (weak, nonatomic) IBOutlet UIButton *issue_progress;

@property (weak, nonatomic) IBOutlet UILabel *issue_id;
@property (weak, nonatomic) IBOutlet UILabel *issue_time;
@property (weak, nonatomic) IBOutlet UILabel *issue_val;
@property (weak, nonatomic) IBOutlet UILabel *issue_employee;
@property (weak, nonatomic) IBOutlet UIView *issue_view;


@end
