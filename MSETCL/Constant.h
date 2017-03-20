//
//  Constant.h
//  Runmileapp
//
//  Created by Tecksky Techonologies on 9/2/16.
//  Copyright © 2016 Tecksky Techonologies. All rights reserved.
//

#ifndef Constant_h
#define Constant_h


#define REGEX_NAME_EXPRESS @"^[\\p{L} .'-]+$"
#define REGEX_EMAIL_EXPRESS @"^[A-Za-z0-9]+([\\.\\-_]{1}[A-Za-z0-9]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+){0,1}(\\.[A-Za-z]{2,4})$"
//#define REGEX_PASSWORD_LIMIT @"[A-Za-z0-9]{6,20}"
//#define REGEX_TEXTVIEW @"[\\S ]{3,}"
#define REGEX_MOBILE_EXPRESS @"^[+]?[0-9]{10,13}$"
#define REGEX_IND_ZIP_EXPRESS @"^[0-9]{6}$"


//Default Base URL
#define BASE_URL @"http://mumbairealtyexperts.in/msetcl/public/"

//Nsuser Default Store
#define DEF_IS_LOGIN @"def_is_login"
#define DEF_DEFAULT_RESPONSE @"def_default_response"
#define DEF_USER_TOKEN @"def_user_token"
#define DEF_SAP_ID @"def_sap_id"
#define DEF_USER_TYPE @"def_user_type"
#define DEF_ID @"def_id"
#define DEF_PASSWORD @"def_password"
#define DEF_USERNAME @"def_username"
#define DEF_EMAIL @"def_email"
#define DEF_MOBILE @"def_mobile"
#define DEF_AGENCI_NAME @"def_agenci_name"
#define DEF_ADDRESS @"def_address"
#define DEF_PINCODE @"def_pincode"



//Default Config
#define WS_DEFAULT_CONFIG @"ws_default_config"
#define URL_DEFAULT_CONFIG @"api/v1/default_config"

//Get District
#define URL_GET_DISTRICT @"api/v1/default_config/get_district"

//Get City
#define URL_GET_CITY @"api/v1/default_config/get_city"

//Get Circle
#define URL_GET_CIRCLE @"api/v1/default_config/get_circle"

//Get Division
#define URL_GET_DIVISION @"api/v1/default_config/get_division"

//Get Sub Division
#define URL_GET_SUB_DIVISION @"api/v1/default_config/get_sub_division"

//Contractor Signup
#define URL_CONTRACTOR_SIGNUP @"api/v1/contractor/register"

//Contractor Login
#define URL_CONTRACTOR_LOGIN @"api/v1/contractor/login"

//Employee Login
#define URL_EMPLOYEE_LOGIN @"api/v1/employee/login"

//Change Password
#define URL_CHANGE_PASSWORD @"api/v1/contractor/change_password"

//Get Issue Type
#define URL_GET_ISSUE_TYPE @"api/v1/issue_type"

//Get Issue Type Fields
#define URL_GET_ISSUE_TYPE_FIELDS @"api/v1/issue_type_field/"

//Contractor Submit Issue
#define URL_SUBMIT_ISSUE @"api/v1/issue"

//Contractor Get Issue Type
#define URL_GET_CONTRACTOR_ISSUE_TYPE @"api/v1/contractor_issue_type"

//Contractor Get Issue Type Fields
 #define URL_GET_CONTRACTOR_ISSUE_TYPE_FIELDS @"api/v1/contractor_issue_type_field/"


//Contractor Update Profile
#define URL_CONTRACTOR_UPDATE_PROFILE @"api/v1/contractor/update_profile"

//Employee Update Profile
#define URL_EMPLOYEE_UPDATE_PROFILE @"api/v1/employee/update_profile"

//Contractor Get Issue
#define URL_CONTRACTOR_GET_ISSUE @"api/v1/issue"

//News Letter
#define URL_NEWS_LETTER @"api/v1/newsletter"

//FAQ
#define URL_GET_FAQ @"api/v1/faq"

//Contractor Projects
#define URL_PROJECTS_CONTRACTOR @"api/v1/project"


//Contractor Projects List
#define URL_PROJECTS_LIST_CONTRACTOR @"api/v1/project/all_project"

//Contractor Issue Detail
//#define URL_CONTRACTOR_ISSUE_DETAIL @"api/v1/contractor_issue/"

//Contractor Logout
#define URL_CONTRACTOR_LOGOUT @"api/v1/contractor/logout"


//Get Employees Assign Issues
#define URL_EMPLOYEE_ISSUE_TYPE @"api/v1/issue/assign_issue_list"

//Proceed Assign Issues Employee
#define URL_EMPLOYEE_PROCEED_ASSIGN_ISSUE @"api/v1/issue/proceed_assign_issue"

//Contractor issue Details
#define URL_CONTRACTOR_ISSUE_DETAILS @"api/v1/project/issue/"

#endif /* Constant_h */

