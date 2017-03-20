//
//  SignUp_Employee.h
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/6/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IQTextView.h>
#import <TPSSquareDropDown.h>
@interface SignUp_Employee : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrlView;

@property (weak, nonatomic) IBOutlet UIButton *submitbtn;

@property (weak, nonatomic) IBOutlet UITextField *txtSapId;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPass;
@property (weak, nonatomic) IBOutlet UITextField *txtMobile;
@property (weak, nonatomic) IBOutlet TPSSquareDropDown *txtDesignation;
@property (weak, nonatomic) IBOutlet IQTextView *txtAddress;
@property (weak, nonatomic) IBOutlet TPSSquareDropDown *txtZone;
@property (weak, nonatomic) IBOutlet TPSSquareDropDown *txtCircle;
@property (weak, nonatomic) IBOutlet TPSSquareDropDown *txtDivision;
@property (weak, nonatomic) IBOutlet TPSSquareDropDown *txtSubDivision;
@property (weak, nonatomic) IBOutlet TPSSquareDropDown *txtStatus;
@end
