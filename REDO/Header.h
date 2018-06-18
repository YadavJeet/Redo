//
//  mDietGuru
//
//  Created by Navjot Singh on 2/23/16.
//  Copyright (c) 2016 eMeN_Global_Solutions. All rights reserved.
//

#ifndef MdietGuru_Header_h
#define MdietGuru_Header_h

//#define IsdebugMode 1


// Web service config --

#define Base_URL @"http://www.indianhypnosisacademy.com/api/"

#define Base_URL_Login @"http://www.indianhypnosisacademy.com/api/login.php"
#define Base_URL_contactUs @"http://www.indianhypnosisacademy.com/contact-webserviceapi/contact.php"


#pragma Globle imports

#import "ServerController.h"
#import "GlobleClass.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "SWRevealViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "PayPalMobile.h"
#import "UIBarButtonItem+Badge.h"
#import <IQKeyboardReturnKeyHandler.h>

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#endif
