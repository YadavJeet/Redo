//
//  OrderView.h
//  REDO
//
//  Created by apple on 16/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderView : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    NSArray *DataArray;
    NSString *ProductID;
    NSString *Status;
    //     id delegate;
}

@property (weak, nonatomic) IBOutlet UITableView *TV;

@end
