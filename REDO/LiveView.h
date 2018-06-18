//
//  LiveView.h
//  REDO
//
//  Created by apple on 10/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveView : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barbutton;
- (IBAction)instructionBTN:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *live_name;
@property (weak, nonatomic) IBOutlet UITextField *live_age;
@property (weak, nonatomic) IBOutlet UIButton *live_gender;
@property (weak, nonatomic) IBOutlet UITextField *live_address;
@property (weak, nonatomic) IBOutlet UITextField *live_state;
@property (weak, nonatomic) IBOutlet UITextField *live_city;
@property (weak, nonatomic) IBOutlet UITextField *live_country;
@property (weak, nonatomic) IBOutlet UIButton *live_language;
@property (weak, nonatomic) IBOutlet UIButton *live_problem;
@property (weak, nonatomic) IBOutlet UITextField *live_date;
@property (weak, nonatomic) IBOutlet UITextField *live_time;
@property (weak, nonatomic) IBOutlet UITextField *live_email;
@property (weak, nonatomic) IBOutlet UITextField *live_phone;
- (IBAction)submit:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfInstructor;

@end
