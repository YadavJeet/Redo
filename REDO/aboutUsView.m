//
//  aboutUsView.m
//  REDO
//
//  Created by apple on 09/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "aboutUsView.h"
#import "cartViewController.h"
#import "Header.h"
@interface aboutUsView ()
{
    int cart;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barbutton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Cartbutton;

@end

@implementation aboutUsView

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:true];
    NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
     cart = [[session objectForKey:@"cardQty"] intValue];
    _Cartbutton.badgeValue = [NSString stringWithFormat:@"%d",cart];
    _Cartbutton.badgeBGColor = [UIColor colorWithRed:0.88 green:1.00 blue:0.10 alpha:1.0];
}

- (IBAction)CartBTN:(id)sender {
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"About Us";
    _barbutton.target = self.revealViewController;
    _barbutton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
