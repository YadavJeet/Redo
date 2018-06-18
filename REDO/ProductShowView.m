//
//  ProductShowView.m
//  REDO
//
//  Created by apple on 11/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "ProductShowView.h"
#import "cartViewController.h"
#import "Header.h"
#import "CustomCollectionCell.h"
#import "ProductDetailsViewController.h"

@interface ProductShowView ()<UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSDictionary * alldataArray;
    int cart;
}
- (IBAction)CartBTN:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *CV;
 @property (weak, nonatomic) IBOutlet UIBarButtonItem *barbutton;
@end

@implementation ProductShowView
static NSString * const reuseIdentifier = @"cellid";
- (void)viewDidLoad {
    [super viewDidLoad];
    

        NSDictionary *param = [[NSDictionary alloc]initWithObjectsAndKeys:_identifire,@"catName",nil];
        [SVProgressHUD showWithStatus:@"Please Wait..."];
        [[ServerController sharedController] callServiceSimplifiedPOST:@"http://www.indianhypnosisacademy.com/api/add.php" userInfo:param IsLoader:YES delegate:self];
    
    
     NSLog(@"%@",param);
    _barbutton.target = self.revealViewController;
    _barbutton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        // Do any additional setup after loading the view.
}

- (void)requestFinished:(NSDictionary *)dictionary
{
    
    NSLog(@"Respons :- %@ ", dictionary);
    alldataArray = dictionary;
    [_CV reloadData];
    [SVProgressHUD dismiss];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [alldataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.layer.shadowColor = [UIColor purpleColor].CGColor;
    [cell.layer setShadowOffset:CGSizeMake(2.0, 2.0)];;
    cell.layer.shadowOpacity = 1;
    cell.layer.shadowRadius = 1.0;
    
    cell.nameLabel.text = [alldataArray valueForKey:@"productName"][indexPath.row];
    NSInteger abc = [@"63.00" integerValue];
    NSInteger bcd = [[alldataArray valueForKey:@"priceRegular"][indexPath.row] integerValue];
    NSInteger paypalprice = bcd/abc;
    NSLog(@"%ld", (long)paypalprice);
    
    cell.amountLabel.text = [NSString stringWithFormat:@"Rs. %@ (USD %ld)",[alldataArray valueForKey:@"priceRegular"][indexPath.row],(long)paypalprice];
    
    NSString *Nullvalue = [alldataArray valueForKey:@"productImage"][indexPath.row];
    
    if (Nullvalue == (id)[NSNull null]||[Nullvalue length]==0 )
    {
        cell.profileImage.image = [UIImage imageNamed:@"lounch image.jpg"];
    }
    else
    {
       [cell.profileImage sd_setImageWithURL:[NSURL URLWithString:[alldataArray valueForKey:@"productImage"][indexPath.row]]placeholderImage:[UIImage imageNamed:@"avatar-placeholder.png"]options:SDWebImageRefreshCached];

    }

      return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((self.view.frame.size.width/2-15),210);
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    MainpageDetail *mainviewdetail = [self.storyboard instantiateViewControllerWithIdentifier:@"MainpageDetail"];
//    mainviewdetail.productID = [alldataArray valueForKey:@"productId"][indexPath.row];
//    mainviewdetail.productName = [alldataArray valueForKey:@"productName"][indexPath.row];
//    mainviewdetail.productPrice = [alldataArray valueForKey:@"priceRegular"][indexPath.row];
//    mainviewdetail.str = @"pro";
//    mainviewdetail.prod_image = [alldataArray valueForKey:@"productImage"][indexPath.row];
//
//    [self.navigationController pushViewController:mainviewdetail animated:YES];
//}

//productDetails


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"productDetails"])
    {
        NSIndexPath *indexPath = [self.CV indexPathForCell:sender];
        
        ProductDetailsViewController *mainviewdetail = segue.destinationViewController;
        
       // CustomCollectionCell *cell = [self.CV cellForItemAtIndexPath:indexPath];
        
        
        mainviewdetail.productID = [alldataArray valueForKey:@"productId"][indexPath.row];
       //// mainviewdetail.productImage = cell.profileImage.image;
//mainviewdetail.productName = cell.nameLabel.text;
        //mainviewdetail.productPrice = cell.amountLabel.text;
        
    }
}
//-(void)cartbtn
//{
//    cartViewController *spec = [self.storyboard instantiateViewControllerWithIdentifier:@"cartViewController"];
//    [self.navigationController pushViewController:spec animated:YES];
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:true];
    NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
    cart = [[session objectForKey:@"cardQty"] intValue];
    _Cartbutton.badgeValue = [NSString stringWithFormat:@"%d",cart];
    _Cartbutton.badgeBGColor = [UIColor colorWithRed:0.88 green:1.00 blue:0.10 alpha:1.0];
}


- (IBAction)CartBTN:(id)sender
{
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
@end
