//
//  MenuViewController.m
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/7/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import "Contractor_Menu_ViewController.h"
#import "KOPopupView.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"
#import "AppMethod.h"
#import "Constant.h"
#import <IQTextView.h>
#import "Contractor_FAQs_ViewController.h"
#import "SWRevealViewController.h"
#import "Contractor_GetIssue_ViewController.h"
#import "LoginViewController.h"
#import "Contractor_ViewController.h"
#import "DialogViewController.h"
#import "UIView+Toast.h"
#import "Contractor_FAQs_ViewController.h"

@interface Contractor_Menu_ViewController ()
{
    NSString *oldPass,*newPass;
    NSMutableDictionary *setdic;
    
    NSString *contactName,*contactEmail,*agenciesName,*address,*pincode,*contactMobile;
    NSString *email;
}

//Change Password
@property (nonatomic, strong) KOPopupView *popup;
@property (weak, nonatomic) IBOutlet KOPopupView *popupView;
@property (weak, nonatomic) IBOutlet UITextField *txtOldPass;
@property (weak, nonatomic) IBOutlet UITextField *txtNewPass;
@property (weak, nonatomic) IBOutlet UIButton *canclebtn;
@property (weak, nonatomic) IBOutlet UIButton *submitbtn;

////Update Profile
//@property (weak, nonatomic) IBOutlet KOPopupView *popupUpdateProfile;
//@property (weak, nonatomic) IBOutlet UIButton *submit_updateProfile;
//@property (weak, nonatomic) IBOutlet UIButton *cancle_updateProfile;
//@property (weak, nonatomic) IBOutlet UITextField *contactName_updateProfile;
//@property (weak, nonatomic) IBOutlet UITextField *contactEmail_updateProfile;
//@property (weak, nonatomic) IBOutlet UITextField *agenciesName_updateProfile;
//@property (weak, nonatomic) IBOutlet IQTextView *address_updateProfile;
//@property (weak, nonatomic) IBOutlet UITextField *pincode_updateProfile;
//@property (weak, nonatomic) IBOutlet UITextField *contactMobile_updateProfile;

//News Letter
@property (weak, nonatomic) IBOutlet KOPopupView *popup_newsLetter;
@property (weak, nonatomic) IBOutlet UIButton *submit_newsLetter;
@property (weak, nonatomic) IBOutlet UIButton *cancle_newsLetter;
@property (weak, nonatomic) IBOutlet UITextField *email_newsLetter;
@property (weak, nonatomic) IBOutlet UIImageView *l1;
@property (weak, nonatomic) IBOutlet UIImageView *l2;

//Logout
@property (weak, nonatomic) IBOutlet KOPopupView *popup_logout;
@property (weak, nonatomic) IBOutlet UIButton *yes_logout;
@property (weak, nonatomic) IBOutlet UIButton *no_logout;
//password
@property (weak, nonatomic) IBOutlet UIButton *passShowBtn1;
@property (weak, nonatomic) IBOutlet UIButton *passShowBtn2;

@end

@implementation Contractor_Menu_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self placeHolder_text];
    
    //Change Password
    _popupView.hidden = YES;
    _popupView.layer.masksToBounds = NO;
    // _popupView.layer.cornerRadius = 8;
    _popupView.layer.shadowColor = [[UIColor blackColor] CGColor];
    _popupView.layer.shadowOffset = CGSizeMake(2, 2);
    _popupView.layer.shadowRadius = 5;
    _popupView.layer.shadowOpacity = 0.8;
    
//    _submitbtn.layer.cornerRadius = _submitbtn.frame.size.height/2;
//    _canclebtn.layer.cornerRadius = _canclebtn.frame.size.height/2;
//    
    //Update Profile
//    _popupUpdateProfile.hidden = YES;
//    _popupUpdateProfile.layer.masksToBounds = NO;
//    // _popupView.layer.cornerRadius = 8;
//    _popupUpdateProfile.layer.shadowColor = [[UIColor blackColor] CGColor];
//    _popupUpdateProfile.layer.shadowOffset = CGSizeMake(2, 2);
//    _popupUpdateProfile.layer.shadowRadius = 5;
//    _popupUpdateProfile.layer.shadowOpacity = 0.8;
    
//    _submit_updateProfile.layer.cornerRadius = _submit_updateProfile.frame.size.height/2;
//    _cancle_updateProfile.layer.cornerRadius = _cancle_updateProfile.frame.size.height/2;
    
    
    //News Letter
    _popup_newsLetter.hidden = YES;
    _popup_newsLetter.layer.masksToBounds = NO;
    // _popupView.layer.cornerRadius = 8;
    _popup_newsLetter.layer.shadowColor = [[UIColor blackColor] CGColor];
    _popup_newsLetter.layer.shadowOffset = CGSizeMake(2, 2);
    _popup_newsLetter.layer.shadowRadius = 5;
    _popup_newsLetter.layer.shadowOpacity = 0.8;
    
    
    //Logout
    _popup_logout.hidden = YES;
    _popup_logout.layer.masksToBounds = NO;
    // _popupView.layer.cornerRadius = 8;
    _popup_logout.layer.shadowColor = [[UIColor blackColor] CGColor];
    _popup_logout.layer.shadowOffset = CGSizeMake(2, 2);
    _popup_logout.layer.shadowRadius = 5;
    _popup_logout.layer.shadowOpacity = 0.8;
    
//    _submit_newsLetter.layer.cornerRadius = _submit_newsLetter.frame.size.height/2;
//    _cancle_newsLetter.layer.cornerRadius = _cancle_newsLetter.frame.size.height/2;

    //Address
//    _address_updateProfile.layer.borderColor= [[UIColor lightGrayColor] CGColor];
//    _address_updateProfile.layer.borderWidth = 1.0f;
//    _address_updateProfile.layer.cornerRadius = 5.0f;

//     _l1.bounds = CGRectInset(_l1.frame, 5.0f, 5.0f);
//     _l2.bounds = CGRectInset(_l2.frame, 5.0f, 5.0f);
    
    //password
    self.txtOldPass.rightView = _passShowBtn1;
    self.txtOldPass.rightViewMode = UITextFieldViewModeAlways;

    self.txtNewPass.rightView = _passShowBtn2;
    self.txtNewPass.rightViewMode = UITextFieldViewModeAlways;
    [self placeHolder_text];
    
}
-(void)placeHolder_text
{
    UIColor *color = [UIColor lightGrayColor];
    _txtOldPass.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Enter Old Password" attributes:@{
                                                                            NSForegroundColorAttributeName: color,
                                                                            NSFontAttributeName : [UIFont fontWithName:@"Raleway" size:15.0]
                                                                            }
     ];
    _txtNewPass.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter New Password" attributes:@{
                                                                                                         NSForegroundColorAttributeName: color,
                                                                                                         NSFontAttributeName : [UIFont fontWithName:@"Raleway" size:15.0]
                                                                                                         }
                                      ];
   
    
    _email_newsLetter.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Email ID" attributes:@{
                                                                                                                      NSForegroundColorAttributeName: color,
                                                                                                                      NSFontAttributeName : [UIFont fontWithName:@"Raleway" size:15.0]
                                                                                                                      }
                                         ];
    
}


- (IBAction)passShowBtn1:(id)sender
{
    if (!self.txtOldPass.secureTextEntry)
    {
        self.txtOldPass.secureTextEntry = YES;
        [_passShowBtn1 setImage:[UIImage imageNamed:@"open_eye-2.png"] forState:UIControlStateNormal];
    }
    else
    {
        self.txtOldPass.secureTextEntry = NO;
        [_passShowBtn1 setImage:[UIImage imageNamed:@"close_eye-2.png"] forState:UIControlStateNormal];
    }
    [self.txtOldPass becomeFirstResponder];
}


- (IBAction)passShowBtn2:(id)sender
{
    if (!self.txtNewPass.secureTextEntry)
    {
        self.txtNewPass.secureTextEntry = YES;
        [_passShowBtn2 setImage:[UIImage imageNamed:@"open_eye-2.png"] forState:UIControlStateNormal];
    }
    else
    {
        self.txtNewPass.secureTextEntry = NO;
        [_passShowBtn2 setImage:[UIImage imageNamed:@"close_eye-2.png"] forState:UIControlStateNormal];
    }
    [self.txtNewPass becomeFirstResponder];
}

//
//- (IBAction)changePassword:(id)sender
//{
////    _popupView.hidden = NO;
//// //   _popupUpdateProfile.hidden = YES;
////    _popup_newsLetter.hidden = YES;
////    _popup_logout.hidden = YES;
////    
////    if(!self.popup)
////        self.popup = [KOPopupView popupView];
////    [self.popup.handleView addSubview:self.popupView];
////    self.popupView.center = CGPointMake(self.popup.handleView.frame.size.width/2.0,self.popup.handleView.frame.size.height/2.0);
////    [self.popup show];
////    // [self.popup hideAnimated:YES];
//
//}
- (IBAction)submit_ChangePass:(id)sender
{
    oldPass = _txtOldPass.text;
    newPass = _txtNewPass.text;
  
    if ([[oldPass stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Old Password should not be blank!"];
    }
    else if (oldPass.length < 6)
    {
        [self.view makeToast:@"Old Password should be atleast 6 characters!"];
        
    }
    
    else if ([[newPass stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"New Password should not be blank!"];
    }
    else if (oldPass.length < 6)
    {
        [self.view makeToast:@"New Password should be atleast 6 characters!"];
        
    }
    else
    {

     setdic = [[NSMutableDictionary alloc]init];
    [setdic setObject:oldPass forKey:@"old_password"];
    [setdic setObject:newPass forKey:@"new_password"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     [manager.requestSerializer setValue:[AppMethod getStringDefault:DEF_USER_TOKEN] forHTTPHeaderField:@"User-Token"];
    [ProgressHUD show:@"Please wait..."];
    
    
    [manager POST:[BASE_URL stringByAppendingString:URL_CHANGE_PASSWORD] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic12)
     {
         BOOL boolean = [[dic12 valueForKey:@"status"]boolValue];
         
         if (boolean)
         {
             [self.popup hideAnimated:YES];
             _txtOldPass.text = @"";
             _txtNewPass.text = @"";
             UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"MSETCL" message:@"Change Password SuccesFully" delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
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
- (IBAction)cancle_ChangePass:(id)sender
{
    _txtOldPass.text = @"";
    _txtNewPass.text = @"";
    [self.popup hideAnimated:YES];
}
//- (IBAction)updateProfile:(id)sender
//{
////    _popupUpdateProfile.hidden = NO;
////    _popup_newsLetter.hidden = YES;
////    _popupView.hidden = YES;
////    _popup_logout.hidden = YES;
////    
////    if(!self.popup)
////        self.popup = [KOPopupView popupView];
////    [self.popup.handleView addSubview:self.popupUpdateProfile];
////    self.popupUpdateProfile.center = CGPointMake(self.popup.handleView.frame.size.width/2.0,self.popup.handleView.frame.size.height/2.0);
////    [self.popup show];
//    
//    DialogViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DialogViewController"];
//    [self.navigationController pushViewController:vc animated:YES];
//
//}
//- (IBAction)newsLetter:(id)sender
//{
//    _popup_newsLetter.hidden = NO;
//    //_popupUpdateProfile.hidden = YES;
//    _popupView.hidden = YES;
//    _popup_logout.hidden = YES;
//    
//    if(!self.popup)
//        self.popup = [KOPopupView popupView];
//    [self.popup.handleView addSubview:self.popup_newsLetter];
//    self.popup_newsLetter.center = CGPointMake(self.popup.handleView.frame.size.width/2.0,self.popup.handleView.frame.size.height/2.0);
//    [self.popup show];
//
//}

- (IBAction)submit_newsLetter:(id)sender
{
    email = _email_newsLetter.text;
    
    if ([[email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Email should not be blank!"];
    }
    else if (![AppMethod stringMatchedREGEX:email :REGEX_EMAIL_EXPRESS])
    {
        [self.view makeToast:@"Invalid Email!"];
    }
    else
    {

    setdic = [[NSMutableDictionary alloc]init];
    [setdic setObject:email forKey:@"email"];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[AppMethod getStringDefault:DEF_USER_TOKEN] forHTTPHeaderField:@"User-Token"];
    [ProgressHUD show:@"Please wait..."];
    
    
    [manager POST:[BASE_URL stringByAppendingString:URL_NEWS_LETTER] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic12)
     {
         BOOL boolean = [[dic12 valueForKey:@"status"]boolValue];
         
         if (boolean)
         {
             [self.popup hideAnimated:YES];
               email = @"";
             
             UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"MSETCL" message:@"News Letter SuccesFully" delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
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
- (IBAction)cancle_newsLetter:(id)sender
{
    _email_newsLetter.text = @"";
    [self.popup hideAnimated:YES];
    
}
//- (IBAction)FAQsBtn:(id)sender
//{
//    Contractor_FAQs_ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Contractor_FAQs_ViewController"];
//    [self.navigationController pushViewController:vc animated:YES];
//}
//- (IBAction)issueBtn:(id)sender
//{
//    Contractor_GetIssue_ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Contractor_GetIssue_ViewController"];
//    [self.navigationController pushViewController:vc animated:YES];
//
//}

//- (IBAction)logout:(id)sender
//{
//    _popup_logout.hidden = NO;
//    _popup_newsLetter.hidden = YES;
//   // _popupUpdateProfile.hidden = YES;
//    _popupView.hidden = YES;
//    
//    if(!self.popup)
//        self.popup = [KOPopupView popupView];
//    [self.popup.handleView addSubview:self.popup_logout];
//    self.popup_logout.center = CGPointMake(self.popup.handleView.frame.size.width/2.0,self.popup.handleView.frame.size.height/2.0);
//    [self.popup show];
//}


- (IBAction)yes_logout:(id)sender
{
    
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer setValue:[AppMethod getStringDefault:DEF_USER_TOKEN] forHTTPHeaderField:@"User-Token"];
        [ProgressHUD show:@"Please wait..."];
        
        
        [manager GET:[BASE_URL stringByAppendingString:URL_CONTRACTOR_LOGOUT] parameters:nil progress:nil success:^(NSURLSessionTask *task, id dic12)
         {
             BOOL boolean = [[dic12 valueForKey:@"status"]boolValue];
             
             if (boolean)
             {
                 [self.popup hideAnimated:YES];

                 [AppMethod  setIntegerDefault:DEF_SAP_ID :-1];
                 [AppMethod setIntegerDefault:DEF_ID :-1];
                 [AppMethod setStringDefault:DEF_USER_TOKEN :@""];
                 [AppMethod setStringDefault:DEF_USER_TYPE :@""];
                 [AppMethod setBoolDefault:DEF_IS_LOGIN :false];
                 
                 LoginViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                 [self.navigationController pushViewController:vc animated:YES];
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


- (IBAction)no_logout:(id)sender
{
    [self.popup hideAnimated:YES];
}



//
//- (IBAction)homebtn:(id)sender
//{
//    SWRevealViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Contractor_SWRevealViewController"];
//    [self.navigationController pushViewController:vc animated:YES];
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"home"])
    {
        Contractor_ViewController *photoController = (Contractor_ViewController*)segue.destinationViewController;
        
        photoController.btntag = 1;
    }
    else if ([segue.identifier isEqualToString:@"change password"])
    {
//        Contractor_ViewController *photoController = (Contractor_ViewController*)segue.destinationViewController;
//        
//        photoController.btntag = 2;
        _popupView.hidden = NO;
        //   _popupUpdateProfile.hidden = YES;
        _popup_newsLetter.hidden = YES;
        _popup_logout.hidden = YES;
        
        if(!self.popup)
            self.popup = [KOPopupView popupView];
        [self.popup.handleView addSubview:self.popupView];
        self.popupView.center = CGPointMake(self.popup.handleView.frame.size.width/2.0,self.popup.handleView.frame.size.height/2.0);
        [self.popup show];
        // [self.popup hideAnimated:YES];
    }
    else if ([segue.identifier isEqualToString:@"update profile"])
    {
      
        Contractor_ViewController *photoController = (Contractor_ViewController*)segue.destinationViewController;
        
        photoController.btntag = 3;
    }
    else if ([segue.identifier isEqualToString:@"news letter"])
    {
//        Contractor_ViewController *photoController = (Contractor_ViewController*)segue.destinationViewController;
//        
//        photoController.btntag = 4;
        
        _popup_newsLetter.hidden = NO;
        //_popupUpdateProfile.hidden = YES;
        _popupView.hidden = YES;
        _popup_logout.hidden = YES;
        
        if(!self.popup)
            self.popup = [KOPopupView popupView];
        [self.popup.handleView addSubview:self.popup_newsLetter];
        self.popup_newsLetter.center = CGPointMake(self.popup.handleView.frame.size.width/2.0,self.popup.handleView.frame.size.height/2.0);
        [self.popup show];
        
    }
    else if ([segue.identifier isEqualToString:@"faq"])
    {
        Contractor_ViewController *photoController = (Contractor_ViewController*)segue.destinationViewController;
        
        photoController.btntag = 5;
    }
    else if ([segue.identifier isEqualToString:@"get issue"])
    {
        Contractor_ViewController *photoController = (Contractor_ViewController*)segue.destinationViewController;
        
        photoController.btntag = 6;
    }
    else if ([segue.identifier isEqualToString:@"logout"])
    {
//        Contractor_ViewController *photoController = (Contractor_ViewController*)segue.destinationViewController;
//        
//        photoController.btntag = 7;
        _popup_logout.hidden = NO;
        _popup_newsLetter.hidden = YES;
        // _popupUpdateProfile.hidden = YES;
        _popupView.hidden = YES;
        
        if(!self.popup)
            self.popup = [KOPopupView popupView];
        [self.popup.handleView addSubview:self.popup_logout];
        self.popup_logout.center = CGPointMake(self.popup.handleView.frame.size.width/2.0,self.popup.handleView.frame.size.height/2.0);
        [self.popup show];

    }
    else if ([segue.identifier isEqualToString:@"add project"])
    {
        Contractor_ViewController *photoController = (Contractor_ViewController*)segue.destinationViewController;
        
        photoController.btntag = 7;
    }
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] )
    {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }

}

@end
