//
//  paymentView.m
//  REDO
//
//  Created by apple on 10/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "paymentView.h"
#import "MainView.h"
#import "PayPalMobile.h"
#import "PayPalConfiguration.h"
#import "PayPalPaymentViewController.h"
#import "Header.h"
#import <PayUmoney_SDK/PayUmoney_SDK.h>
#import <CommonCrypto/CommonDigest.h>

@interface paymentView ()<PayPalPaymentDelegate>
{
    NSDictionary *dictionarypaypal;
    NSString *useridnew;
    NSString *newname;
    NSString *emailnew;
    NSData *profileData;
    NSInteger paypalprice;
}
@property(nonatomic,strong)PayPalConfiguration *payPalConfig;

@property (nonatomic, strong) PUMRequestParams *params;

@end

@implementation paymentView

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    [self paypalmetod];
    
    useridnew = [[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
    newname = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    emailnew  = [[NSUserDefaults standardUserDefaults]objectForKey:@"emailID"];
    profileData = [[NSData alloc] initWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"profileImage"]];
    
    NSLog(@"%@", _productid);
    
    NSInteger abc = [@"63.00" integerValue];
    NSInteger bcd = [_productPrice integerValue];
    paypalprice = bcd/abc;
    NSLog(@"%ld", (long)paypalprice);
    
    _AmountLBL.text = [NSString stringWithFormat:@"Rs. %@ (USD %ld)",_productPrice,(long)paypalprice];
    
    // _AmountLBL.text = @"1";

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentProduction];
}

- (IBAction)PaypalBTN:(id)sender
{
//#warning changeDolarPRice
    
   
    PayPalItem *item1;
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    
    item1 = [PayPalItem itemWithName:@"Membership"  withQuantity:1 withPrice:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%ld",(long)paypalprice]] withCurrency:@"USD" withSku:@"Sku-fund"];
    payment.shortDescription = @"Membership";
    
    NSArray *items = @[item1];
    NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
    
    NSDecimalNumber *shipping = [[NSDecimalNumber alloc] initWithString:@"0"];
    
    NSDecimalNumber *tax = [[NSDecimalNumber alloc] initWithString:@"0"];
    
    PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal withShipping:shipping withTax:tax];
    
    NSDecimalNumber *total = [[subtotal decimalNumberByAdding:shipping] decimalNumberByAdding:tax];
    
    payment.amount = total;
    payment.currencyCode = @"USD";
    payment.items = items;
    payment.paymentDetails = paymentDetails;
    
    if (!payment.processable)
    {
        [GlobleClass alert:@"Payment Not Processable"];
    }
    
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment configuration:self.payPalConfig delegate:self];
    
    [self presentViewController:paymentViewController animated:YES completion:nil];
}

-(void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self showAlertViewWithTitle:@"Message" message:@"Payment Cancelled!"];
}

-(void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment{
    
   // [self dismissViewControllerAnimated:YES completion:nil];
    dictionarypaypal = [[NSDictionary alloc] initWithDictionary:completedPayment.confirmation[@"response"]];
    NSDictionary *params;
    [SVProgressHUD showWithStatus:@"Please Wait..."];
    
    if (!(_fromID == nil))
    {
        params = [[NSDictionary alloc]initWithObjectsAndKeys:@"success", @"status",@"1",@"updateOrder",_fromID,@"form_id",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"],@"userid",[dictionarypaypal objectForKey:@"id"],@"txn_id", nil];
        [[ServerController sharedController] callServiceSimplifiedPOST:@"http://www.indianhypnosisacademy.com/api/custom.php" userInfo:params IsLoader:YES delegate:self];
        
    }
    else{
     params = [[NSDictionary alloc]initWithObjectsAndKeys:@"success", @"status",@"paypal",@"payment_type",@"1",@"councelling_payment",_productid,@"order_id", nil];
        
        [[ServerController sharedController] callServiceSimplifiedPOST:@"http://www.indianhypnosisacademy.com/api/cart.php" userInfo:params IsLoader:YES delegate:self];
    }
    
}


-(void)paypalmetod
{
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = YES;
    _payPalConfig.merchantName = @"PayPal";
    
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    
    _payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionNone;
    
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    
    NSLog(@"Paypal : %@",[PayPalMobile libraryVersion]);
    
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if ([segue.identifier isEqualToString: @"payU"]) {
//        NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
//        [session setValue:_productPrice forKey:@"payUprice"];
//        [session synchronize];
//    }
//}

- (IBAction)payUmoney:(UIButton *)sender
{
    
    [self setPaymentParameters];
    
    //Start the payment flow
    PUMMainVController *paymentVC = [[PUMMainVController alloc] init];
    UINavigationController *paymentNavController = [[UINavigationController alloc] initWithRootViewController:paymentVC];
    
    [self presentViewController:paymentNavController
                       animated:YES
                     completion:nil];
    
}

- (void)setPaymentParameters {
    
    NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"%@",[session valueForKey:@"username"]);
    NSLog(@"%@",[session valueForKey:@"emailID"]);
    
    self.params = [PUMRequestParams sharedParams];
    self.params.environment = PUMEnvironmentProduction;
    self.params.amount = _productPrice;
    self.params.key = @"FzmbM7nv";
    self.params.merchantid = @"5671130";
    self.params.txnid = [self getRandomString:2];
    self.params.surl = @"https://www.payumoney.com/mobileapp/payumoney/success.php";
    self.params.furl = @"https://www.payumoney.com/mobileapp/payumoney/failure.php";
    self.params.productinfo = _productinfo;
    self.params.delegate = self;
    self.params.firstname = [session valueForKey:@"username"];
    
    if ([session valueForKey:@"emailID"]) {
        self.params.email = [session valueForKey:@"emailID"];
        self.params.phone = @"";

    }else
    {
        self.params.email = @"jitendra2010gwl@gmail.com";
        self.params.phone = @"9229791853";
    }
    
    //Below parameters are optional. It is to store any information you would like to save in PayU Database regarding trasnsaction. If you do not intend to store any additional info, set below params as empty strings.
    
    self.params.udf1 = @"";
    self.params.udf2 = @"";
    self.params.udf3 = @"";
    self.params.udf4 = @"";
    self.params.udf5 = @"";
    self.params.udf6 = @"";
    self.params.udf7 = @"";
    self.params.udf8 = @"";
    self.params.udf9 = @"";
    self.params.udf10 = @"";
    
    NSLog(@"%@",self.params);
    
    self.params.hashValue = [self getHash];
}


- (NSString *)getRandomString:(NSInteger)length {
    NSMutableString *returnString = [NSMutableString stringWithCapacity:length];
    NSString *numbers = @"0123456789";
    
    // First number cannot be 0
    [returnString appendFormat:@"%C", [numbers characterAtIndex:(arc4random() % ([numbers length]-1))+1]];
    
    for (int i = 1; i < length; i++) {
        [returnString appendFormat:@"%C", [numbers characterAtIndex:arc4random() % [numbers length]]];
    }
    return returnString;
}


#pragma mark - Never Generate hash from app
/*!
 Keeping salt in the app is a big security vulnerability. Never do this. Following function is just for demonstratin purpose
 In code below, salt Je7q3652 is mentioned. Never do this in prod app. You should get the hash from your server.
 */

- (NSString*)getHash {
    NSString *hashSequence = [NSString stringWithFormat:@"FzmbM7nv|%@|%@|%@|%@|%@|||||||||||dC3tXfjJD3",self.params.txnid, self.params.amount, self.params.productinfo,self.params.firstname, self.params.email];
    
    NSString *rawHash = [[self createSHA512:hashSequence] description];
    NSString *hash = [[[rawHash stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return hash;
}

- (NSData *) createSHA512:(NSString *)source {
    
    const char *s = [source cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH] = {0};
    CC_SHA512(keyData.bytes, (CC_LONG)keyData.length, digest);
    
    NSData *output = [NSData dataWithBytes:digest length:CC_SHA512_DIGEST_LENGTH];
    NSLog(@"out --------- %@",output);
    return output;
}

#pragma mark - Completion callbacks

-(void)transactionCompletedWithResponse:(NSDictionary*)response
                       errorDescription:(NSError* )error {
    NSLog(@"new id %@",useridnew);
     [[NSUserDefaults standardUserDefaults ]setObject:useridnew forKey:@"userID"];
    NSDictionary *params;
    [SVProgressHUD showWithStatus:@"Please Wait..."];
    
    if (!(_fromID == nil))
    {
        params = [[NSDictionary alloc]initWithObjectsAndKeys:@"success", @"status",@"1",@"updateOrder",_fromID,@"form_id",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"],@"userid",[dictionarypaypal objectForKey:@"id"],@"txn_id", nil];
        [[ServerController sharedController] callServiceSimplifiedPOST:@"http://www.indianhypnosisacademy.com/api/custom.php" userInfo:params IsLoader:YES delegate:self];
    }
    else{
         params = [[NSDictionary alloc]initWithObjectsAndKeys:@"success", @"status",@"payuindia",@"payment_type",@"1",@"updateOrder",_productid,@"order_id", nil];
        [[ServerController sharedController] callServiceSimplifiedPOST:@"http://www.indianhypnosisacademy.com/api/cart.php" userInfo:params IsLoader:YES delegate:self];
    }

    NSLog(@"Payment Complete %@",dictionarypaypal);
    
   
}

-(void)transactinFailedWithResponse:(NSDictionary* )response
                   errorDescription:(NSError* )error
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
   // [self showAlertViewWithTitle:@"Message" message:@"Oops!!! Payment Failed"];
    [self passVC];
    [GlobleClass alertWithMassage:@"Oops!!! Payment Failed" Title:@"Message"];

}

-(void)transactinExpiredWithResponse: (NSString *)msg {
    
    [self dismissViewControllerAnimated:YES completion:nil];
   // [self showAlertViewWithTitle:@"Message" message:@"Trasaction expired!"];
    [self passVC];
    [GlobleClass alertWithMassage:@"Trasaction expired!" Title:@"Message"];

}

/*!
 * Transaction cancelled by user.
 */
-(void)transactinCanceledByUser
{
  //  [self showAlertViewWithTitle:@"Message" message:@"Payment Cancelled!"];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self passVC];

    [GlobleClass alertWithMassage:@"Payment Cancelled!" Title:@"Message"];
}

#pragma mark - Helper methods

- (void)showAlertViewWithTitle:(NSString*)title message:(NSString*)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)requestFinished:(NSDictionary *)dictionary
{
    if (!(_productid==nil))
    {
        [self passVC];
        NSLog(@"Respons :- %@ ", dictionary);
        [GlobleClass alertWithMassage:@"congrats! Payment is Successful" Title:@"Message"];
    }
    else if (!(_fromID ==nil))
    {
         [self passVC];
        [GlobleClass alertWithMassage:@"congrats! Payment is Successful" Title:@"Message"];
    }
    else{
        [SVProgressHUD dismiss];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}
-(void)passVC
{
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"login"];
    [[NSUserDefaults standardUserDefaults ]setObject:useridnew forKey:@"userID"];
    
    [[NSUserDefaults standardUserDefaults ]setObject:newname forKey:@"username"];
    
    [[NSUserDefaults standardUserDefaults ]setObject:profileData forKey:@"profileImage"];
    
    [[NSUserDefaults standardUserDefaults ]setObject:emailnew forKey:@"emailID"];

    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIStoryboard *mainstory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWRevealViewController *home = [mainstory instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:home];
    nav.navigationBarHidden = YES;
    app.window.rootViewController = nil;
    app.window.rootViewController = nav;
    
    [SVProgressHUD dismiss];

}
@end
