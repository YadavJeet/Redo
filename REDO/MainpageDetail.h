//
//  MainpageDetail.h
//  REDO
//
//  Created by apple on 10/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@interface MainpageDetail : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *pro_image;
@property (weak, nonatomic) IBOutlet UILabel *pro_name;
@property (weak, nonatomic) IBOutlet UILabel *pro_price;
@property (weak, nonatomic) IBOutlet UILabel *pro_Description;

@property(nonatomic,strong) NSString * productName;
@property(nonatomic,strong) NSString * productDescription;
@property(nonatomic,strong) NSString * productPrice;
@property(nonatomic,strong) NSString * productID;
@property(nonatomic,strong) NSString * prod_image;
@property(nonatomic,strong) NSString * str;
@property(nonatomic,strong) NSString * AudioPlay;

@property(nonatomic,strong) UIImage * productImage;


@end
