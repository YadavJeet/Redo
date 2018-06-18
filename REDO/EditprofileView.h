//
//  EditprofileView.h
//  REDO
//
//  Created by apple on 16/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditprofileView : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *firstname;
@property (weak, nonatomic) IBOutlet UITextField *lastname;
@property (weak, nonatomic) IBOutlet UITextField *emailid;
- (IBAction)updateBTN:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *SV;

@end
