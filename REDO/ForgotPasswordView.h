//
//  ForgotPasswordView.h
//  REDO
//
//  Created by apple on 11/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordView : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailid;
- (IBAction)SubmitBTN:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitBTN;

@end
