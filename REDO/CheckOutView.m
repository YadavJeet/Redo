//
//  CheckOutView.m
//  REDO
//
//  Created by apple on 15/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "CheckOutView.h"
#import "cartViewController.h"
#import "paymentView.h"
#import "PlaceOrder.h"
#import "Header.h"
#import <CoreLocation/CoreLocation.h>
#import <AddressBookUI/AddressBookUI.h>

@interface CheckOutView ()<UITextFieldDelegate>
{
    UIPickerView *picker;
    NSArray * statedata;
}

@end

@implementation CheckOutView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSLog(@"%@",_productPrice);
    NSLog(@"%@", _cartID);
}

- (IBAction)ProceedBTN:(id)sender {
    
    if ([_firestname.text isEqualToString:@""] || [_lastname.text isEqualToString:@""]||[_mobilename.text isEqualToString:@""]||     [_emailname.text isEqualToString:@""]) {
        
        [GlobleClass alertWithMassage:@"Please Fill All The Fields" Title:@"Oppss!!!"];
    }
    else if (![ GlobleClass NSStringIsValidEmail:_emailname.text]) {
        
        [GlobleClass alertWithMassage:@"Enter valid Email ID" Title:@"Alert"];
        
    }
    else
    {
        NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
        [SVProgressHUD showWithStatus:@"Please Wait..."];
        
        NSDictionary *param = [[NSDictionary alloc]initWithObjectsAndKeys:_firestname.text, @"billing_first_name" , _lastname.text,@"billing_last_name" ,@"",@"billing_company",_emailname.text,@"billing_email",@"",@"billing_address_1",_mobilename.text,@"billing_phone",@"",@"billing_postcode",@"",@"billing_city",@"",@"billing_state",@"checkout" ,@"checkout" ,[session objectForKey:@"userID"], @"userid",@"", @"billing_country",nil];
        
        NSLog(@"my params %@",param);
        
        [[ServerController sharedController] callServiceSimplifiedPOST: @"http://www.indianhypnosisacademy.com/api/cart.php" userInfo:param IsLoader:YES delegate:self];
        
    }
}

- (void)requestFinished:(NSDictionary *)dictionary
{
    NSLog(@"Respons :- %@ ", dictionary);
    
    PlaceOrder *spec = [self.storyboard instantiateViewControllerWithIdentifier:@"PlaceOrder"];
    spec.productData = dictionary;
    spec.cartID = _cartID;
    [self.navigationController pushViewController:spec animated:YES];
    
    [SVProgressHUD dismiss];
}



@end
