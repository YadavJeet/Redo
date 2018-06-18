//
//  cartTableViewCell.h
//  REDO
//
//  Created by SanjayC on 14/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import <UIKit/UIKit.h>


@class cartTableViewCell;

@protocol cartCellViewDelegate<NSObject>

- (void) addtoItem:(cartTableViewCell *)thecell;
@end

@interface cartTableViewCell : UITableViewCell{
   __unsafe_unretained id<cartCellViewDelegate> delegationListener;
}


@property (weak, nonatomic) IBOutlet UIImageView *ProductImageView;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property(nonatomic,strong)IBOutlet UIButton *deletitem;
@property (weak, nonatomic) IBOutlet UITextField *productQuantityTextField;

@property (nonatomic,assign) id<cartCellViewDelegate> delegationListener;


- (IBAction)increaseCartItem:(UIButton *)sender;

@end
