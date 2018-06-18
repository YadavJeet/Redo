//
//  ForgotPasswordView.m
//  REDO
//
//  Created by apple on 11/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "ForgotPasswordView.h"
#import "Header.h"
@interface ForgotPasswordView ()

@end

@implementation ForgotPasswordView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"LOGING.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    [GlobleClass AddPadding:_emailid andNeededright:YES andNeededLeft:YES];
    
    _emailid.layer.borderWidth = 2;
    _emailid.layer.borderColor = [[UIColor whiteColor]CGColor];
    _emailid.layer.masksToBounds = YES;
    
    _submitBTN.layer.borderWidth = 2;
    _submitBTN.layer.borderColor = [[UIColor blackColor]CGColor];
    _submitBTN.layer.masksToBounds = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)SubmitBTN:(id)sender {
    
    if ([_emailid.text isEqualToString:@""]) {
        
        [GlobleClass alertWithMassage:@"Please Fill All The Fields" Title:@"Oppss!!!"];
    }
    else if (![ GlobleClass NSStringIsValidEmail:_emailid.text]) {
        
        [GlobleClass alertWithMassage:@"Enter valid Email ID" Title:@"Alert"];
        
    }
      else
    {
        
        [SVProgressHUD showWithStatus:@"Please Wait..."];
        
        NSDictionary *logins = [[NSDictionary alloc]initWithObjectsAndKeys:_emailid.text,@"email",@"forgot_password" ,@"forgot_password" ,nil];
        
        NSLog(@"my params %@",logins);
        
        [[ServerController sharedController] callServiceSimplifiedPOST: Base_URL_Login userInfo:logins IsLoader:YES delegate:self];
        
    }

}
- (void)requestFinished:(NSDictionary *)dictionary
{
    if ([[[dictionary objectForKey:@"meta"]objectForKey:@"message"]isEqualToString:@"success"])
    {
     
        [self performSegueWithIdentifier:@"login" sender:self];
    }
    else
    {
        [GlobleClass alert:@"server problam please try again"];
        
        
    }
    [SVProgressHUD dismiss];
}

@end
