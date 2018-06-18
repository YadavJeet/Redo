//
//  SignupView.m
//  REDO
//
//  Created by apple on 09/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "SignupView.h"
#import "Header.h"

@interface SignupView ()

@end

@implementation SignupView

- (void)viewDidLoad {
    [super viewDidLoad];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"LOGING.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    [(UIButton *)[self.view viewWithTag:101] addTarget:self action:@selector(signinBTN) forControlEvents:UIControlEventTouchUpInside];
    
    
    [GlobleClass AddPadding:_userName andNeededright:YES andNeededLeft:YES];
    [GlobleClass AddPadding:_firstname andNeededright:YES andNeededLeft:YES];
    [GlobleClass AddPadding:_lastname andNeededright:YES andNeededLeft:YES];
    [GlobleClass AddPadding:_emailid andNeededright:YES andNeededLeft:YES];
    [GlobleClass AddPadding:_password andNeededright:YES andNeededLeft:YES];
    [GlobleClass AddPadding:_repassword andNeededright:YES andNeededLeft:YES];
    
    _userName.layer.borderWidth = 2;
    _userName.layer.borderColor = [[UIColor whiteColor]CGColor];
    _userName.layer.masksToBounds = YES;
    _firstname.layer.borderWidth = 2;
    _firstname.layer.borderColor = [[UIColor whiteColor]CGColor];
    _firstname.layer.masksToBounds = YES;
    _lastname.layer.borderWidth = 2;
    _lastname.layer.borderColor = [[UIColor whiteColor]CGColor];
    _lastname.layer.masksToBounds = YES;
    _emailid.layer.borderWidth = 2;
    _emailid.layer.borderColor = [[UIColor whiteColor]CGColor];
    _emailid.layer.masksToBounds = YES;
    _password.layer.borderWidth = 2;
    _password.layer.borderColor = [[UIColor whiteColor]CGColor];
    _password.layer.masksToBounds = YES;
    _repassword.layer.borderWidth = 2;
    _repassword.layer.borderColor = [[UIColor whiteColor]CGColor];
    _repassword.layer.masksToBounds = YES;
    _signupBTN.layer.borderWidth = 2;
    _signupBTN.layer.borderColor = [[UIColor blackColor]CGColor];
    _signupBTN.layer.masksToBounds = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)signinBTN {
    
    if ([_userName.text isEqualToString:@""] || [_firstname.text isEqualToString:@""]|| [_lastname.text isEqualToString:@""]|| [_emailid.text isEqualToString:@""]|| [_password.text isEqualToString:@""]|| [_repassword.text isEqualToString:@""]) {
        
        [GlobleClass alertWithMassage:@"Please Fill All The Fields" Title:@"Oppss!!!"];
    }
    else if (![ GlobleClass NSStringIsValidEmail:_emailid.text]) {
        
        [GlobleClass alertWithMassage:@"Enter valid Email ID" Title:@"Alert"];
        
    }
    else if (_password.text.length<4)
    {
        [GlobleClass alertWithMassage:@"Password should be 4 charecters" Title:@"Alert"];
        
    }else if (_password.text != _repassword.text){
        
        [GlobleClass alertWithMassage:@"Password does not match" Title:@"Alert"];
    }
    else
    {
        
        [SVProgressHUD showWithStatus:@"Please Wait..."];
        
        NSDictionary *logins = [[NSDictionary alloc]initWithObjectsAndKeys:_userName.text, @"userName",_firstname.text,@"firstName",_lastname.text,@"lastName",_emailid.text,@"email",_password.text,@"password",@"register" ,@"register" ,nil];
        
        NSLog(@"my params %@",logins);
        
        [[ServerController sharedController] callServiceSimplifiedPOST: Base_URL_Login userInfo:logins IsLoader:YES delegate:self];
        
    }
    
}

- (void)requestFinished:(NSDictionary *)dictionary
{
    if ([[dictionary objectForKey:@"status"]boolValue]) {
     /*   NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
        [session setObject:[dictionary valueForKey:@"user_id"] forKey:@"userID"];
        [session setBool:true forKey:@"login"];
        [session  setObject:@"0" forKey:@"cardQty"];
        [session synchronize];
      */
        [GlobleClass alert:[NSString stringWithFormat:@"%@ , Please Login.",[dictionary objectForKey:@"msg"]]];
        [self performSegueWithIdentifier:@"signup" sender:self];
    }
    
    else
    {
        [GlobleClass alert:@"server problam please try again"];
    }
    [SVProgressHUD dismiss];
}


@end
