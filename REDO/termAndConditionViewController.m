//
//  termAndConditionViewController.m
//  REDO
//
//  Created by Navjot Singh on 21/04/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "termAndConditionViewController.h"
#import "Header.h"
#import "cartViewController.h"

@interface termAndConditionViewController ()


@property (weak, nonatomic) IBOutlet UIBarButtonItem *barbutton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Cartbutton;


@end

@implementation termAndConditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Terms & Conditions";
    _barbutton.target = self.revealViewController;
    _barbutton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:true];
    NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
    int cart = [[session objectForKey:@"cardQty"] intValue];
    _Cartbutton.badgeValue = [NSString stringWithFormat:@"%d",cart];
    _Cartbutton.badgeBGColor = [UIColor colorWithRed:0.88 green:1.00 blue:0.10 alpha:1.0];
}

- (IBAction)CartBTN:(id)sender {
    cartViewController *spec = [self.storyboard instantiateViewControllerWithIdentifier:@"cartViewController"];
    [self.navigationController pushViewController:spec animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
