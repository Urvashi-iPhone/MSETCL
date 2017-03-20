//
//  Employee_ViewController.h
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/6/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Container_Emp_ViewController.h"

@interface Employee_ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
@property Container_Emp_ViewController *container;
@property (nonatomic)NSInteger btntag;

@end
