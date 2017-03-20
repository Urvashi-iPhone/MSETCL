//
//  AddProject_ViewController.h
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/11/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@import MessageUI;
@import CoreLocation;

@interface AddProject_ViewController : UIViewController<MFMailComposeViewControllerDelegate>
{
    
@private
    
    NSString *_path;
    
    NSArray *_files;
    
}

@property (strong) NSString *path;

@end
