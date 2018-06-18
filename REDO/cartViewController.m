//
//  cartViewController.m
//  REDO
//
//  Created by SanjayC on 14/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "cartViewController.h"
#import "CheckOutView.h"
#import "Header.h"
#import "cartTableViewCell.h"
#import "paymentView.h"


@interface cartViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *DataArray;
    NSString *cartID;
     NSString *cartValue;
    NSString*strvalue;
    NSMutableData * responseData;
    //     id delegate;
}
@property (weak, nonatomic) IBOutlet UIButton *checkoutBTN;

@property (weak, nonatomic) IBOutlet UITableView *cartTV;

@end

@implementation cartViewController

- (void)viewDidLoad {
    
    [super viewDidLoad]; [(UIButton *)[self.view viewWithTag:105] addTarget:self action:@selector(checkout) forControlEvents:UIControlEventTouchUpInside];
   
    // Do any additional setup after loading the view.
    NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *param = [[NSDictionary alloc]initWithObjectsAndKeys:@"getCart", @"getCart" , [session objectForKey:@"userID"] , @"userid" ,nil];
    
    //NSString*url = [NSString stringWithFormat:@"%@%@",Base_URL,@"cart.php"];
    
    [SVProgressHUD showWithStatus:@"Please Wait..."];
    [[ServerController sharedController] callServiceSimplifiedPOST:@"http://www.indianhypnosisacademy.com/api/cart.php" userInfo:param IsLoader:YES delegate:self];
    
}

- (void)requestFinished:(NSDictionary *)dictionary
{
    NSLog(@"Respons :- %@ ", dictionary);
    if ([dictionary valueForKey:@"cartId"] != nil || [dictionary valueForKey:@"cartId"] != NULL) {
        
        NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
        [session setObject:[dictionary valueForKey:@"totalQty"] forKey:@"cardQty"];
        
        cartValue = [dictionary valueForKey:@"fullCartPrice"];
        cartID = [dictionary valueForKey:@"cartId"];
        DataArray = [dictionary valueForKey:@"data"];
        [session synchronize];
        [_cartTV reloadData];
        [SVProgressHUD dismiss];
    }
    else if([[dictionary objectForKey:@"status"] boolValue])
    {
        
        NSDictionary *param = [[NSDictionary alloc]initWithObjectsAndKeys:@"getCart", @"getCart" , [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"] , @"userid" ,nil];
        
        [SVProgressHUD showWithStatus:@"Please Wait..."];
        [[ServerController sharedController] callServiceSimplifiedPOST:@"http://www.indianhypnosisacademy.com/api/cart.php" userInfo:param IsLoader:YES delegate:self];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return DataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
  {
    
    cartTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    cell.delegationListener = self;
    
    cell.productName.text = [[DataArray objectAtIndex:indexPath.row] valueForKey:@"productName"];
      
      NSInteger abc = [@"63.00" integerValue];
      NSInteger bcd = [[[DataArray objectAtIndex:indexPath.row] valueForKey:@"totalPrice"] integerValue];
      NSInteger paypalprice = bcd/abc;
      NSLog(@"%ld", (long)paypalprice);
      
    cell.productPrice.text = [NSString stringWithFormat:@"Rs. %@ (USD %ld)",[[DataArray objectAtIndex:indexPath.row] valueForKey:@"totalPrice"],(long)paypalprice];
    cell.productQuantityTextField.text = [[DataArray objectAtIndex:indexPath.row] valueForKey:@"quantity"];
      
    [cell.deletitem addTarget:self action:@selector(remove:) forControlEvents:UIControlEventTouchUpInside];
    cell.deletitem.tag = indexPath.row;
      
    NSString *Nullvalue = [[DataArray objectAtIndex:indexPath.row] valueForKey:@"productImage"];
    
    if (Nullvalue == (id)[NSNull null]||[Nullvalue length]==0 )
    {
        cell.ProductImageView.image = [UIImage imageNamed:@"LOGING.jpg"];
    }
    else
    {
        [cell.ProductImageView sd_setImageWithURL:[NSURL URLWithString:Nullvalue] placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]options:SDWebImageRefreshCached];
        
    }
    tableView.separatorColor = [UIColor blackColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)addtoItem:(cartTableViewCell *)thecell{ 

    NSLog(@"%@", thecell);
    int value = [thecell.productQuantityTextField.text intValue];
    value += 1;
    thecell.productQuantityTextField.text = [NSString stringWithFormat:@"%d",value];
    NSIndexPath * indexPath = [_cartTV indexPathForCell:thecell];
    NSLog(@"%ld",(long)indexPath.row);
    NSLog(@"%@",DataArray);
    NSLog(@"%@",[[DataArray objectAtIndex:indexPath.row] valueForKey:@"productId"]);
    
   
    NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
    NSDictionary *data1 = [DataArray objectAtIndex:indexPath.row];

   // NSLog(@"data %@",strvalue);
    
    NSDictionary *param = [[NSDictionary alloc]initWithObjectsAndKeys:[data1 objectForKey:@"productId"],@"productId",[NSString stringWithFormat:@"%d",value], @"quantity",[session objectForKey:@"userID"],@"userid",nil];
    
      NSLog(@"data %@",param);
    
    [SVProgressHUD showWithStatus:@"Please Wait..."];
    [[ServerController sharedController] callServiceSimplifiedPOST:@"http://www.indianhypnosisacademy.com/api/cart.php" userInfo:param IsLoader:YES delegate:self];
    
}

-(void)remove:(UIButton*)btn{
    
//    CGPoint buttonPosition = [btn convertPoint:CGPointZero toView:_cartTV];
    NSLog(@"%ld", (long)btn.tag);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:btn.tag inSection:0];
    
    NSLog(@"%@", indexPath);
    
    
//    NSIndexPath *indexPath = [_cartTV indexPathForRowAtPoint:btn.tag];
    NSLog(@"my array %@",[DataArray objectAtIndex:indexPath.row]);
    
    
    NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
    
    NSString *url;
    url=@"http://www.indianhypnosisacademy.com/api/cart.php";
    const char *bytes=[[NSString stringWithFormat:@"productId=%@&userid=%@&removeCart=removeCart",[[DataArray objectAtIndex:indexPath.row] valueForKey:@"productId"],[session objectForKey:@"userID"]] UTF8String];
    
    NSLog(@"my params %s",bytes);
    
    NSURL *url1 = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url1];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[NSData dataWithBytes:bytes length:strlen(bytes)]];
    NSURLConnection *NSURLConnection1= [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSLog(@"request result %@",NSURLConnection1);
    
    
    int abc = [[session objectForKey:@"cardQty"]intValue];
    abc -= 1;
    [session setObject:[NSString stringWithFormat:@"%d",abc] forKey:@"cardQty"];
    [DataArray removeObjectAtIndex:indexPath.row];

}
-(void)checkout
{
    CheckOutView *spec = [self.storyboard instantiateViewControllerWithIdentifier:@"CheckOutView"];
    spec.productPrice = cartValue;
    spec.cartID = cartID;
    [self.navigationController pushViewController:spec animated:YES];

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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No internet connection!" message:@"Internet connection appears to be offline. Try again." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
    [alert show];
    
    [SVProgressHUD dismiss];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *teststr=[[NSString alloc]  initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSString *str1234 = [teststr stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSLog(@"Response is %@ %lul",str1234,(unsigned long)[str1234 length]);
    [_cartTV reloadData];
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
