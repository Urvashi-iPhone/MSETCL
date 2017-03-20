//
//  AddProject_ViewController.m
//  MSETCL
//
//  Created by Tecksky Techonologies on 3/11/17.
//  Copyright © 2017 Tecksky Technologies. All rights reserved.
//

#import "AddProject_ViewController.h"
#import <IQTextView.h>
#import <THDatePickerViewController.h>
#import <AFNetworking.h>
#import "DirectoryBrowserTableViewController.h"
#import "UIView+Toast.h"
#import "ProgressHUD.h"
#import "Constant.h"
@interface AddProject_ViewController ()<THDatePickerDelegate>
{
    NSString *prjSapid,*prjname,*wbselement,*wbsSubElement,*brnumber,*date,*prjDefination,*subWbsDetail;
    NSString *inch_sapid,*inch_name,*inch_officeAddress;
    NSString *res_civilAmt,*res_civilAmtFile,*res_civilloaNumber,*res_civilDate;
    NSString *res_supplyAmt,*res_supplyAmtFile,*res_supplyloaNumber,*res_supplyDate;
    NSString *res_irectionAmt,*res_irectionAmtFile,*res_irectionloaNumber,*res_irectionDate;
    NSString *cont_Sapid,*cont_name,*emp_sapid,*cont_authName;
    NSString *timeline_startdate,*timeline_completedate,*timeline_commisiondate;
    NSString *otherfile;
    NSMutableDictionary *setdic;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrlView;
@property (weak, nonatomic) IBOutlet IQTextView *txtOfficeAdd;

@property (weak, nonatomic) IBOutlet UIButton *btndate_projDetail;
@property (weak, nonatomic) IBOutlet UIButton *btndate_civil;
@property (weak, nonatomic) IBOutlet UIButton *btndate_supply;
@property (weak, nonatomic) IBOutlet UIButton *btndate_Erection;
@property (weak, nonatomic) IBOutlet UIButton *btndate_startdate;
@property (weak, nonatomic) IBOutlet UIButton *btndate_commisiondate;
@property (weak, nonatomic) IBOutlet UIButton *btndate_completedate;


//property date:
@property (nonatomic, strong) THDatePickerViewController * datePicker;
@property (nonatomic, retain) NSDate * curDate;
@property (nonatomic, retain) NSDateFormatter * formatter;

//view
@property (weak, nonatomic) IBOutlet UIView *prj_detail;
@property (weak, nonatomic) IBOutlet UIView *incharge_info;
@property (weak, nonatomic) IBOutlet UIView *respective_loa;
@property (weak, nonatomic) IBOutlet UIView *contractor_detail;
@property (weak, nonatomic) IBOutlet UIView *prj_timeline1;
@property (weak, nonatomic) IBOutlet UIView *prj_timeline2;



//Project Detail

@property (weak, nonatomic) IBOutlet UITextField *prj_sapid;
@property (weak, nonatomic) IBOutlet UITextField *prj_name;
@property (weak, nonatomic) IBOutlet UITextField *prj_WBSelement;
@property (weak, nonatomic) IBOutlet UITextField *prj_WBSsubelement;
@property (weak, nonatomic) IBOutlet UITextField *prj_brnumber;
@property (weak, nonatomic) IBOutlet IQTextView *prj_defination;
@property (weak, nonatomic) IBOutlet IQTextView *prj_subWBSDetail;

//Incharge Info
@property (weak, nonatomic) IBOutlet UITextField *inch_sapid;
@property (weak, nonatomic) IBOutlet UITextField *inch_name;
@property (weak, nonatomic) IBOutlet IQTextView *inch_officeAdd;

//Respective LOA
@property (weak, nonatomic) IBOutlet UITextField *res_civilAmount;
@property (weak, nonatomic) IBOutlet UITextField *res_civilLoaNumber;
@property (weak, nonatomic) IBOutlet UIButton *res_civilChooseFile;

@property (weak, nonatomic) IBOutlet UITextField *res_supplyAmount;
@property (weak, nonatomic) IBOutlet UITextField *res_supplyLoaNumber;
@property (weak, nonatomic) IBOutlet UIButton *res_supplyChooseFile;

@property (weak, nonatomic) IBOutlet UITextField *res_erectionAmount;
@property (weak, nonatomic) IBOutlet UITextField *res_erectionLoaNumber;
@property (weak, nonatomic) IBOutlet UIButton *res_erectionChooseFile;

//Contractor Details

@property (weak, nonatomic) IBOutlet UITextField *cont_sapid;
@property (weak, nonatomic) IBOutlet UILabel *cont_name;
@property (weak, nonatomic) IBOutlet UITextField *cont_empSapID;
@property (weak, nonatomic) IBOutlet UILabel *cont_authName;

//Project TimeLine
@property (weak, nonatomic) IBOutlet UIButton *timeline_otherfile;




@end

@implementation AddProject_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrlView.subviews)
    {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrlView.contentSize = contentRect.size;

    
    _prj_defination.layer.borderColor= [[UIColor grayColor] CGColor];
    _prj_defination.layer.borderWidth = 1.0f;
   // _txtPrjDef.layer.cornerRadius = 5.0f;

    
    _prj_subWBSDetail.layer.borderColor= [[UIColor grayColor] CGColor];
    _prj_subWBSDetail.layer.borderWidth = 1.0f;
   // _txtWBSDetail.layer.cornerRadius = 5.0f;
    
    _txtOfficeAdd.layer.borderColor= [[UIColor grayColor] CGColor];
    _txtOfficeAdd.layer.borderWidth = 1.0f;
    //_txtOfficeAdd.layer.cornerRadius = 5.0f;
    
    //DATE PICKER
    
    _prj_detail.layer.borderColor = [[UIColor redColor] CGColor];
    _prj_detail.layer.borderWidth = 1.0f;

    _incharge_info.layer.borderColor = [[UIColor redColor] CGColor];
    _incharge_info.layer.borderWidth = 1.0f;

    _respective_loa.layer.borderColor = [[UIColor redColor] CGColor];
    _respective_loa.layer.borderWidth = 1.0f;

    _contractor_detail.layer.borderColor = [[UIColor redColor] CGColor];
    _contractor_detail.layer.borderWidth = 1.0f;

    _prj_timeline1.layer.borderColor = [[UIColor redColor] CGColor];
    _prj_timeline1.layer.borderWidth = 1.0f;
    
    _prj_timeline2.layer.borderColor = [[UIColor redColor] CGColor];
    _prj_timeline2.layer.borderWidth = 1.0f;

    
    //_btndate_projDetail.layer.cornerRadius = 5.0f;
    _btndate_projDetail.layer.borderColor = [[UIColor grayColor] CGColor];
    _btndate_projDetail.layer.borderWidth = 1.0f;
    
    _btndate_civil.layer.borderColor = [[UIColor grayColor] CGColor];
    _btndate_civil.layer.borderWidth = 1.0f;
    
    _btndate_supply.layer.borderColor = [[UIColor grayColor] CGColor];
    _btndate_supply.layer.borderWidth = 1.0f;
    
    _btndate_Erection.layer.borderColor = [[UIColor grayColor] CGColor];
    _btndate_Erection.layer.borderWidth = 1.0f;
    
    _btndate_startdate.layer.borderColor = [[UIColor grayColor] CGColor];
    _btndate_startdate.layer.borderWidth = 1.0f;
    
    _btndate_completedate.layer.borderColor = [[UIColor grayColor] CGColor];
    _btndate_completedate.layer.borderWidth = 1.0f;
    
    _btndate_commisiondate.layer.borderColor = [[UIColor grayColor] CGColor];
    _btndate_commisiondate.layer.borderWidth = 1.0f;
    
    _res_civilChooseFile.layer.borderColor = [[UIColor grayColor] CGColor];
    _res_civilChooseFile.layer.borderWidth = 1.0f;
    
    _res_supplyChooseFile.layer.borderColor = [[UIColor grayColor] CGColor];
    _res_supplyChooseFile.layer.borderWidth = 1.0f;
    
    _res_erectionChooseFile.layer.borderColor = [[UIColor grayColor] CGColor];
    _res_erectionChooseFile.layer.borderWidth = 1.0f;
    
    _timeline_otherfile.layer.borderColor = [[UIColor grayColor] CGColor];
    _timeline_otherfile.layer.borderWidth = 1.0f;
    
  
    
    //Date Picker
    self.curDate = [NSDate date];
    self.formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"dd/MM/yyyy"];
    [self refreshTitle];

}

-(void)refreshTitle {
    [self.btndate_projDetail setTitle:(self.curDate ? [_formatter stringFromDate:_curDate] : @"No date selected") forState:UIControlStateNormal];
    
     [self.btndate_civil setTitle:(self.curDate ? [_formatter stringFromDate:_curDate] : @"No date selected") forState:UIControlStateNormal];
    
     [self.btndate_supply setTitle:(self.curDate ? [_formatter stringFromDate:_curDate] : @"No date selected") forState:UIControlStateNormal];
    
     [self.btndate_Erection setTitle:(self.curDate ? [_formatter stringFromDate:_curDate] : @"No date selected") forState:UIControlStateNormal];
    
    [self.btndate_startdate setTitle:(self.curDate ? [_formatter stringFromDate:_curDate] : @"No date selected") forState:UIControlStateNormal];
    
    [self.btndate_completedate setTitle:(self.curDate ? [_formatter stringFromDate:_curDate] : @"No date selected") forState:UIControlStateNormal];
    
    [self.btndate_commisiondate setTitle:(self.curDate ? [_formatter stringFromDate:_curDate] : @"No date selected") forState:UIControlStateNormal];
}
-(void)datePickerForAll
{
    if(!self.datePicker)
        self.datePicker = [THDatePickerViewController datePicker];
    self.datePicker.date = self.curDate;
    self.datePicker.delegate = self;
    [self.datePicker setAllowClearDate:NO];
    [self.datePicker setClearAsToday:YES];
    [self.datePicker setAutoCloseOnSelectDate:NO];
    [self.datePicker setAllowSelectionOfSelectedDate:YES];
    [self.datePicker setDisableYearSwitch:YES];
    //[self.datePicker setDisableFutureSelection:NO];
    [self.datePicker setDaysInHistorySelection:12];
    [self.datePicker setDaysInFutureSelection:0];
    //    [self.datePicker setAllowMultiDaySelection:YES];
    //    [self.datePicker setDateTimeZoneWithName:@"UTC"];
    //[self.datePicker setAutoCloseCancelDelay:5.0];
    [self.datePicker setSelectedBackgroundColor:[UIColor colorWithRed:125/255.0 green:208/255.0 blue:0/255.0 alpha:1.0]];
    [self.datePicker setCurrentDateColor:[UIColor colorWithRed:242/255.0 green:121/255.0 blue:53/255.0 alpha:1.0]];
    [self.datePicker setCurrentDateColorSelected:[UIColor yellowColor]];
    
    [self.datePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
        int tmp = (arc4random() % 30)+1;
        return (tmp % 5 == 0);
    }];
    //[self.datePicker slideUpInView:self.view withModalColor:[UIColor lightGrayColor]];
    [self presentSemiViewController:self.datePicker withOptions:@{
                                                                  KNSemiModalOptionKeys.pushParentBack    : @(NO),
                                                                  KNSemiModalOptionKeys.animationDuration : @(1.0),
                                                                  KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                                  }];
  
}
- (IBAction)btndate_prjDetail:(id)sender
{
    [self datePickerForAll];
}
- (IBAction)btndate_civil:(id)sender
{
     [self datePickerForAll];
}
- (IBAction)btndate_supply:(id)sender
{
     [self datePickerForAll];
}
- (IBAction)btndate_erection:(id)sender
{
     [self datePickerForAll];
}
- (IBAction)btndate_startdate:(id)sender
{
     [self datePickerForAll];
}
- (IBAction)btndate_commisindate:(id)sender
{
     [self datePickerForAll];
}
- (IBAction)btndate_completedate:(id)sender
{
    [self datePickerForAll];
}


#pragma mark - THDatePickerDelegate

- (void)datePickerDonePressed:(THDatePickerViewController *)datePicker {
    self.curDate = datePicker.date;
    [self refreshTitle];
    [self dismissSemiModalView];
}

- (void)datePickerCancelPressed:(THDatePickerViewController *)datePicker {
    [self dismissSemiModalView];
}

- (void)datePicker:(THDatePickerViewController *)datePicker selectedDate:(NSDate *)selectedDate {
    NSLog(@"Date selected: %@",[_formatter stringFromDate:selectedDate]);
}

- (IBAction)civil_ChooseFile:(id)sender
{
    
      
    DirectoryBrowserTableViewController *vc  = [self.storyboard instantiateViewControllerWithIdentifier:@"DirectoryBrowserTableViewController"];
    [self.navigationController pushViewController:vc animated:YES];
 
}

- (IBAction)supply_chooseFile:(id)sender {
}
- (IBAction)erection_ChooseFile:(id)sender {
}
- (IBAction)otherFile:(id)sender {
}
- (IBAction)submitbtn:(id)sender
{
    prjSapid = _prj_sapid.text;
    prjname = _prj_name.text;
    wbselement =_prj_WBSelement.text;
    wbsSubElement = _prj_WBSsubelement.text;
    brnumber = _prj_brnumber.text;
    date =_btndate_projDetail.titleLabel.text;
    prjDefination = _prj_defination.text;
    subWbsDetail = _prj_subWBSDetail.text;
    
    inch_sapid = _inch_sapid.text;
    inch_name = _inch_name.text;
    inch_officeAddress = _inch_officeAdd.text;
    
    res_civilAmt = _res_civilAmount.text;
    res_civilAmtFile = _res_civilChooseFile.titleLabel.text;
    res_civilloaNumber =_res_civilLoaNumber.text;
    res_civilDate = _btndate_civil.titleLabel.text;
    
    res_supplyAmt = _res_supplyAmount.text;
    res_supplyAmtFile =_res_supplyChooseFile.titleLabel.text;
    res_supplyloaNumber = _res_supplyLoaNumber.text;
    res_supplyDate = _btndate_supply.titleLabel.text;
    
    res_irectionAmt = _res_erectionAmount.text;
    res_irectionAmtFile =_res_erectionChooseFile.titleLabel.text;
    res_irectionloaNumber = _res_erectionLoaNumber.text;
    res_irectionDate = _btndate_Erection.titleLabel.text;
    
    cont_name = _cont_name.text;
    emp_sapid = _cont_empSapID.text;
    cont_authName = _cont_authName.text;
    cont_Sapid = _cont_sapid.text;
    
    timeline_startdate = _btndate_startdate.titleLabel.text;
    timeline_completedate = _btndate_completedate.titleLabel.text;
    timeline_commisiondate = _btndate_commisiondate.titleLabel.text;
    
    otherfile = _timeline_otherfile.titleLabel.text;
  
    
    if ([[prjSapid stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"SAP ID should not be blank!"];
    }
    else if (prjSapid.length != 6)
    {
        [self.view makeToast:@"SAP ID must be have 5 digit"];
    }
    else if ([[prjname stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Project Name not be blank!"];
    }

    else if ([[wbselement stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"WBS Element should not be blank!"];
    }
    else if ([[wbsSubElement stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"WBS Sub Element should not be blank!"];
    }
    else if ([[brnumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"BR Number should not be blank!"];
    }
    
    else if ([[inch_sapid stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"SAP ID should not be blank!"];
    }
    else if (inch_sapid.length != 5)
    {
        [self.view makeToast:@"SAP ID must be have 5 digit"];
    }

    else if ([[inch_name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Name should not be blank!"];
    }
    

    else if ([[cont_Sapid stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"SAP ID should not be blank!"];
    }
    else if (cont_Sapid.length != 6)
    {
        [self.view makeToast:@"SAP ID must be have 5 digit"];
    }
    
    else if  ([[cont_name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Name  should not be blank!"];
    }
    
    else if ([[emp_sapid stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Employee SAP ID should not be blank!"];
    }
    else if (emp_sapid.length != 6)
    {
        [self.view makeToast:@"SAP ID must be have 5 digit"];
    }
    
    else if ([[cont_authName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Authority Name should not be blank!"];
    }

    else if ([[timeline_startdate stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Start Date should not be blank!"];
    }
    else if  ([[timeline_completedate stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Complete Date  should not be blank!"];
    }
    
    else if ([[timeline_commisiondate stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString: @""])
    {
        [self.view makeToast:@"Commision Date should not be blank!"];
    }
  
    else
    {
        setdic = [[NSMutableDictionary alloc]init];
        [setdic setObject:prjSapid forKey:@"project_sap_id"];
        [setdic setObject:prjname forKey:@"project_name"];
        [setdic setObject:wbselement forKey:@"wbs_element"];
        [setdic setObject:wbsSubElement forKey:@"sub_wbs_element"];
        [setdic setObject:brnumber forKey:@"brno"];
        [setdic setObject:date forKey:@"br_date"];
        [setdic setObject:prjDefination forKey:@"project_defination"];
        [setdic setObject:subWbsDetail forKey:@"sub_wbs_details"];
        [setdic setObject:inch_sapid forKey:@"incharge_sap_id"];
        [setdic setObject:inch_name forKey:@"incharge_name"];
        [setdic setObject:inch_officeAddress forKey:@"incharge_address"];
        [setdic setObject:res_civilAmt forKey:@"project_civil_amount"];
     //   [setdic setObject:res_civilAmtFile forKey:@"project_civil_amount_file"];
        [setdic setObject:res_civilloaNumber forKey:@"civil_loa_number"];
        [setdic setObject:res_civilDate forKey:@"project_civil_date"];
        [setdic setObject:res_supplyAmt forKey:@"project_supply_amount"];
       // [setdic setObject:res_supplyAmtFile forKey:@"project_supply_amount_file"];
        [setdic setObject:res_supplyloaNumber forKey:@"supply_loa_number"];
        [setdic setObject:res_supplyDate forKey:@"project_supply_date"];
        [setdic setObject:res_irectionAmt forKey:@"project_erection_amount"];
       // [setdic setObject:res_irectionAmtFile forKey:@"project_erection_amount_file"];
        [setdic setObject:res_irectionloaNumber forKey:@"erection_loa_number"];
        [setdic setObject:res_irectionDate forKey:@"project_erection_date"];
        [setdic setObject:cont_Sapid forKey:@"contractor_sap_id"];
        [setdic setObject:cont_name forKey:@"contractor_name"];
        [setdic setObject:emp_sapid forKey:@"employee_sap_id"];
        [setdic setObject:cont_authName forKey:@"authority_name"];
        [setdic setObject:timeline_startdate forKey:@"project_start_date"];
        [setdic setObject:timeline_commisiondate forKey:@"project_actual_complete_date"];
        [setdic setObject:timeline_completedate forKey:@"project_schedule_complete_date"];
        [setdic setObject:otherfile forKey:@"other_file_count"];
       
//        [setdic setObject:@"deviceToken" forKey:@"device_token"];
//        [setdic setObject:@"abc" forKey:@"device_id"];
//        [setdic setObject:@"ios" forKey:@"device_type"];
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [ProgressHUD show:@"Please wait..."];
        
        
        [manager POST:[BASE_URL stringByAppendingString:URL_CONTRACTOR_SIGNUP] parameters:setdic progress:nil success:^(NSURLSessionTask *task, id dic12)
         {
             BOOL boolean = [[dic12 valueForKey:@"status"]boolValue];
             
             if (boolean)
             {
//                 SWRevealViewController *tab = [self.storyboard instantiateViewControllerWithIdentifier:@"Contractor_SWRevealViewController"];
//                 
//                 [self storeContractorDataAndGotoNextActivity:[dic12 valueForKey:@"data"]];
//                 [self.navigationController pushViewController:tab animated:YES];
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

@end
