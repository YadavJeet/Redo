//
//  MainView.h
//  REDO
//
//  Created by apple on 09/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainView : UIViewController
{
    NSDictionary * ProductData;
}
@property (weak, nonatomic) IBOutlet UITableView *TV;

@end
