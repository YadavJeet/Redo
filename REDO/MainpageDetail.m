    //
//  MainpageDetail.m
//  REDO
//
//  Created by apple on 10/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "MainpageDetail.h"
#import "paymentView.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface MainpageDetail ()
{
    AVAudioPlayer *audioPlayer;
    MPMoviePlayerViewController *moviePlayer;
    NSString*userid;
    int serviceNo;
}

@property (weak, nonatomic) IBOutlet UIButton *buyBTN;
@property (weak, nonatomic) IBOutlet UIButton *PlayBTN;

@end

@implementation MainpageDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _buyBTN.hidden = YES;
    _PlayBTN.hidden = YES;
    NSLog(@"Product Id - %@",_productID);
    NSLog(@"Product name - %@",_productName);
    NSLog(@"Product description - %@",_productDescription);
    NSLog(@"Product price - %@",_productPrice);
    NSLog(@"Audio Play - %@",_AudioPlay);
    
    NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
    userid =  [session objectForKey:@"userID"];
    NSDictionary *param = [[NSDictionary alloc]initWithObjectsAndKeys:_productID,@"productId",userid,@"userid",nil];
    [SVProgressHUD showWithStatus:@"Please Wait..."];
    [[ServerController sharedController] callServiceSimplifiedPOST:@"http://www.indianhypnosisacademy.com/api/add.php" userInfo:param IsLoader:YES delegate:self];

    _pro_name.text = _productName;
    _pro_name.adjustsFontSizeToFitWidth = YES;
   // _pro_Description.text = _productDescription;
    
    NSString *htmlString =  [NSString stringWithFormat:@"%@",_productDescription];
    
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    NSRange range = (NSRange){0,[str length]};
    [str enumerateAttribute:NSFontAttributeName inRange:range options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
        UIFont* currentFont = value;
        UIFont *replacementFont = nil;
        
        if ([currentFont.fontName rangeOfString:@"bold" options:NSCaseInsensitiveSearch].location != NSNotFound) {
            replacementFont = [UIFont boldSystemFontOfSize:15];
        } else {
            replacementFont = [UIFont systemFontOfSize:14];
        }
        
        [str addAttribute:NSFontAttributeName value:replacementFont range:range];
    }];
    
    _pro_Description.attributedText = str;
    
    
    NSInteger abc = [@"63.00" integerValue];
    NSInteger bcd = [_productPrice integerValue];
    NSInteger paypalprice = bcd/abc;
    NSLog(@"%ld", (long)paypalprice);
    _pro_price.text = [NSString stringWithFormat:@"Rs. %@ (USD %ld)", _productPrice,(long)paypalprice];
    
    if ([_str isEqualToString:@"pro"])
    {
    
     [_pro_image sd_setImageWithURL:[NSURL URLWithString:_prod_image] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
      else
    {
        _pro_image.image = _productImage;
    }    
}

- (void)requestFinished:(NSDictionary *)dictionary
{
    NSLog(@"Data %@",dictionary);
    
    if ([[dictionary valueForKey:@"flag"][0]boolValue])
    {
        _PlayBTN.hidden = NO;
        
    }
    else if (serviceNo == 1)
    {
        paymentView *spec = [self.storyboard instantiateViewControllerWithIdentifier:@"paymentView"];
                spec.productPrice = _productPrice;
                spec.productinfo = _productName;
                spec.productid = [[dictionary valueForKey:@"data"]valueForKey:@"order_id"];
        [self.navigationController pushViewController:spec animated:YES];
        serviceNo = 0;
    }

    else
    {
        _buyBTN.hidden = NO;
        _PlayBTN.hidden = YES;
    }
    [SVProgressHUD dismiss];
}
- (IBAction)PlayAudioBTN:(id)sender
{
    NSString* resourcePath = _AudioPlay;
    moviePlayer = [[MPMoviePlayerViewController
                    alloc]initWithContentURL:[NSURL URLWithString:resourcePath]];
    
    [self presentViewController:moviePlayer animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buynowBTN:(id)sender
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Audio sessions" message:@"The Validity of this session is 30 days. Best wishes and good luck" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES",nil];
    [alert show];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"YES"])
    {
        
        NSDictionary *param = [[NSDictionary alloc]initWithObjectsAndKeys:_productID,@"productId",userid,@"userid",@"1",@"singleOrder",nil];
        [SVProgressHUD showWithStatus:@"Please Wait..."];
        [[ServerController sharedController] callServiceSimplifiedPOST:@"http://www.indianhypnosisacademy.com/api/cart.php" userInfo:param IsLoader:YES delegate:self];
            serviceNo = 1;

        
    }
    
}

@end
