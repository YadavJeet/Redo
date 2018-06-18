//
//  paymentView.h
//  REDO
//
//  Created by apple on 10/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface paymentView : UIViewController
@property(nonatomic,strong) NSString * productPrice;
@property(nonatomic,strong) NSString * productinfo;
@property(nonatomic,strong) NSString * productid;

@property (weak, nonatomic) IBOutlet UILabel *AmountLBL;
@property (weak, nonatomic) IBOutlet UILabel *fromID;


@end
