//
//  ChangepasswordView.m
//  REDO
//
//  Created by apple on 16/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "ChangepasswordView.h"
#import "Header.h"
@interface ChangepasswordView ()

@end

@implementation ChangepasswordView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitBTN:(id)sender {
    if ([_oldpassword.text isEqualToString:@""] || [_newpasword.text isEqualToString:@""] || [_repassword.text isEqualToString:@""]) {
        [GlobleClass alertWithMassage:@"Please Fill All The Fields "Title:@"Oppss!!!"];
        
    }
    else if ([_oldpassword.text isEqual:_newpasword.text])
    {
        [GlobleClass alert:@"Same Password as previous!"];
        _repassword.text = @"";
        _newpasword.text = @"";
        [_newpasword becomeFirstResponder];
        
    }
    else if (![_newpasword.text isEqual:_repassword.text])
    {
        [GlobleClass alert:@"Password Doesn't Match"];
        _repassword.text = @"";
        _newpasword.text = @"";
        [_newpasword becomeFirstResponder];
    }
    else if (_newpasword.text.length<4)
    {
        [GlobleClass alertWithMassage:@"Password should be 4 charecters or more" Title:@"Alert"];
        
    }
    else
    {
         NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
        [SVProgressHUD showWithStatus:@"Please Wait..."];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:_newpasword.text, @"new_pass",_repassword.text,@"c_pass",[session objectForKey:@"userID"], @"userid",@"reset_password",@"reset_password" ,nil];
        
        NSLog(@"my params %@",params);
        
        [[ServerController sharedController] callServiceSimplifiedPOST:@"http://www.indianhypnosisacademy.com/api/login.php" userInfo:params IsLoader:false delegate:self];
        
    }

}

- (void)requestFinished:(NSDictionary *)dictionary
{
    NSLog(@"Respons :- %@ ", dictionary);
    [GlobleClass alert:@"password changed successfully"];
    
    [SVProgressHUD dismiss];
}

@end
