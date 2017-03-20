//
//  SplashViewController.m
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/4/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import "SplashViewController.h"
#import <AFNetworking.h>
#import "Constant.h"
#import "AppMethod.h"
#import "SWRevealViewController.h"
#import "Employee_ViewController.h"
@interface SplashViewController ()
{
    NSDictionary *dic;
}
@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        [self.navigationController.view removeGestureRecognizer:self.navigationController.interactivePopGestureRecognizer];
     self.navigationController.navigationBar.hidden =YES;
    
    [self getDefault_data];
    

}

-(void)getDefault_data
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
   // [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:[BASE_URL stringByAppendingString:URL_DEFAULT_CONFIG] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        dic = responseObject;
        
        BOOL boolean = [[dic valueForKey:@"status"]boolValue];
 
        if (boolean)
        {
                [AppMethod setDictionaryDefault:DEF_DEFAULT_RESPONSE :dic];
            
                if ([AppMethod getBoolDefault:DEF_IS_LOGIN])
                {
                    if ([AppMethod getIntegerDefault:DEF_USER_TYPE]== 0)
                    {
                        SWRevealViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Employee_SWRevealViewController"];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    else
                    {
                       SWRevealViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Contractor_SWRevealViewController"];
                       [self.navigationController pushViewController:vc animated:YES];
                    }
                }
                else
                {
                    LoginViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                    [self.navigationController pushViewController:vc animated:YES];
            
                }
        }
    }failure:^(NSURLSessionTask *operation, NSError *error)
     {
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"MSETCL" message:[error localizedDescription] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [al show];
        
    }];
    
}


@end
