//
//  OrderView.m
//  REDO
//
//  Created by apple on 16/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "OrderView.h"
#import "Header.h"
#import "OrderCell.h"

@interface OrderView ()

@end

@implementation OrderView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
    [SVProgressHUD showWithStatus:@"Please Wait..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    NSDictionary *params = [[NSDictionary alloc]initWithObjectsAndKeys:[session objectForKey:@"userID"], @"userid",@"orderDetails",@"orderDetails",nil];
    
    NSLog(@"my params %@",params);
    
    [[ServerController sharedController] callServiceSimplifiedPOST:@"http://www.indianhypnosisacademy.com/api/cart.php" userInfo:params IsLoader:false delegate:self];

    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     NSLog(@"my data count %lu",(unsigned long)DataArray.count);
    return DataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.orderID.text = [NSString stringWithFormat:@"Order ID: %@", [[DataArray objectAtIndex:indexPath.row] valueForKey:@"order_id"]];
    cell.Status.text = [NSString stringWithFormat:@"Status: %@", [[DataArray objectAtIndex:indexPath.row] valueForKey:@"order_status"]];
    
    NSInteger abc = [@"63.00" integerValue];
    NSInteger bcd = [[[DataArray objectAtIndex:indexPath.row] valueForKey:@"order_total"] integerValue];
    NSInteger paypalprice = bcd/abc;
    NSLog(@"%ld", (long)paypalprice);
    
    cell.amout_lbl.text = [NSString stringWithFormat:@"Rs. %@ (USD %ld)", [[DataArray objectAtIndex:indexPath.row] valueForKey:@"order_total"],(long)paypalprice];
    
    cell.pro_name.text = [NSString stringWithFormat:@"%@", [[[DataArray objectAtIndex:indexPath.row] valueForKey:@"product_details"] valueForKey:@"product_name"][0]];
    
    cell.Quentity.text = [NSString stringWithFormat:@"Quantity: %@", [[[DataArray objectAtIndex:indexPath.row] valueForKey:@"product_details"] valueForKey:@"quantity"][0]];
    
    NSString *Nullvalue = [NSString stringWithFormat:@"%@", [[[DataArray objectAtIndex:indexPath.row] valueForKey:@"product_details"] valueForKey:@"product_image"][0]];
    
    if (Nullvalue == (id)[NSNull null]||[Nullvalue length]==0 )
    {
        cell.pro_image.image = [UIImage imageNamed:@"LOGING.jpg"];
    }
    else
    {
         [cell.pro_image sd_setImageWithURL:[NSURL URLWithString:Nullvalue] placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]options:SDWebImageRefreshCached];
    }
    tableView.separatorColor = [UIColor blackColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
   return cell;
}

- (void)requestFinished:(NSDictionary *)dictionary
{
    NSLog(@"Respons :- %@ ", dictionary);
    DataArray = [dictionary objectForKey:@"data"];
    [_TV reloadData];
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
