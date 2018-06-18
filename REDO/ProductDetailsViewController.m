//
//  ProductDetailsViewController.m
//  REDO
//
//  Created by SanjayC on 14/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "UIBarButtonItem+Badge.h"
#import "Header.h"

@interface ProductDetailsViewController (){
    NSString * btnPressed;
}

@property (weak, nonatomic) IBOutlet UIButton *butNowBtn;
@property (weak, nonatomic) IBOutlet UILabel *DESLABEL;

@end

@implementation ProductDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    NSLog(@"Product Id - %@",_productID);
    ////NSLog(@"Product name - %@",_productName);
    /// NSLog(@"Product price - %@",_productPrice);
    
    NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *param = [[NSDictionary alloc]initWithObjectsAndKeys:_productID, @"productId", [session objectForKey:@"userID"] , @"userid", nil];
    
    NSLog(@"my params %@",param);
    
    [SVProgressHUD showWithStatus:@"Please Wait..."];
    [[ServerController sharedController] callServiceSimplifiedPOST: @"http://www.indianhypnosisacademy.com/api/add.php" userInfo:param IsLoader:YES delegate:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addToCart:(UIButton *)sender {
    btnPressed = @"AddToCart";
    [self addToCart];
}

- (IBAction)buyNow:(UIButton *)sender {
    btnPressed = @"BuyNow";
    [self addToCart];
}

- (void)addToCart{
    [SVProgressHUD showWithStatus:@"Please Wait..."];
    
    NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *param = [[NSDictionary alloc]initWithObjectsAndKeys:_productID, @"productId",@"1",@"quantity", [session objectForKey:@"userID"] , @"userid", nil];
    
    NSLog(@"my params %@",param);
    
    [[ServerController sharedController] callServiceSimplifiedPOST: @"http://www.indianhypnosisacademy.com/api/cart.php" userInfo:param IsLoader:YES delegate:self];
}

- (void)requestFinished:(NSDictionary *)dictionary
{
    
    NSLog(@"Respons :- %@ ", dictionary);
    if ([dictionary valueForKey:@"productDesc"]!=nil) {
        
        NSLog(@"dicrp :- %@ ",[dictionary valueForKey:@"productDesc"][0]);
        
        _DESLABEL.text = @"Description";
        
        
        NSString *htmlString =  [NSString stringWithFormat:@"%@",[dictionary valueForKey:@"productDesc"][0]];
        
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
        
        _pro_name.text = [NSString stringWithFormat:@"%@",[dictionary valueForKey:@"productName"][0]];
        
        _pro_name.adjustsFontSizeToFitWidth = YES;
        
        NSInteger abc = [@"63.00" integerValue];
        NSInteger bcd = [[dictionary valueForKey:@"priceRegular"][0] integerValue];
        NSInteger paypalprice = bcd/abc;
        NSLog(@"%ld", (long)paypalprice);
        
        _pro_price.text = [NSString stringWithFormat:@"Rs. %@ (USD %ld)",[dictionary valueForKey:@"priceRegular"][0],(long)paypalprice];
        
        NSString *Nullvalue = [NSString stringWithFormat:@"%@",[dictionary valueForKey:@"productImage"][0]];
        
        if (Nullvalue == (id)[NSNull null]||[Nullvalue length]==0 )
        {
            _pro_image.image = [UIImage imageNamed:@"lounch image.jpg"];
        }
        else
        {
            [_pro_image sd_setImageWithURL:[NSURL URLWithString:Nullvalue] placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]options:SDWebImageRefreshCached];
            //
        }
        
       // _pro_image.image = [NSString stringWithFormat:@"%@",[dictionary valueForKey:@"productDesc"][0]];;
        
    }
    else if ([[dictionary valueForKey:@"status"]integerValue] ==1) {
        if ([btnPressed  isEqual: @"BuyNow"]) {
            [self performSegueWithIdentifier:@"goToCart" sender:self];
        }else{
            
            NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
            int abc = [[session objectForKey:@"cardQty"]intValue];
            abc += 1;
            [session setObject:[NSString stringWithFormat:@"%d",abc] forKey:@"cardQty"];
        
        }
    }
    [SVProgressHUD dismiss];
}


- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier isEqualToString:@"goToCart"]) {
        return NO;
    }
    return YES;
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
