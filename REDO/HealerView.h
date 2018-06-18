//
//  HealerView.h
//  REDO
//
//  Created by apple on 17/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "NIDropDown.h"
#import "cartViewController.h"
#import "paymentView.h"

@interface HealerView : UIViewController <NIDropDownDelegate>
{
    bool isInstructorOpen;
    NIDropDown *dropDown;
}
@property (weak, nonatomic) IBOutlet UITextField *healer_name;
@property (weak, nonatomic) IBOutlet UITextField *healer_age;
@property (weak, nonatomic) IBOutlet UIButton *healer_gender;
@property (weak, nonatomic) IBOutlet UITextField *healer_phone;
@property (weak, nonatomic) IBOutlet UIButton *healer_occup;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barbutton;
@property (weak, nonatomic) IBOutlet UIScrollView *SV;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Cartbutton;

- (IBAction)instructionBTN:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfInstructor;


@end
