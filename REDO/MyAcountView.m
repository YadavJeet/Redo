//
//  MyAcountView.m
//  REDO
//
//  Created by apple on 11/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "MyAcountView.h"
#import "cartViewController.h"
#import "Header.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface MyAcountView ()
{
    int cart;
}
@property (weak, nonatomic) IBOutlet UILabel *emailLBL;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barbutton;

@end

@implementation MyAcountView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _emailLBL.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"emailID"];
    
    _barbutton.target = self.revealViewController;
    _barbutton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    UIImage* img = [[UIImage alloc] init];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"profileImage"] != nil){
        NSData *profileData = [[NSData alloc] initWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"profileImage"]];
        img = [[UIImage alloc] initWithData:profileData];
    }else{
        img = [UIImage imageNamed:@"userimage.png"];
    }
    [_image setImage:img];
}
- (IBAction)myorderBTN:(id)sender {
}
- (IBAction)changepswBTN:(id)sender {
}
- (IBAction)editBTN:(id)sender {
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier isEqualToString:@"logout"]) {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"emailID"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userID"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"login"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cardQty"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"profileImage"];
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
        [loginManager logOut];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logoutBTN:(id)sender {
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:true];
    NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
     cart = [[session objectForKey:@"cardQty"] intValue];
    _Cartbutton.badgeValue = [NSString stringWithFormat:@"%d",cart];
    _Cartbutton.badgeBGColor = [UIColor colorWithRed:0.88 green:1.00 blue:0.10 alpha:1.0];
}


- (IBAction)Cartview:(id)sender {
    if (cart == 0)
    {
        [GlobleClass alertWithMassage:@"Your cart is empty , keep shopping !!" Title:@"Alert"];
    }
    else
    {
        cartViewController *spec = [self.storyboard instantiateViewControllerWithIdentifier:@"cartViewController"];
        [self.navigationController pushViewController:spec animated:YES];
    }

    
}
@end
