//
//  PlaceOrder.h
//  REDO
//
//  Created by apple on 16/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceOrder : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *DataArray;
    NSArray *Dataprice;
    NSString *cartValue;

}

@property (weak, nonatomic) IBOutlet UITableView *TV;
- (IBAction)PlaceOrderBTN:(id)sender;

@property(nonatomic,strong)NSString* cartID;

@property(nonatomic,strong)NSDictionary* productData;
@property (weak, nonatomic) IBOutlet UILabel *SabtotalPrice;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@end
