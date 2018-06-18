//
//  cartTableViewCell.m
//  REDO
//
//  Created by SanjayC on 14/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "cartTableViewCell.h"
#import "cartViewController.h"


@implementation cartTableViewCell

@synthesize delegationListener;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)increaseCartItem:(UIButton *)sender {
    [self.delegationListener addtoItem:self];
}
@end
