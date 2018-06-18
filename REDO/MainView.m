//
//  MainView.m
//  REDO
//
//  Created by apple on 09/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "MainView.h"
#import "cartViewController.h"
#import "Header.h"
#import "CustomCell.h"
#import "MainpageDetail.h"
#import "UIBarButtonItem+Badge.h"

@interface MainView () <UITableViewDelegate,UITableViewDataSource>{
    int serviceNo;
    NSMutableData *responseData;
    int cart;

}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barbutton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Cartbutton;
- (IBAction)CartBTN:(id)sender;

@end

@implementation MainView

static NSString * const reuseIdentifier1 = @"cellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    serviceNo = 0;
    NSDictionary *param = [[NSDictionary alloc]initWithObjectsAndKeys:@"audios",@"catName",nil];
    
    [SVProgressHUD showWithStatus:@"Please Wait..."];
    [[ServerController sharedController] callServiceSimplifiedPOST:@"http://www.indianhypnosisacademy.com/api/add.php" userInfo:param IsLoader:YES delegate:self];
    
    _barbutton.target = self.revealViewController;
    _barbutton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    // Do any additional setup after loading the view.
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:true];
    NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
     cart = [[session objectForKey:@"cardQty"] intValue];
    _Cartbutton.badgeValue = [NSString stringWithFormat:@"%d",cart];
    _Cartbutton.badgeBGColor = [UIColor colorWithRed:0.88 green:1.00 blue:0.10 alpha:1.0];
    
}

- (void)requestFinished:(NSDictionary *)dictionary
{
    NSLog(@"Respons :- %@ ", dictionary);
    ProductData = dictionary;
    [_TV reloadData];
        
        NSString *url;
        url=@"http://www.indianhypnosisacademy.com/api/cart.php";
        const char *bytes=[[NSString stringWithFormat:@"userid=%@&getCart=getCart",[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"]] UTF8String];
        NSLog(@"my params %s",bytes);
        
        NSURL *url1 = [NSURL URLWithString:url];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url1];
        
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[NSData dataWithBytes:bytes length:strlen(bytes)]];
        NSURLConnection *NSURLConnection1= [[NSURLConnection alloc] initWithRequest:request delegate:self];
        NSLog(@"request result %@",NSURLConnection1);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ProductData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier1];
    
        //NSLog(@"%@", [ProductData valueForKey:@"productName"][indexPath.row]);
    cell.ProductName.text = [ProductData valueForKey:@"productName"][indexPath.row];
    cell.ProductDetail.text = [ProductData valueForKey:@"productDesc"][indexPath.row];
    NSInteger abc = [@"63.00" integerValue];
    NSInteger bcd = [[ProductData valueForKey:@"priceRegular"][indexPath.row] integerValue];
    NSInteger paypalprice = bcd/abc;
    NSLog(@"%ld", (long)paypalprice);
    
    cell.ProductAmount.text = [NSString stringWithFormat:@"Rs. %@ (USD %ld)",[ProductData valueForKey:@"priceRegular"][indexPath.row],(long)paypalprice];
    
    NSString *Nullvalue = [ProductData valueForKey:@"productImage"][indexPath.row];
    
    if (Nullvalue == (id)[NSNull null]||[Nullvalue length]==0 )
    {
        cell.ProductImage.image = [UIImage imageNamed:@"lounch image.jpg"];
    }
    else
    {
        [cell.ProductImage sd_setImageWithURL:[NSURL URLWithString:Nullvalue]placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]options:SDWebImageRefreshCached];
    }
    
    tableView.separatorColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (IS_IPHONE_4_OR_LESS){
        return 200;
    }else if (IS_IPHONE_5){
        return 200;
    }else{
        return 250;
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Action"])
    {
        NSIndexPath *indexPath = [self.TV indexPathForCell:sender];
        
        MainpageDetail *mainviewdetail = segue.destinationViewController;
        mainviewdetail.productID = [ProductData valueForKey:@"productId"][indexPath.row];
        mainviewdetail.productName = [ProductData valueForKey:@"productName"][indexPath.row];
        mainviewdetail.productDescription = [ProductData valueForKey:@"productDesc"][indexPath.row];
        mainviewdetail.productPrice = [ProductData valueForKey:@"priceRegular"][indexPath.row];
        NSString *audioStr= [ProductData valueForKey:@"audios_url"][indexPath.row][0];
        mainviewdetail.AudioPlay = audioStr;
        
        CustomCell * cell = [self.TV cellForRowAtIndexPath:indexPath];
        mainviewdetail.productImage = cell.ProductImage.image;
        
    }
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
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    responseData = [[NSMutableData alloc] init];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [GlobleClass alertWithMassage:@"Internet Connection Problem" Title:@"Alert"];
    [SVProgressHUD dismiss];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *parseError = nil;
    NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&parseError];
    NSLog(@"Fund data: %@", dictionary);
    
    NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
    [session setObject:[dictionary valueForKey:@"totalQty"] forKey:@"cardQty"];
    [session synchronize];
    
     cart = [[session objectForKey:@"cardQty"] intValue];
    _Cartbutton.badgeValue = [NSString stringWithFormat:@"%d",cart];
    _Cartbutton.badgeBGColor = [UIColor colorWithRed:0.88 green:1.00 blue:0.10 alpha:1.0];
    [SVProgressHUD dismiss];
    
}

@end
