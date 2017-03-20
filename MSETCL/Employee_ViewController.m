//
//  Employee_ViewController.m
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/6/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import "Employee_ViewController.h"
#import "SWRevealViewController.h"
@interface Employee_ViewController ()
@end

@implementation Employee_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _menubtn.target = self.revealViewController;
    _menubtn.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
        [self.navigationController.view removeGestureRecognizer:self.navigationController.interactivePopGestureRecognizer];
    self.navigationController.navigationBar.hidden =YES;
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    if (_btntag == 3)
    {
        [self.container segueIdentifierReceivedFromParent:@"three"];
    }
    else if (_btntag == 5)
    {
        [self.container segueIdentifierReceivedFromParent:@"five"];
    }
//    else if (_btntag == 6)
//    {
//        [self.container segueIdentifierReceivedFromParent:@"six"];
//    }
    //    else if (_btntag == 4)
    //    {
    //        [self.container segueIdentifierReceivedFromParent:@"buttonOne"];
    //    }
    //    else if (_btntag == 5)
    //    {
    //        [self.container segueIdentifierReceivedFromParent:@"buttonTwo"];
    //    }
    //    else if (_btntag == 6)
    //    {
    //        [self.container segueIdentifierReceivedFromParent:@"buttonThree"];
    //    }
    //    else if (_btntag == 7)
    //    {
    //        [self.container segueIdentifierReceivedFromParent:@"buttonOne"];
    //    }
    
    
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //  vc = [[UIViewController alloc]init];
    // Make sure your segue name in storyboard is the same as this line
    
    
    if ([[segue identifier] isEqual: @"container"]){
        self.container = (Container_Emp_ViewController *)[segue destinationViewController];
    }
}
@end
