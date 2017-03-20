//
//  UpdateProfile_Employee_ViewController.m
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/9/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import "UpdateProfile_Employee_ViewController.h"
#import "KOPopupView.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"
#import "AppMethod.h"
#import "Constant.h"
#import "UIView+Toast.h"
@interface UpdateProfile_Employee_ViewController ()
{
    NSMutableDictionary *setdic;
    NSString *name,*email,*mobile,*email_news;
}
//Update Profile
@property (nonatomic, strong) KOPopupView *popup;
@property (weak, nonatomic) IBOutlet KOPopupView *popupUpdateProfile;
@property (weak, nonatomic) IBOutlet UIButton *submit_updateProfile;
@property (weak, nonatomic) IBOutlet UIButton *cancle_updateProfile;
@property (weak, nonatomic) IBOutlet UITextField *txtName_updateProfile;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail_updateProfile;
@property (weak, nonatomic) IBOutlet UITextField *txtMobile_updateProfile;
@end

@implementation UpdateProfile_Employee_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _popupUpdateProfile.hidden = NO;
    _popupUpdateProfile.layer.masksToBounds = NO;
    // _popupView.layer.cornerRadius = 8;
    _popupUpdateProfile.layer.shadowColor = [[UIColor blackColor] CGColor];
    _popupUpdateProfile.layer.shadowOffset = CGSizeMake(2, 2);
    _popupUpdateProfile.layer.shadowRadius = 5;
    _popupUpdateProfile.layer.shadowOpacity = 0.8;
    
        if(!self.popup)
            self.popup = [KOPopupView popupView];
        [self.popup.handleView addSubview:self.popupUpdateProfile];
        self.popupUpdateProfile.center = CGPointMake(self.popup.handleView.frame.size.width/2.0,self.popup.handleView.frame.size.height/2.0);
        [self.popup show];
    
    
    
    _txtName_updateProfile.text = [AppMethod getStringDefault:DEF_USERNAME];
    _txtEmail_updateProfile.text = [AppMethod getStringDefault:DEF_EMAIL];
    _txtMobile_updateProfile.text = [AppMethod getStringDefault:DEF_MOBILE];
    
    
}

-(void)placeHolder_text
{
    UIColor *color = [UIColor lightGrayColor];
    _txtName_updateProfile.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Enter Name" attributes:@{
                                                                            NSForegroundColorAttributeName: color,
                                                                            NSFontAttributeName : [UIFont fontWithName:@"Raleway" size:15.0]
                                                                            }
     ];
    _txtEmail_updateProfile.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Email ID" attributes:@{
                                                                                                         NSForegroundColorAttributeName: color,
                                                                                                         NSFontAttributeName : [UIFont fontWithName:@"Raleway" size:15.0]
                                                                                                         }
                                      ];
    _txtMobile_updateProfile.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Mobile Number" attributes:@{
                                                                                                                NSForegroundColorAttributeName: color,
                                                                                                                NSFontAttributeName : [UIFont fontWithName:@"Raleway" size:15.0]
                                                                                                                }
                                       ];
    
    
    
}


- (IBAction)submit_updateProfile:(id)sender
{
    name = _txtName_updateProfile.text;
    email = _txtEmail_updateProfile.text;
    mobile = _txtMobile_updateProfile.text;
    
    if ([[name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Name should not be blank!"];
    }
    else if ([[email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Email should not be blank!"];
    }
       else if ([[mobile stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Mobile should not be blank!"];
    }
    else if (![AppMethod stringMatchedREGEX:mobile :REGEX_MOBILE_EXPRESS])
    {
        [self.view makeToast:@"Invalid Mobile!"];
    }
    else
    {
    setdic = [[NSMutableDictionary alloc]init];
    [setdic setObject:name forKey:@"name"];
    [setdic setObject:email forKey:@"email_id"];
    [setdic setObject:mobile forKey:@"mobile"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[AppMethod getStringDefault:DEF_USER_TOKEN] forHTTPHeaderField:@"User-Token"];
    [ProgressHUD show:@"Please wait..."];
    
    
    [manager POST:[BASE_URL stringByAppendingString:URL_EMPLOYEE_UPDATE_PROFILE] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic12)
     {
         BOOL boolean = [[dic12 valueForKey:@"status"]boolValue];
         
         NSDictionary *employeeData = [dic12 valueForKey:@"data"];
         if (boolean)
         {
             [AppMethod setStringDefault:DEF_USERNAME :[employeeData valueForKey:@"name"]];
             [AppMethod setStringDefault:DEF_EMAIL :[employeeData valueForKey:@"email_id"]];
             [AppMethod setStringDefault:DEF_MOBILE :[employeeData valueForKey:@"mobile"]];
               [AppMethod setStringDefault:DEF_USER_TOKEN :[employeeData valueForKey:@"user_token"]];
             
             [self.popup hideAnimated:YES];
              [self.navigationController popViewControllerAnimated:YES];
             UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"MSETCL" message:@"Update Employee Profile SuccesFully" delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
             [al show];
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
- (IBAction)cancle_updateProfile:(id)sender
{
    [self.popup hideAnimated:YES];
     [self.navigationController popViewControllerAnimated:YES];
}


@end
