//
//  OrderCell.h
//  REDO
//
//  Created by apple on 16/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderID;
@property (weak, nonatomic) IBOutlet UILabel *Status;
@property (weak, nonatomic) IBOutlet UILabel *pro_name;
@property (weak, nonatomic) IBOutlet UILabel *Quentity;
@property (weak, nonatomic) IBOutlet UILabel *amout_lbl;
@property (weak, nonatomic) IBOutlet UIImageView *pro_image;

@end
