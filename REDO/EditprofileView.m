//
//  EditprofileView.m
//  REDO
//
//  Created by apple on 16/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "EditprofileView.h"
#import "Header.h"
@interface EditprofileView ()

@end

@implementation EditprofileView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
    [SVProgressHUD showWithStatus:@"Please Wait..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:[session objectForKey:@"userID"], @"id",nil];
    
    NSLog(@"my params %@",params);
    
    [[ServerController sharedController] callServiceSimplifiedPOST:@"http://www.indianhypnosisacademy.com/api/login.php" userInfo:params IsLoader:false delegate:self];
    // Do any additional setup after loading the view.
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y-100);
    [_SV setContentOffset:scrollPoint animated:NO];
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    
    [_SV setContentOffset:CGPointZero animated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)requestFinished:(NSDictionary *)dictionary
{
    NSLog(@"Respons :- %@ ", dictionary);
    _firstname.text = [dictionary valueForKey:@"first_name"];
    _username.text = [dictionary valueForKey:@"user_login"];
    _emailid.text = [dictionary valueForKey:@"user_email"];
    _lastname.text = [dictionary valueForKey:@"last_name"];
    
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)updateBTN:(id)sender
{
    
}
@end
//http://www.indianhypnosisacademy.com/api/login.php
