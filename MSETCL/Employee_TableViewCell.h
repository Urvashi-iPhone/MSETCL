//
//  Employee_TableViewCell.h
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/8/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Employee_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *txtQue_Employee;
@property (weak, nonatomic) IBOutlet UITextView *txtAns_Employee;

@property (weak, nonatomic) IBOutlet UILabel *prjName;
@property (weak, nonatomic) IBOutlet UITextView *issueType;
@property (weak, nonatomic) IBOutlet UILabel *startedTime;
@property (weak, nonatomic) IBOutlet UILabel *quantityRs;
@property (weak, nonatomic) IBOutlet UILabel *QuantityPer;
@property (weak, nonatomic) IBOutlet UILabel *tenderAuth;
@property (weak, nonatomic) IBOutlet UILabel *isAssign;
@property (weak, nonatomic) IBOutlet UILabel *queRslbl;
@property (weak, nonatomic) IBOutlet UILabel *issue_id;
@property (weak, nonatomic) IBOutlet UILabel *issue_time;
@property (weak, nonatomic) IBOutlet UILabel *issue_val;
@property (weak, nonatomic) IBOutlet UILabel *issue_emp;
@property (weak, nonatomic) IBOutlet UIView *issue_view;

@end
