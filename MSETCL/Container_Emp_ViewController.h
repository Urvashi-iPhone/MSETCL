//
//  Container_Emp_ViewController.h
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/10/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Container_Emp_ViewController : UIViewController
-(void)segueIdentifierReceivedFromParent:(NSString*)button;

@property NSString *segueIdentifier;
@property (nonatomic,assign) UIViewController* vc;
@end
