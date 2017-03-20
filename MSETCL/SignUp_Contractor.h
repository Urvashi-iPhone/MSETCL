//
//  SignUpViewController.h
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/4/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IQTextView.h>
#import <TPSSquareDropDown.h>
@interface SignUp_Contractor : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrlView;
@property (weak, nonatomic) IBOutlet UIButton *submitbtn;

@property (weak, nonatomic) IBOutlet UITextField *txtSapId;
@property (weak, nonatomic) IBOutlet UITextField *txtPass;
@property (weak, nonatomic) IBOutlet UITextField *txtAgenciName;
@property (weak, nonatomic) IBOutlet UITextField *txtContactName;
@property (weak, nonatomic) IBOutlet UITextField *txtContactEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtContactMobile;
@property (weak, nonatomic) IBOutlet IQTextView *txtAddress;
@property (weak, nonatomic) IBOutlet TPSSquareDropDown *txtState;
@property (weak, nonatomic) IBOutlet TPSSquareDropDown *txtDistric;
@property (weak, nonatomic) IBOutlet TPSSquareDropDown *txtCity;
@property (weak, nonatomic) IBOutlet UITextField *txtPincode;










@end
