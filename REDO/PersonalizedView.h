//
//  PersonalizedView.h
//  REDO
//
//  Created by apple on 10/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalizedView : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Cartbutton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barbutton;
@property (weak, nonatomic) IBOutlet UIScrollView *SV;
@property (weak, nonatomic) IBOutlet UITextField *personl_name;
@property (weak, nonatomic) IBOutlet UITextField *personal_age;
@property (weak, nonatomic) IBOutlet UIButton *personl_gender;
@property (weak, nonatomic) IBOutlet UITextField *personl_address;
@property (weak, nonatomic) IBOutlet UITextField *personl_email;
@property (weak, nonatomic) IBOutlet UITextField *personl_city;
@property (weak, nonatomic) IBOutlet UITextField *personal_state;
@property (weak, nonatomic) IBOutlet UITextField *personl_country;
@property (weak, nonatomic) IBOutlet UIButton *personl_language;
@property (weak, nonatomic) IBOutlet UITextField *personl_date;
@property (weak, nonatomic) IBOutlet UITextField *personl_time;
@property (weak, nonatomic) IBOutlet UITextField *personl_phone;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfInstructor;


- (IBAction)instructionBTN:(id)sender;
- (IBAction)submitBTN:(id)sender;

@end
