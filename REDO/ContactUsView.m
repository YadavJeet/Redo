//
//  ContactUsView.m
//  REDO
//
//  Created by apple on 18/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "ContactUsView.h"
#import "cartViewController.h"
#import "Header.h"
#import <MapKit/MapKit.h>

@interface ContactUsView ()<MKMapViewDelegate>
{
    int cart;
}
@property (weak, nonatomic) IBOutlet MKMapView *mepview;
@end

@implementation ContactUsView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mepview.delegate =  self;
    self.mepview.showsUserLocation = YES;
    [_mepview setMapType:MKMapTypeStandard];
    
    _barbutton.target = self.revealViewController;
    _barbutton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitBTN:(id)sender
{
    if ([_name.text isEqualToString:@""] || [_emailid.text isEqualToString:@""]|| [_message.text isEqualToString:@""])
    {
        [GlobleClass alertWithMassage:@"Please Fill All The Fields" Title:@"Oppss!!!"];
    }
    else
    {
        [SVProgressHUD showWithStatus:@"Please Wait..."];
        NSDictionary *logins = [[NSDictionary alloc]initWithObjectsAndKeys:_emailid.text, @"email",_name.text,@"name",@"contact-form-submit",@"tag",_message.text ,@"message",nil];
        [[ServerController sharedController] callServiceSimplifiedPOST: Base_URL_contactUs userInfo:logins IsLoader:YES delegate:self];
    }
}

- (void)requestFinished:(NSDictionary *)dictionary
{
    NSLog(@"my response %@",dictionary);
    
    [GlobleClass alertWithMassage:@"We have successfully received your Message and will get Back to you as soon as possible" Title:@"Alert"];
    [SVProgressHUD dismiss];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:true];
    NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
    cart = [[session objectForKey:@"cardQty"] intValue];
    _Cartbutton.badgeValue = [NSString stringWithFormat:@"%d",cart];
    _Cartbutton.badgeBGColor = [UIColor colorWithRed:0.88 green:1.00 blue:0.10 alpha:1.0];
}

- (IBAction)CartBTN:(id)sender
{
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
