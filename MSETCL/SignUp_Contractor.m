//
//  SignUpViewController.m
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/4/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import "SignUp_Contractor.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"
#import "Constant.h"
#import "Contractor_ViewController.h"
#import "AppMethod.h"
#import "UIView+Toast.h"
#import "Constant.h"
#import "SWRevealViewController.h"
@interface SignUp_Contractor ()
{
    NSString *sapid,*pass,*agenci_name,*contact_name,*contact_email,*contact_mobile,*address,*state,*distric,*city,*pincode,*status;
    NSMutableDictionary *setdic;
    NSDictionary *responseDic_district;
    NSDictionary *responseDic_city;
    NSDictionary *defaultResDic;
    NSMutableArray *myStateList;
    NSMutableArray *myCityList;
    NSMutableArray *myDistrictList;
//    NSMutableArray *myStatusList;
    NSMutableArray *cityList;
    NSMutableArray *districtList;
}
@property (weak, nonatomic) IBOutlet UIButton *passShowBtn;
@end

@implementation SignUp_Contractor

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        [self.navigationController.view removeGestureRecognizer:self.navigationController.interactivePopGestureRecognizer];
    //scrollview
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrlView.subviews)
    {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrlView.contentSize = contentRect.size;
    
 //   _submitbtn.layer.cornerRadius = _submitbtn.frame.size.height/2;
    
    _txtAddress.layer.borderColor= [[UIColor whiteColor] CGColor];
    _txtAddress.layer.borderWidth = 1.0f;
    _txtAddress.layer.cornerRadius = 5.0f;
    
    self.txtPass.rightView = _passShowBtn;
    self.txtPass.rightViewMode = UITextFieldViewModeAlways;
    
    defaultResDic = [AppMethod getDictionaryDefault:DEF_DEFAULT_RESPONSE];
    
//    [self getCityList];
    [self getStateList];
//    [self getDistrictList:1];
    
    
//     myStatusList =[[NSMutableArray alloc]initWithObjects:@"Enable",@"Disable",nil];
//    _txtStatus.items = myStatusList;
//    _txtStatus.selectedItemIndex = 0;
    
      [self placeHolder_text];
    
}


-(void)placeHolder_text
{
    UIColor *color = [UIColor whiteColor];
    _txtSapId.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Enter Sap ID" attributes:@{
                                                                            NSForegroundColorAttributeName: color,
                                                                            NSFontAttributeName : [UIFont fontWithName:@"Raleway" size:15.0]
                                                                            }
     ];
    _txtPass.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Password" attributes:@{
                                                                                                         NSForegroundColorAttributeName: color,
                                                                                                         NSFontAttributeName : [UIFont fontWithName:@"Raleway" size:15.0]
                                                                                                         }
                                      ];
    _txtAgenciName.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Enter Agencies Name" attributes:@{
                                                                            NSForegroundColorAttributeName: color,
                                                                            NSFontAttributeName : [UIFont fontWithName:@"Raleway" size:15.0]
                                                                            }
     ];
    _txtContactName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Contact Name" attributes:@{
                                                                                                         NSForegroundColorAttributeName: color,
                                                                                                         NSFontAttributeName : [UIFont fontWithName:@"Raleway" size:15.0]
                                                                                                         }
                                      ];

    _txtContactEmail.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Enter Contact Email" attributes:@{
                                                                            NSForegroundColorAttributeName: color,
                                                                            NSFontAttributeName : [UIFont fontWithName:@"Raleway" size:15.0]
                                                                            }
     ];
    _txtContactMobile.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Contact Mobile" attributes:@{
                                                                                                         NSForegroundColorAttributeName: color,
                                                                                                         NSFontAttributeName : [UIFont fontWithName:@"Raleway" size:15.0]
                                                                                                         }
                                      ];

    _txtPincode.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Enter Pincode" attributes:@{
                                                                            NSForegroundColorAttributeName: color,
                                                                            NSFontAttributeName : [UIFont fontWithName:@"Raleway" size:15.0]
                                                                            }
     ];
    _txtPass.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{
                                                                                                         NSForegroundColorAttributeName: color,
                                                                                                         NSFontAttributeName : [UIFont fontWithName:@"Raleway" size:15.0]
                                                                                                         }
                                      ];

    _txtSapId.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Enter Sap ID" attributes:@{
                                                                            NSForegroundColorAttributeName: color,
                                                                            NSFontAttributeName : [UIFont fontWithName:@"Raleway" size:15.0]
                                                                            }
     ];
    _txtPass.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{
                                                                                                         NSForegroundColorAttributeName: color,
                                                                                                         NSFontAttributeName : [UIFont fontWithName:@"Raleway" size:15.0]
                                                                                                         }
                                      ];

    
    
}

-(void)getStateList
{
   
    NSMutableArray *stateList = [[defaultResDic valueForKey:@"data"] valueForKey:@"state"];
    myStateList = [[NSMutableArray alloc] init];
    for (int i =0; i<[stateList count]; i++)
    {
        NSString *value = [[stateList objectAtIndex:i] valueForKey:@"value"];
        NSLog(@"get = %@",value);
        [myStateList addObject:value];
    }
    _txtState.items = myStateList;
    _txtState.selectedItemIndex = 0;
}


-(void)getDistrictList:(int)stateId
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [ProgressHUD show:@"Please wait..."];
    
    NSString *url=[BASE_URL stringByAppendingString:URL_GET_DISTRICT];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setObject:[NSString stringWithFormat:@"%d",stateId] forKey:@"state_id"];
    
    [manager POST:url parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        responseDic_district = responseObject;
        
        districtList = [responseDic_district valueForKey:@"data"];
        myDistrictList = [[NSMutableArray alloc] init];
        for (int i =0; i<[districtList count]; i++)
        {
            NSString *value = [[districtList objectAtIndex:i] valueForKey:@"value"];
            NSLog(@"get = %@",value);
            [myDistrictList addObject:value];
        }
        _txtDistric.items = myDistrictList;
        _txtDistric.selectedItemIndex = 0;
        
        [ProgressHUD dismiss];
        
    } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"MSETCL" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
         [al show];
         [ProgressHUD dismiss];
     }];
}
- (void)dropDown:(TPSDropDown *)dropDown didSelectItemAtIndex:(NSInteger)index
{
    if ([dropDown isEqual:_txtState])
    {
        NSMutableArray *stateList = [[defaultResDic valueForKey:@"data"] valueForKey:@"state"];
        [self getDistrictList:[[[stateList objectAtIndex:index] valueForKey:@"id"] intValue]];
    }
    else if (([dropDown isEqual:_txtDistric]))
    {
        NSMutableArray *distList = [responseDic_district valueForKey:@"data"];
        [self getCityList:[[[districtList objectAtIndex:index] valueForKey:@"id"] intValue]];
    }

}

-(void)getCityList:(int)district_id
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [ProgressHUD show:@"Please wait..."];
    
    NSString *url=[BASE_URL stringByAppendingString:URL_GET_CITY];
    
     NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setObject:[NSString stringWithFormat:@"%d",district_id] forKey:@"district_id"];

    [manager POST:url parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {

        responseDic_city = responseObject;
        
        cityList = [responseDic_city valueForKey:@"data"];
        myCityList = [[NSMutableArray alloc] init];
        for (int i =0; i<[cityList count]; i++)
        {
            NSString *value = [[cityList objectAtIndex:i] valueForKey:@"value"];
            NSLog(@"get = %@",value);
            [myCityList addObject:value];
        }
        _txtCity.items = myCityList;
        _txtCity.selectedItemIndex = 0;
        
        [ProgressHUD dismiss];
        
    } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"MSETCL" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
         [al show];
         [ProgressHUD dismiss];
     }];
}



- (IBAction)submitbtn:(id)sender
{
    sapid = _txtSapId.text;
    pass = _txtPass.text;
    agenci_name =_txtAgenciName.text;
    contact_name = _txtContactName.text;
    contact_email = _txtContactEmail.text;
    contact_mobile =_txtContactMobile.text;
    address = _txtAddress.text;
    pincode = _txtPincode.text;
    
    if ([[sapid stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"SAP ID should not be blank!"];
    }
    else if (sapid.length != 6)
    {
        [self.view makeToast:@"SAP ID must be have 5 digit"];
    }
    else if ([[pass stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Password should not be blank!"];
    }
    else if (pass.length < 6)
    {
        [self.view makeToast:@"Password should be atleast 6 characters!"];
    }
    else if ([[agenci_name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Agency Name should not be blank!"];
    }
    else if ([[contact_name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Contact Name should not be blank!"];
    }
    else if ([[contact_email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Contact Email should not be blank!"];
    }
    else if (![AppMethod stringMatchedREGEX:contact_email :REGEX_EMAIL_EXPRESS])
    {
        [self.view makeToast:@"Invalid Contact Email!"];
    }
    else if ([[contact_mobile stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Contact Mobile should not be blank!"];
    }
    else if (![AppMethod stringMatchedREGEX:contact_mobile :REGEX_MOBILE_EXPRESS])
    {
        [self.view makeToast:@"Invalid Contact Mobile!"];
    }
    else if ([[address stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Address should not be blank!"];
    }
    else if ([[pincode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Pincode should not be blank!"];
    }
    else
    {
  
     setdic = [[NSMutableDictionary alloc]init];
    [setdic setObject:sapid forKey:@"email"];
    [setdic setObject:pass forKey:@"password"];
    [setdic setObject:agenci_name forKey:@"agencies_name"];
    [setdic setObject:contact_name forKey:@"contact_name"];
    [setdic setObject:contact_email forKey:@"contact_email"];
    [setdic setObject:contact_mobile forKey:@"contact_mobile"];
    [setdic setObject:address forKey:@"address"];
    [setdic setObject:pincode forKey:@"pincode"];
    [setdic setObject:@"deviceToken" forKey:@"device_token"];
    [setdic setObject:@"abc" forKey:@"device_id"];
    [setdic setObject:@"ios" forKey:@"device_type"];
   
    
     state = [myStateList objectAtIndex:[_txtState selectedItemIndex]];
    [setdic setObject:state forKey:@"state"];
    
    distric = [myDistrictList objectAtIndex:[_txtDistric selectedItemIndex]];
    [setdic setObject:distric forKey:@"district"];
    
    city = [myCityList objectAtIndex:[_txtCity selectedItemIndex]];
    [setdic setObject:city forKey:@"city"];
    
//    status = [myStatusList objectAtIndex:[_txtStatus selectedItemIndex]];
//    [setdic setObject:status forKey:@"status"];
    
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [ProgressHUD show:@"Please wait..."];
    
    
    [manager POST:[BASE_URL stringByAppendingString:URL_CONTRACTOR_SIGNUP] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic12)
     {
         BOOL boolean = [[dic12 valueForKey:@"status"]boolValue];
         
         if (boolean)
         {
             SWRevealViewController *tab = [self.storyboard instantiateViewControllerWithIdentifier:@"Contractor_SWRevealViewController"];
            
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


- (IBAction)passShowBtn:(id)sender {
    
    if (!self.txtPass.secureTextEntry)
    {
        self.txtPass.secureTextEntry = YES;
        [_passShowBtn setImage:[UIImage imageNamed:@"open_eye.png"] forState:UIControlStateNormal];
    }
    else
    {
        self.txtPass.secureTextEntry = NO;
        [_passShowBtn setImage:[UIImage imageNamed:@"close_eye.png"] forState:UIControlStateNormal];
    }
    [self.txtPass becomeFirstResponder];

    
}
- (IBAction)backbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)storeContractorDataAndGotoNextActivity:(NSDictionary*)contractorData
{
    [AppMethod setStringDefault:DEF_SAP_ID :[contractorData valueForKey:@"contractor_sap_id"]];
    [AppMethod setIntegerDefault:DEF_ID :[contractorData valueForKey:@"id"]];
    [AppMethod setIntegerDefault:DEF_USER_TYPE :1];
    [AppMethod setStringDefault:DEF_USER_TOKEN :[contractorData valueForKey:@"user_token"]];
    [AppMethod setStringDefault:DEF_PASSWORD :_txtPass.text];
    [AppMethod setStringDefault:DEF_USERNAME :[contractorData valueForKey:@"contact_name"]];
    [AppMethod setStringDefault:DEF_EMAIL :[contractorData valueForKey:@"contact_email"]];
    [AppMethod setStringDefault:DEF_AGENCI_NAME :[contractorData valueForKey:@"agencies_name"]];
    [AppMethod setStringDefault:DEF_ADDRESS :[contractorData valueForKey:@"address"]];
    [AppMethod setStringDefault:DEF_PINCODE :[contractorData valueForKey:@"pincode"]];
    [AppMethod setStringDefault:DEF_MOBILE :[contractorData valueForKey:@"contact_mobile"]];

    
}

@end
