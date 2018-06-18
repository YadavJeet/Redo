//
//  ContactUsView.h
//  REDO
//
//  Created by apple on 18/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactUsView : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *SV;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *message;
@property (weak, nonatomic) IBOutlet UITextField *emailid;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barbutton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Cartbutton;

@end
    
