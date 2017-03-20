//
//  LoginViewController.m
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/4/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import "LoginViewController.h"
#import "Contractor_ViewController.h"
#import "SignUp_Contractor.h"
#import "SignUp_Employee.h"
#import "RPFloatingPlaceholderTextField.h"
#import "RPFloatingPlaceholderTextView.h"
#import "KOPopupView.h"
#import "UIView+Toast.h"
#import "Constant.h"
#import "AppMethod.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"
#import "SWRevealViewController.h"
#import "Employee_ViewController.h"

@interface LoginViewController ()
{
    NSString *uname,*pass,*r1,*r2;
    NSMutableDictionary *setdic;
}
@property (weak, nonatomic) IBOutlet UIButton *loginbtn;
@property (weak, nonatomic) IBOutlet UITextField *txt_uid;
@property (weak, nonatomic) IBOutlet UITextField *txtpass;
@property (weak, nonatomic) IBOutlet UIButton *signupbtn;
@property (nonatomic, strong) KOPopupView *popup;
@property (weak, nonatomic) IBOutlet KOPopupView *popupView;
@property (weak, nonatomic) IBOutlet UIButton *submit_forgot;
@property (weak, nonatomic) IBOutlet UIButton *cancle_forgot;
@property (weak, nonatomic) IBOutlet UIButton *passShowBtn;

@property (weak, nonatomic) IBOutlet UIButton *r1;
@property (weak, nonatomic) IBOutlet UIButton *r2;
@property (weak, nonatomic) IBOutlet UITextField *txtemail;

-(void)radiobuttonSelected:(id)sender;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        [self.navigationController.view removeGestureRecognizer:self.navigationController.interactivePopGestureRecognizer];
    self.navigationController.navigationBar.hidden =YES;
    
  //  _loginbtn.layer.cornerRadius = _loginbtn.frame.size.height/2;
 //    _signupbtn.layer.cornerRadius = _signupbtn.frame.size.height/2;
//    _submit_forgot.layer.cornerRadius = _submit_forgot.frame.size.height/2;
//    _cancle_forgot.layer.cornerRadius = _cancle_forgot.frame.size.height/2;
//    
    _loginbtn.layer.borderColor = [[UIColor whiteColor] CGColor];
    _loginbtn.layer.borderWidth = 2.0f;
    
    _popupView.hidden = YES;
    _popupView.layer.masksToBounds = NO;
    // _popupView.layer.cornerRadius = 8;
    _popupView.layer.shadowColor = [[UIColor blackColor] CGColor];
    _popupView.layer.shadowOffset = CGSizeMake(2, 2);
    _popupView.layer.shadowRadius = 5;
    _popupView.layer.shadowOpacity = 0.8;
    
    self.txtpass.rightView = _passShowBtn;
    self.txtpass.rightViewMode = UITextFieldViewModeAlways;
 
    [self placeHolder_text];
  }

-(void)placeHolder_text
{
    UIColor *color = [UIColor whiteColor];
    UIColor *coloremail = [UIColor lightGrayColor];
    _txt_uid.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Enter Sap ID" attributes:@{
                                                                            NSForegroundColorAttributeName: color,
                                                                            NSFontAttributeName : [UIFont fontWithName:@"Raleway" size:15.0]
                                                                            }
     ];
    _txtpass.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{
                                                                                                         NSForegroundColorAttributeName: color,
                                                                                                         NSFontAttributeName : [UIFont fontWithName:@"Raleway" size:15.0]
                                                                                                         }
                                      ];
    _txtemail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Email ID" attributes:@{
                                                                                                         NSForegroundColorAttributeName: coloremail,
                                                                                                         NSFontAttributeName : [UIFont fontWithName:@"Raleway" size:15.0]
                                                                                                         }
                                      ];

    
 
}
- (IBAction)passShowBtn:(id)sender
{
    if (!self.txtpass.secureTextEntry)
    {
        self.txtpass.secureTextEntry = YES;
        [_passShowBtn setImage:[UIImage imageNamed:@"open_eye.png"] forState:UIControlStateNormal];
    }
    else
    {
        self.txtpass.secureTextEntry = NO;
        [_passShowBtn setImage:[UIImage imageNamed:@"close_eye.png"] forState:UIControlStateNormal];
    }
    [self.txtpass becomeFirstResponder];
}

- (IBAction)loginbtn:(id)sender
{
    uname = _txt_uid.text;
    pass = _txtpass.text;
 

    if ([[uname stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"SAP ID should not be blank!"];
    }
    else if (uname.length != 5)
    {
        [self.view makeToast:@"SAP ID should must have 5 digit!"];
    }
    else if ([[pass stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
         [self.view makeToast:@"Password should not be blank!"];
    }
    else
    {

        setdic = [[NSMutableDictionary alloc]init];
        [setdic setObject:uname forKey:@"email"];
        [setdic setObject:pass forKey:@"password"];
        [setdic setObject:@"deviceToken" forKey:@"device_token"];
        [setdic setObject:@"abc" forKey:@"device_id"];
        [setdic setObject:@"ios" forKey:@"device_type"];
    
       
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [ProgressHUD show:@"Please wait..."];
    
    if ([_r1 isSelected]==YES)
    {
        [manager POST:[BASE_URL stringByAppendingString:URL_EMPLOYEE_LOGIN] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic12)
         {
             BOOL boolean = [[dic12 valueForKey:@"status"]boolValue];
             
             if (boolean)
             {
                 SWRevealViewController *tab = [self.storyboard instantiateViewControllerWithIdentifier:@"Employee_SWRevealViewController"];
                 [AppMethod setBoolDefault:DEF_IS_LOGIN :YES];
    
                 [self storeEmployeeDataAndGotoNextActivity:[dic12 valueForKey:@"data"]];
                 [self.navigationController pushViewController:tab animated:YES];
             }
             else
             {
                 UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[dic12 valueForKey:@"message"] delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
                 [al show];
             }
             [ProgressHUD dismiss];
             
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
             [al show];
             [ProgressHUD dismiss];
         }];

    }
    else
    {
        [manager POST:[BASE_URL stringByAppendingString:URL_CONTRACTOR_LOGIN] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic12)
         {
             BOOL boolean = [[dic12 valueForKey:@"status"]boolValue];
             
             if (boolean)
             {
                 SWRevealViewController *tab = [self.storyboard instantiateViewControllerWithIdentifier:@"Contractor_SWRevealViewController"];
                 
               
                  [AppMethod setBoolDefault:DEF_IS_LOGIN :YES];
                 [self storeContractorDataAndGotoNextActivity:[dic12 valueForKey:@"data"]];
                 [self.navigationController pushViewController:tab animated:YES];
             }
             else
             {
                 UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[dic12 valueForKey:@"message"] delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
                 [al show];
             }
             [ProgressHUD dismiss];
             
         } failure:^(NSURLSessionTask *operation, NSError *error) {
             UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
             [al show];
             [ProgressHUD dismiss];
         }];
 
    }
  }
}
-(void)storeEmployeeDataAndGotoNextActivity:(NSDictionary*)employeeData
{
    NSLog(@"data:%@",[employeeData valueForKey:@"sap_id"]);
    
    [AppMethod setStringDefault:DEF_SAP_ID :[employeeData valueForKey:@"sap_id"]];
    [AppMethod setIntegerDefault:DEF_ID :[employeeData valueForKey:@"id"]];
    [AppMethod setIntegerDefault:DEF_USER_TYPE :0];
    [AppMethod setStringDefault:DEF_USER_TOKEN :[employeeData valueForKey:@"user_token"]];
    [AppMethod setStringDefault:DEF_PASSWORD :_txtpass.text];
    
    [AppMethod setStringDefault:DEF_USERNAME :[employeeData valueForKey:@"name"]];
    [AppMethod setStringDefault:DEF_EMAIL :[employeeData valueForKey:@"email_id"]];
    [AppMethod setStringDefault:DEF_MOBILE :[employeeData valueForKey:@"mobile"]];
    
}

-(void)storeContractorDataAndGotoNextActivity:(NSDictionary*)contractorData
{
    [AppMethod setStringDefault:DEF_SAP_ID :[contractorData valueForKey:@"contractor_sap_id"]];
    [AppMethod setIntegerDefault:DEF_ID :[contractorData valueForKey:@"id"]];
    [AppMethod setIntegerDefault:DEF_USER_TYPE :1];
    [AppMethod setStringDefault:DEF_USER_TOKEN :[contractorData valueForKey:@"user_token"]];
    [AppMethod setStringDefault:DEF_PASSWORD :_txtpass.text];
    [AppMethod setStringDefault:DEF_USERNAME :[contractorData valueForKey:@"contact_name"]];
    [AppMethod setStringDefault:DEF_EMAIL :[contractorData valueForKey:@"contact_email"]];
    [AppMethod setStringDefault:DEF_AGENCI_NAME :[contractorData valueForKey:@"agencies_name"]];
    [AppMethod setStringDefault:DEF_ADDRESS :[contractorData valueForKey:@"address"]];
    [AppMethod setStringDefault:DEF_PINCODE :[contractorData valueForKey:@"pincode"]];
    [AppMethod setStringDefault:DEF_MOBILE :[contractorData valueForKey:@"contact_mobile"]];

}

- (IBAction)signupbtn:(id)sender
{
    if ([_r1 isSelected]==YES)
    {
        [self.view makeToast:@"Only Contractor Register Valid"];

    }
    else if ([_r2 isSelected]==YES)
    {
        SignUp_Contractor *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUp_Contractor"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
         [self.view makeToast:@"Select User Type!"];
    }
}
- (IBAction)forgotpassbtn:(id)sender
{
    _popupView.hidden = NO;
    if(!self.popup)
        self.popup = [KOPopupView popupView];
    [self.popup.handleView addSubview:self.popupView];
    self.popupView.center = CGPointMake(self.popup.handleView.frame.size.width/2.0,self.popup.handleView.frame.size.height/2.0);
    [self.popup show];
    // [self.popup hideAnimated:YES];
}
- (IBAction)submit_forgot:(id)sender
{
    [self.popup hideAnimated:YES];
}
- (IBAction)cancle_forgot:(id)sender
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


@end
