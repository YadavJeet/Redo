 //
//  ViewController.m
//  REDO
//
//  Created by apple on 09/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "Header.h"
@interface ViewController ()<FBSDKLoginButtonDelegate>
{
     FBSDKLoginButton *loginButton;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftbutton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [(UIButton *)[self.view viewWithTag:102] addTarget:self action:@selector(LoginBTN) forControlEvents:UIControlEventTouchUpInside];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"LOGING.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    [GlobleClass AddPadding:_emailtxtfld andNeededright:YES andNeededLeft:YES];
    [GlobleClass AddPadding:_passwordtxtfld andNeededright:YES andNeededLeft:YES];
    
    _passwordtxtfld.layer.borderWidth = 2;
    _passwordtxtfld.layer.borderColor = [[UIColor whiteColor]CGColor];
    _passwordtxtfld.layer.masksToBounds = YES;
    
    _emailtxtfld.layer.borderWidth = 2;
    _emailtxtfld.layer.borderColor = [[UIColor whiteColor]CGColor];
    _emailtxtfld.layer.masksToBounds = YES;
    
    _loginBTN.layer.borderWidth = 2;
    _loginBTN.layer.borderColor = [[UIColor blackColor]CGColor];
    _loginBTN.layer.masksToBounds = YES;
    
    loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.hidden = YES;
    [self.view addSubview:loginButton];
    loginButton.readPermissions =@[@"public_profile",@"email"];
    loginButton.delegate = self;
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"id,name,email,gender" forKey:@"fields"];
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
     {
         if (!error)
         {
             NSLog(@"zad1 %@",result);
         }
     }];
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    
}

-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
        [SVProgressHUD showWithStatus:@"Please Wait...\nIt may take couple of seconds."];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setValue:@"id,name,email,gender,birthday,last_name,first_name,locale,hometown,cover, picture" forKey:@"fields"];
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
         {
             if (!error) {
                 NSLog(@"zad %@",result);
                 NSLog(@"zad1111 %@",[[[result objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"]);
                 
               // userName(mandatory),email(mandatory),fb_register(mandatory,any random value)
                 
                 NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:
                    [result objectForKey:@"name"],@"userName",@"fb_register",@"fb_register",[result objectForKey:@"email"],@"email", nil];
                 
                 NSLog(@"LoginPAram %@",params);
                 
                 NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",[result objectForKey:@"id"]]];
                 [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:pictureURL] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                     if (!connectionError) {
                         
                         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                         [defaults setObject:data forKey:@"profileImage"];
                         [defaults synchronize];
                         
                     }
                     else
                     {
                         NSLog(@"%@",connectionError);
                     }
                 }];
                 
                 [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
                 [[ServerController sharedController] callServiceSimplifiedPOST:@"http://www.indianhypnosisacademy.com/api/login.php" userInfo:params IsLoader:YES delegate:self];
             }
         }];
        [FBSDKAccessToken setCurrentAccessToken:nil];
    }
    else
    {
    
    }
}
- (IBAction)myButtonPressed:(id)sender
{
    [self myButtonPressed1];
}

- (void)myButtonPressed1 {
    [loginButton sendActionsForControlEvents: UIControlEventTouchUpInside];
}

- (void)LoginBTN {
    
    if ([_passwordtxtfld.text isEqualToString:@""] || [_emailtxtfld.text isEqualToString:@""])
    {
        [GlobleClass alertWithMassage:@"Please Fill All The Fields" Title:@"Oppss!!!"];
    }
    
    else if (_passwordtxtfld.text.length<4)
    {
        [GlobleClass alertWithMassage:@"Password should be 4 charecters" Title:@"Alert"];
    }
    else
    {
        [SVProgressHUD showWithStatus:@"Please Wait..."];
        
        NSDictionary *logins = [[NSDictionary alloc]initWithObjectsAndKeys:_emailtxtfld.text, @"userName",_passwordtxtfld.text,@"password",@"login",@"login",nil];
        [[ServerController sharedController] callServiceSimplifiedPOST: Base_URL_Login userInfo:logins IsLoader:YES delegate:self];
    }
}

- (void)requestFinished:(NSDictionary *)dictionary
{
    NSLog(@"my response %@",dictionary);
    
    if ([dictionary objectForKey:@"data"]!=nil)
    {
        NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
        
        NSString *Nullvalue = [[dictionary objectForKey:@"data"] valueForKey:@"email"];
        
        if (Nullvalue == (id)[NSNull null]||[Nullvalue length]==0 )
        {
            
        }
        else
        {
        [session setObject:[[dictionary objectForKey:@"data"] valueForKey:@"email"] forKey:@"emailID"];
        }
       
        [session setObject:[[dictionary objectForKey:@"data"] valueForKey:@"name"] forKey:@"username"];
        [session setObject:[[dictionary objectForKey:@"data"] valueForKey:@"user_id"] forKey:@"userID"];
        [session setBool:true forKey:@"login"];
        [session  setObject:@"0" forKey:@"cardQty"];
        [session synchronize];
        
        [self performSegueWithIdentifier:@"login" sender:self];
    
    }
    else if ([[dictionary objectForKey:@"status"]boolValue] ==true) {
        
        NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
        [session setObject:[dictionary valueForKey:@"email"] forKey:@"emailID"];
        [session setObject:[dictionary valueForKey:@"usrName"] forKey:@"username"];
        [session setObject:[dictionary valueForKey:@"ID"] forKey:@"userID"];
        [session setBool:true forKey:@"login"];
        [session  setObject:@"0" forKey:@"cardQty"];

        [session synchronize];
        [self performSegueWithIdentifier:@"login" sender:self];
    }
    else
    {
        [GlobleClass alert:@"Invalid ID and Password "];
        _emailtxtfld.text = @"";
        _passwordtxtfld.text = @"";
        
    }
    [SVProgressHUD dismiss];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
