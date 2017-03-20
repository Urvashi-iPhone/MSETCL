//
//  SignUp_Employee.m
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/6/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import "SignUp_Employee.h"
#import <AFNetworking.h>
#import "ProgressHUD.h"
#import "Constant.h"
#import "AppMethod.h"

@interface SignUp_Employee ()
{
NSString *sapid,*pass,*agenci_name,*contact_name,*contact_email,*contact_mobile,*address,*state,*distric,*city,*pincode,*status;
NSMutableDictionary *setdic;
NSDictionary *responseDic;
NSDictionary *defaultResDic;
NSMutableArray *myDesignationList;
NSMutableArray *myZoneList;
NSMutableArray *myCircleList;
NSMutableArray *myDivisionList;
NSMutableArray *myStatusList;
NSMutableArray *mysubDivisionList;
}
@end

@implementation SignUp_Employee

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //scrollview
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrlView.subviews)
    {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrlView.contentSize = contentRect.size;
    
    //_submitbtn.layer.cornerRadius = _submitbtn.frame.size.height/2;
    
    _txtAddress.layer.borderColor= [[UIColor lightGrayColor] CGColor];
    _txtAddress.layer.borderWidth = 1.0f;
    _txtAddress.layer.cornerRadius = 5.0f;
    
    myStatusList =[[NSMutableArray alloc]initWithObjects:@"Enable",@"Disable",nil];
    _txtStatus.items = myStatusList;
    _txtStatus.selectedItemIndex = 0;
    
    [self getDesignationList];
    [self getZoneList];
    [self getCircleList];
    [self getDivisionList];
    [self getSubDivisionList];
}
-(void)getDesignationList
{
    defaultResDic = [AppMethod getDictionaryDefault:DEF_DEFAULT_RESPONSE];
    NSMutableArray *designationList = [[defaultResDic valueForKey:@"data"] valueForKey:@"designation"];
    myDesignationList = [[NSMutableArray alloc] init];
    for (int i =0; i<[designationList count]; i++)
    {
        NSString *value = [[designationList objectAtIndex:i] valueForKey:@"value"];
        NSLog(@"get = %@",value);
        [myDesignationList addObject:value];
    }
    _txtDesignation.items = myDesignationList;
    _txtDesignation.selectedItemIndex = 0;
}
-(void)getZoneList
{
    defaultResDic = [AppMethod getDictionaryDefault:DEF_DEFAULT_RESPONSE];
    NSMutableArray *ZoneList = [[defaultResDic valueForKey:@"data"] valueForKey:@"zone"];
    myZoneList = [[NSMutableArray alloc] init];
    for (int i =0; i<[ZoneList count]; i++)
    {
        NSString *value = [[ZoneList objectAtIndex:i] valueForKey:@"value"];
        NSLog(@"get = %@",value);
        [myZoneList addObject:value];
    }
    _txtZone.items = myZoneList;
    _txtZone.selectedItemIndex = 0;
}
-(void)getCircleList
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [ProgressHUD show:@"Please wait..."];
    
    NSString *url=[BASE_URL stringByAppendingString:URL_GET_CIRCLE];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setObject:@"8" forKey:@"zone_id"];
    
    [manager POST:url parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        responseDic = responseObject;
        
        NSMutableArray *circleList = [responseDic valueForKey:@"data"];
        myCircleList = [[NSMutableArray alloc] init];
        for (int i =0; i<[circleList count]; i++)
        {
            NSString *value = [[circleList objectAtIndex:i] valueForKey:@"value"];
            NSLog(@"get = %@",value);
            [myCircleList addObject:value];
        }
        _txtCircle.items = myCircleList;
        _txtCircle.selectedItemIndex = 0;
        
        [ProgressHUD dismiss];
        
    } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"MSETCL" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
         [al show];
         [ProgressHUD dismiss];
     }];
}

-(void)getDivisionList
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [ProgressHUD show:@"Please wait..."];
    
    NSString *url=[BASE_URL stringByAppendingString:URL_GET_DIVISION];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setObject:@"5" forKey:@"circle_id"];
    
    [manager POST:url parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        responseDic = responseObject;
        
        NSMutableArray *divisionList = [responseDic valueForKey:@"data"];
        myDivisionList = [[NSMutableArray alloc] init];
        for (int i =0; i<[divisionList count]; i++)
        {
            NSString *value = [[divisionList objectAtIndex:i] valueForKey:@"value"];
            NSLog(@"get = %@",value);
            [myDivisionList addObject:value];
        }
        _txtDivision.items = myDivisionList;
        _txtDivision.selectedItemIndex = 0;
        
        [ProgressHUD dismiss];
        
    } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"MSETCL" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
         [al show];
         [ProgressHUD dismiss];
     }];
}

-(void)getSubDivisionList
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [ProgressHUD show:@"Please wait..."];
    
    NSString *url=[BASE_URL stringByAppendingString:URL_GET_SUB_DIVISION];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setObject:@"5" forKey:@"division_id"];
    
    [manager POST:url parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        responseDic = responseObject;
        
        NSMutableArray *subDivisionList = [responseDic valueForKey:@"data"];
        mysubDivisionList = [[NSMutableArray alloc] init];
        for (int i =0; i<[subDivisionList count]; i++)
        {
            NSString *value = [[subDivisionList objectAtIndex:i] valueForKey:@"value"];
            NSLog(@"get = %@",value);
            [mysubDivisionList addObject:value];
        }
        _txtSubDivision.items = mysubDivisionList;
        _txtSubDivision.selectedItemIndex = 0;
        
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
//    sapid = _txtSapId.text;
//    pass = _txtPass.text;
//    agenci_name =_txtAgenciName.text;
//    contact_name = _txtContactName.text;
//    contact_email = _txtContactEmail.text;
//    contact_mobile =_txtContactMobile.text;
//    address = _txtAddress.text;
//    pincode = _txtPincode.text;
//    
//    //    if ([[uname stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
//    //    {
//    //        [self.view makeToast:@"SAP ID should not be blank!"];
//    //    }
//    //    else if (![AppMethod stringMatchedREGEX:uname :REGEX_EMAIL_EXPRESS])
//    //    {
//    //        [self.view makeToast:@"Invalid Email Id!"];
//    //    }
//    //    if ([[pass stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
//    //    {
//    //        [self.view makeToast:@"Password should not be blank!"];
//    //    }
//    setdic = [[NSMutableDictionary alloc]init];
//    [setdic setObject:sapid forKey:@"email"];
//    [setdic setObject:pass forKey:@"password"];
//    [setdic setObject:agenci_name forKey:@"agencies_name"];
//    [setdic setObject:contact_name forKey:@"contact_name"];
//    [setdic setObject:contact_email forKey:@"contact_email"];
//    [setdic setObject:contact_mobile forKey:@"contact_mobile"];
//    [setdic setObject:address forKey:@"address"];
//    [setdic setObject:pincode forKey:@"pincode"];
//    
//    state = [myStateList objectAtIndex:[_txtState selectedItemIndex]];
//    [setdic setObject:state forKey:@"state"];
//    
//    distric = [myDistrictList objectAtIndex:[_txtDistric selectedItemIndex]];
//    [setdic setObject:distric forKey:@"district"];
//    
//    city = [myCityList objectAtIndex:[_txtCity selectedItemIndex]];
//    [setdic setObject:city forKey:@"city"];
//    
//    status = [myStatusList objectAtIndex:[_txtStatus selectedItemIndex]];
//    [setdic setObject:status forKey:@"status"];
//    
//    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [ProgressHUD show:@"Please wait..."];
//    
//    
//    [manager POST:[BASE_URL stringByAppendingString:URL_CONTRACTOR_SIGNUP] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic12)
//     {
//         BOOL boolean = [[dic12 valueForKey:@"status"]boolValue];
//         
//         if (boolean)
//         {
//             Contractor_ViewController *tab = [self.storyboard instantiateViewControllerWithIdentifier:@"Contractor_ViewController"];
//             
//             
//             [self.navigationController pushViewController:tab animated:YES];
//         }
//         else
//         {
//             UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[dic12 valueForKey:@"message"] delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
//             [al show];
//         }
//         [ProgressHUD dismiss];
//         
//     } failure:^(NSURLSessionTask *operation, NSError *error) {
//         UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"Alert" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Ok", nil];
//         [al show];
//         [ProgressHUD dismiss];
//     }];
    
}


@end
