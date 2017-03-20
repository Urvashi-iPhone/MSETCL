//
//  Container_Emp_ViewController.m
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/10/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import "Container_Emp_ViewController.h"

@interface Container_Emp_ViewController ()

@end

@implementation Container_Emp_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self segueIdentifierReceivedFromParent:@"six"];
}

-(void)segueIdentifierReceivedFromParent:(NSString*)button{
    
    if ([button  isEqual: @"three"]){
        
        self.segueIdentifier = @"3";
        [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
        
    }
    else if ([button  isEqual: @"five"]){
        
        
        self.segueIdentifier = @"5";
        [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
    }
    else if ([button  isEqual: @"six"]){
        
        
        self.segueIdentifier = @"6";
        [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
    }
//    else if ([button  isEqual: @"four"]){
//        
//        
//        self.segueIdentifier = @"4";
//        [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
//    }
//    else if ([button  isEqual: @"five"]){
//        
//        
//        self.segueIdentifier = @"5";
//        [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
//    }
//    else if ([button  isEqual: @"six"]){
//        
//        
//        self.segueIdentifier = @"6";
//        [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
//    }
//    else if ([button  isEqual: @"seven"]){
//        
//        
//        self.segueIdentifier = @"7";
//        [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
//    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController  *lastViewController, *vc;
    //  vc = [[UIViewController alloc]init];
    // Make sure your segue name in storyboard is the same as this line
    
    if ([[segue identifier] isEqual: self.segueIdentifier]){
        if(lastViewController != nil){
            [lastViewController.view removeFromSuperview];
            
            
        }
        
        
        // Get reference to the destination view controller
        vc = (UIViewController *)[segue destinationViewController];
        [self addChildViewController:(vc)];
        
        
        vc. view.frame  = CGRectMake(0,0, self.view.frame.size.width , self.view.frame.size.height);
        
        [self.view addSubview:vc.view];
        lastViewController = vc;
        // Pass any objects to the view controller here, like...
        
    }
}


@end
