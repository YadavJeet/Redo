//
//  PlaceOrder.m
//  REDO
//
//  Created by apple on 16/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "PlaceOrder.h"
#import "cartTableViewCell.h"
#import "Header.h"
#import "paymentView.h"

@interface PlaceOrder ()

@end

@implementation PlaceOrder

- (void)viewDidLoad {
    [super viewDidLoad];
    
   NSLog(@" tatal deta: %@",_productData);
   DataArray = [_productData objectForKey:@"data"];
   Dataprice = [_productData objectForKey:@"order_total"];
    NSLog(@" tatal deta: %@",DataArray);
    NSLog(@" tatal deta: %lu",(unsigned long)DataArray.count);
    NSLog(@" tatal deta: %@",Dataprice);
    
    
    
    NSLog(@" tatal deta: %@",[Dataprice valueForKeyPath:@"sub_total"]);
    
    NSInteger abc = [@"63.00" integerValue];
    NSInteger bcd = [[Dataprice valueForKeyPath:@"sub_total"] integerValue];
    NSInteger paypalprice = bcd/abc;
    NSLog(@"%ld", (long)paypalprice);
    
    
    NSInteger abc1 = [@"63.00" integerValue];
    NSInteger bcd1 = [[Dataprice valueForKeyPath:@"sub_total"] integerValue];
    NSInteger paypalprice1 = bcd1/abc1;
    NSLog(@"%ld", (long)paypalprice1);
    
    _SabtotalPrice.text = [NSString stringWithFormat:@"Rs. %@ (USD %ld)",[Dataprice valueForKeyPath:@"sub_total"],(long)paypalprice];
    
    _totalPrice.text = [NSString stringWithFormat:@"Rs. %@ (USD %ld)",[Dataprice valueForKeyPath:@"total"],(long)paypalprice1];
    
    cartValue = [NSString stringWithFormat:@"%@",[Dataprice valueForKeyPath:@"total"]];
//  _totalPrice.text = [[_productData valueForKey:@"order_total"]objectForKey:@"total"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return DataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    cartTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    //cell.delegationListener = self;
    
   cell.productName.text = [NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:indexPath.row] valueForKeyPath:@"product_name"]];
    
    NSInteger abc = [@"63.00" integerValue];
    NSInteger bcd = [[[DataArray objectAtIndex:indexPath.row] valueForKey:@"price"] integerValue];
    NSInteger paypalprice = bcd/abc;
    NSLog(@"%ld", (long)paypalprice);
    
    cell.productPrice.text = [NSString stringWithFormat:@"Rs. %@ (USD %ld)",[[DataArray objectAtIndex:indexPath.row] valueForKey:@"price"],(long)paypalprice];
    cell.productQuantityTextField.text = [NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:indexPath.row] valueForKey:@"quantity"]];//OK?
    
 NSString *Nullvalue = [NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:indexPath.row] valueForKeyPath:@"product_image"]];
    
    if (Nullvalue == (id)[NSNull null]||[Nullvalue length]==0 )
    {
        cell.ProductImageView.image = [UIImage imageNamed:@"LOGING.jpg"];
    }
    else
    {
        [cell.ProductImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[DataArray objectAtIndex:indexPath.row] valueForKeyPath:@"product_image"]]]placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]options:SDWebImageRefreshCached];
    }
    tableView.separatorColor = [UIColor blackColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)PlaceOrderBTN:(id)sender {
    
    NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"] ,@"userid",@"1",@"placeOrder", nil];
    
    [SVProgressHUD showWithStatus:@"Please Wait..."];
    [[ServerController sharedController] callServiceSimplifiedPOST:@"http://www.indianhypnosisacademy.com/api/cart.php" userInfo:params IsLoader:YES delegate:self];
    
//    paymentView *spec = [self.storyboard instantiateViewControllerWithIdentifier:@"paymentView"];
//    spec.productPrice = cartValue;
//    spec.productinfo = [NSString stringWithFormat:@"%@",_cartID];
//    [self.navigationController pushViewController:spec animated:YES];
}

- (void)requestFinished:(NSDictionary *)dictionary
{
    NSLog(@"Data %@",dictionary);

        paymentView *spec = [self.storyboard instantiateViewControllerWithIdentifier:@"paymentView"];
         spec.productPrice = cartValue;
         spec.productid = [[dictionary valueForKey:@"data"]valueForKey:@"order_id"];
         spec.productinfo = [NSString stringWithFormat:@"%@",_cartID];

        [self.navigationController pushViewController:spec animated:YES];
    
    [SVProgressHUD dismiss];
}


@end
