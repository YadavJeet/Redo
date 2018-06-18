//
//  ProductDetailsViewController.h
//  REDO
//
//  Created by SanjayC on 14/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *pro_image;
@property (weak, nonatomic) IBOutlet UILabel *pro_name;
@property (weak, nonatomic) IBOutlet UILabel *pro_price;
@property (weak, nonatomic) IBOutlet UILabel *pro_Description;

//@property(nonatomic,strong) NSString * productName;
//@property(nonatomic,strong) NSString * productDescription;
//@property(nonatomic,strong) NSString * productPrice;
@property(nonatomic,strong) NSString * productID;
//@property(nonatomic,strong) NSString * prod_image;
//@property(nonatomic,strong) NSString * str;

//@property(nonatomic,strong) UIImage * productImage;


@end
