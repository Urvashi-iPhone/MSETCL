//
//  DialogViewController.m
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/9/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import "DialogViewController.h"
#import <IQTextView.h>
#import "KOPopupView.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"
#import "AppMethod.h"
#import "Constant.h"
#import "UIView+Toast.h"
@interface DialogViewController ()
{
     NSMutableDictionary *setdic;
      NSString *contactName,*contactEmail,*agenciesName,*address,*pincode,*contactMobile;
}
//Update Profile
@property (nonatomic, strong) KOPopupView *popup;
@property (weak, nonatomic) IBOutlet KOPopupView *popupUpdateProfile;
@property (weak, nonatomic) IBOutlet UIButton *submit_updateProfile;
@property (weak, nonatomic) IBOutlet UIButton *cancle_updateProfile;
@property (weak, nonatomic) IBOutlet UITextField *contactName_updateProfile;
@property (weak, nonatomic) IBOutlet UITextField *contactEmail_updateProfile;
@property (weak, nonatomic) IBOutlet UITextField *agenciesName_updateProfile;
@property (weak, nonatomic) IBOutlet IQTextView *address_updateProfile;
@property (weak, nonatomic) IBOutlet UITextField *pincode_updateProfile;
@property (weak, nonatomic) IBOutlet UITextField *contactMobile_updateProfile;

@end

@implementation DialogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Address
    _address_updateProfile.layer.borderColor= [[UIColor lightGrayColor] CGColor];
    _address_updateProfile.layer.borderWidth = 1.0f;
    _address_updateProfile.layer.cornerRadius = 5.0f;
    
    //Update Profile
   // _popupUpdateProfile.hidden = YES;
    _popupUpdateProfile.layer.masksToBounds = NO;
    // _popupView.layer.cornerRadius = 8;
    _popupUpdateProfile.layer.shadowColor = [[UIColor blackColor] CGColor];
    _popupUpdateProfile.layer.shadowOffset = CGSizeMake(2, 2);
    _popupUpdateProfile.layer.shadowRadius = 5;
    _popupUpdateProfile.layer.shadowOpacity = 0.8;

    _popupUpdateProfile.hidden = NO;
    
    if(!self.popup)
        self.popup = [KOPopupView popupView];
    [self.popup.handleView addSubview:self.popupUpdateProfile];
    self.popupUpdateProfile.center = CGPointMake(self.popup.handleView.frame.size.width/2.0,self.popup.handleView.frame.size.height/2.0);
    [self.popup show];
    
    _contactName_updateProfile.text = [AppMethod getStringDefault:DEF_USERNAME];
    _contactEmail_updateProfile.text = [AppMethod getStringDefault:DEF_EMAIL];
    _contactMobile_updateProfile.text = [AppMethod getStringDefault:DEF_MOBILE];
    _agenciesName_updateProfile.text = [AppMethod getStringDefault:DEF_AGENCI_NAME];
    _address_updateProfile.text = [AppMethod getStringDefault:DEF_ADDRESS];
    _pincode_updateProfile.text = [AppMethod getStringDefault:DEF_PINCODE];


}

- (IBAction)submit_updateProfile:(id)sender
{
    contactName = _contactName_updateProfile.text;
    contactEmail = _contactEmail_updateProfile.text;
    agenciesName = _agenciesName_updateProfile.text;
    address = _address_updateProfile.text;
    pincode = _pincode_updateProfile.text;
    contactMobile = _contactMobile_updateProfile.text;
    
    if ([[contactName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Contact Name should not be blank!"];
    }
    else if ([[contactEmail stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Contact Email should not be blank!"];
    }
    else if (![AppMethod stringMatchedREGEX:contactEmail :REGEX_EMAIL_EXPRESS])
    {
        [self.view makeToast:@"Invalid Contact Email!"];
    }
    else if ([[agenciesName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Agency Name should not be blank!"];
    }
    else if ([[address stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Address should not be blank!"];
    }
    else if ([[pincode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Pincode should not be blank!"];
    }
    else if ([[contactMobile stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Contact Mobile should not be blank!"];
    }
    else if (![AppMethod stringMatchedREGEX:contactMobile :REGEX_MOBILE_EXPRESS])
    {
        [self.view makeToast:@"Invalid Contact Mobile!"];
    }
    else
    {
    setdic = [[NSMutableDictionary alloc]init];
    [setdic setObject:contactName forKey:@"contact_name"];
    [setdic setObject:contactEmail forKey:@"contact_email"];
    [setdic setObject:agenciesName forKey:@"agencies_name"];
    [setdic setObject:address forKey:@"address"];
    [setdic setObject:pincode forKey:@"pincode"];
    [setdic setObject:contactMobile forKey:@"contact_mobile"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[AppMethod getStringDefault:DEF_USER_TOKEN] forHTTPHeaderField:@"User-Token"];
    [ProgressHUD show:@"Please wait..."];
    
    
    [manager POST:[BASE_URL stringByAppendingString:URL_CONTRACTOR_UPDATE_PROFILE] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic12)
     {
         BOOL boolean = [[dic12 valueForKey:@"status"]boolValue];
            NSDictionary *contractorData = [dic12 valueForKey:@"data"];
         if (boolean)
         {
             [self.popup hideAnimated:YES];
             
            [AppMethod setStringDefault:DEF_USER_TOKEN :[contractorData valueForKey:@"user_token"]];
             
             [AppMethod setStringDefault:DEF_USERNAME :[contractorData valueForKey:@"contact_name"]];
             [AppMethod setStringDefault:DEF_EMAIL :[contractorData valueForKey:@"contact_email"]];
             [AppMethod setStringDefault:DEF_AGENCI_NAME :[contractorData valueForKey:@"agencies_name"]];
             [AppMethod setStringDefault:DEF_ADDRESS :[contractorData valueForKey:@"address"]];
             [AppMethod setStringDefault:DEF_PINCODE :[contractorData valueForKey:@"pincode"]];
             [AppMethod setStringDefault:DEF_MOBILE :[contractorData valueForKey:@"contact_mobile"]];
             
             
             [self.navigationController popViewControllerAnimated:YES];
             UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"MSETCL" message:@"Update Contractor Profile SuccesFully" delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
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
