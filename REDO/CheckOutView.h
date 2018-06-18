//
//  CheckOutView.h
//  REDO
//
//  Created by apple on 15/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckOutView : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *firestname;
@property (weak, nonatomic) IBOutlet UITextField *lastname;
@property (weak, nonatomic) IBOutlet UITextField *emailname;
@property (weak, nonatomic) IBOutlet UITextField *mobilename;
- (IBAction)ProceedBTN:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *SV;

@property(nonatomic,strong) NSString * productPrice;
@property(nonatomic,strong) NSString * cartID;

@end
