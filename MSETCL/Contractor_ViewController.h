//
//  ViewController.h
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/4/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerViewController.h"

@interface Contractor_ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menubtn;
@property ContainerViewController *container;
@property (nonatomic)NSInteger btntag;
//@property(nonatomic)NSDictionary *updateValue;
@end

