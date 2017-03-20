//
//  ContainerViewController.m
//  Container View
//
//  Created by Aaqib Hussain on 11/03/2016.
//  Copyright © 2016 Aaqib Hussain. All rights reserved.
//

#import "ContainerViewController.h"


@implementation ContainerViewController
-(void) viewDidLoad{
    
   [self segueIdentifierReceivedFromParent:@"nine"];

}


-(void)segueIdentifierReceivedFromParent:(NSString*)button{

    if ([button  isEqual: @"one"]){
    
        self.segueIdentifier = @"1";
        [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
        
    }
    else if ([button  isEqual: @"two"]){
        
        
        self.segueIdentifier = @"2";
        [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
    }
    else if ([button  isEqual: @"three"]){
        
        
        self.segueIdentifier = @"3";
        [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
    }
    else if ([button  isEqual: @"four"]){
        
        
        self.segueIdentifier = @"4";
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
    else if ([button  isEqual: @"seven"]){
        
        
        self.segueIdentifier = @"7";
        [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
    }
    else if ([button  isEqual: @"eight"]){
        
        
        self.segueIdentifier = @"8";
        [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
    }
    else if ([button  isEqual: @"nine"]){
        
        
        self.segueIdentifier = @"9";
        [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
    }
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
