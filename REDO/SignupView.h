//
//  SignupView.h
//  REDO
//
//  Created by apple on 09/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupView : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *signupBTN;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *firstname;
@property (weak, nonatomic) IBOutlet UITextField *lastname;
@property (weak, nonatomic) IBOutlet UITextField *emailid;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *repassword;
@property (strong, nonatomic) IBOutlet UIScrollView *SV;
@end
