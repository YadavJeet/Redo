//
//  LiveView.m
//  REDO
//
//  Created by apple on 10/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "LiveView.h"
#import "cartViewController.h"
#import "Header.h"
#import "NIDropDown.h"
#import "QuartzCore/QuartzCore.h"
#import "paymentView.h"

@interface LiveView ()<NIDropDownDelegate>{
    bool isInstructorOpen;
    NIDropDown *dropDown;
    UIPickerView *picker;
    UIDatePicker *datePicker;
    UIDatePicker *timePicker;
    int cart;
}
@property (weak, nonatomic) IBOutlet UILabel *instructionLBL;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *Cartbutton;
@property (weak, nonatomic) IBOutlet UIScrollView *SV;

@end

@implementation LiveView

-(void)datePickerValueChanged{
    NSLog(@"%@",datePicker.date);
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:datePicker.date]];
    _live_date.text = str;
    //assign text to label
    NSLog(@"Date %@",str);
    
    
   
    
}
-(void)datePickerValueChanged1{
    
    NSLog(@"%@",timePicker.date);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm a"];
    NSString *currentTime = [dateFormatter stringFromDate:timePicker.date];
    _live_time.text = currentTime;
    NSLog(@"time %@",currentTime);
    
}


-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    if ([_live_date isFirstResponder]) {
        [self datePickerValueChanged];
    }
    else if ([_live_time isFirstResponder]){
        [self datePickerValueChanged1];
    }
    
//    CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y-100);
//    [_SV setContentOffset:scrollPoint animated:NO];
    
}

//-(void) textFieldDidEndEditing:(UITextField *)textField
//{
//    
//    [_SV setContentOffset:CGPointZero animated:YES];
//}
//
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES;
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentJustified;
    style.firstLineHeadIndent = 10.0f;
    style.headIndent = 10.0f;
    style.tailIndent = -10.0f;
    
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:@"\n\nGet your problem and issue heard, find a way with our certified counsellors with their expert advises. Have a full fledged counselling session live on your phone at INR 1500 for half and hour and INR 2500 for 1 hour. You don't have to call, call rates are paid by us (for India only). For international callers, call rates are excluded. Your privacy is the utmost concern for us and all the information will remain guaranteed confidential.\n\nHow it works: \n\n1. Fill the form below and enter a phone number to reach you\n2. Select the date and your preferred time\n3. Make the payment\n4. You will receive a call from our executive who will reconfirm your appointment\n5. You will receive a call from our counsellor as per appointment" attributes:@{ NSParagraphStyleAttributeName : style}];
    
    _instructionLBL.attributedText = attrText;
    
    
    
    isInstructorOpen = NO;
    _barbutton.target = self.revealViewController;
    _barbutton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    // Do any additional setup after loading the view.
    
    
    
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDate *currentDate = [NSDate date];
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    [comps setYear:0];
//    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setDate:[NSDate date]];
    [datePicker setMinimumDate:[NSDate date]];
    
    [datePicker addTarget:self action:@selector(datePickerValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.live_date setInputView:datePicker];
    
    timePicker = [[UIDatePicker alloc]init];
    timePicker.locale = [NSLocale currentLocale];
    timePicker.timeZone = [NSTimeZone localTimeZone];
    timePicker.datePickerMode = UIDatePickerModeTime;
    [timePicker setDate:[NSDate date]];
    
    [timePicker addTarget:self action:@selector(datePickerValueChanged1) forControlEvents:UIControlEventValueChanged];
    [self.live_time setInputView:timePicker];
   
    UIToolbar *toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    [toolbar setTintColor:[UIColor lightGrayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expand2.png"] style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self.live_age setInputAccessoryView:toolbar];
    [self.live_phone setInputAccessoryView:toolbar];
    [toolbar setItems:[NSArray arrayWithObjects:space, doneBtn,nil]];
    
}
-(void)done
{
    if ([_live_age isFirstResponder]){
        [self.live_age resignFirstResponder];
    }else{
        [self.live_phone resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)instructionBTN:(id)sender {
    if (isInstructorOpen) {
        isInstructorOpen  = NO;
        _heightOfInstructor.constant = 30;
    }else{
        isInstructorOpen = YES;
    _heightOfInstructor.constant = 360;
    }
    
}

- (IBAction)DropDownClicked:(UIButton *)sender {
    
    NSArray * arr = [[NSArray alloc] init];
    CGFloat f;
    if (sender == _live_gender) {
        arr = [NSArray arrayWithObjects:@"Male", @"Female",nil];
        f = 80;
    }
    else if ( sender == _live_language)
    {
        arr = [NSArray arrayWithObjects:@"Hindi", @"English",nil];
        f = 80;
    }
    else if (sender == _live_problem)
    {
        arr = [NSArray arrayWithObjects:@"Stress/ Anxiety/ Phobia related", @"Lack of confidence/ Motivation", @"Relationship related",@"Bad Habit related",@"Depression or tension related",@"Performance related",@"Sexual Issues related",@"Others",nil];
        f = 320;
    }
 
    if(dropDown == nil) {
        
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :nil :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
    

}


- (void) niDropDownDelegateMethod: (NIDropDown *) sender {
    [self rel];
}

-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}

- (IBAction)submit:(id)sender
{
    if ([_live_name.text isEqualToString:@""] || [_live_age.text isEqualToString:@""]|| [_live_address.text isEqualToString:@""]|| [_live_email.text isEqualToString:@""]|| [_live_city.text isEqualToString:@""]|| [_live_state.text isEqualToString:@""]|| [_live_country.text isEqualToString:@""]|| [_live_phone.text isEqualToString:@""]|| [_live_date.text isEqualToString:@""]|| [_live_time.text isEqualToString:@""]) {
        
        [GlobleClass alertWithMassage:@"Please Fill All The Fields" Title:@"Oppss!!!"];
    }
    else if (![ GlobleClass NSStringIsValidEmail:_live_email.text]) {
        
        [GlobleClass alertWithMassage:@"Enter valid Email ID" Title:@"Alert"];
        
    }
        else
    {
        NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
        NSString *userid =  [session objectForKey:@"userID"];
        [SVProgressHUD showWithStatus:@"Please Wait..."];
        
        NSDictionary *logins = [[NSDictionary alloc]initWithObjectsAndKeys:_live_name.text ,@"Name",_live_address.text,@"Address",_live_email.text,@"email",_live_city.text,@"City",_live_state.text,@"State",@"1",@"live" ,_live_age.text,@"Age",_live_phone.text ,@"phoneNo",_live_date.text,@"preferedDate",_live_time.text,@"preferedTime",_live_gender.titleLabel.text,@"Gender",_live_problem.titleLabel.text,@"Issue",_live_language.titleLabel.text,@"Language",userid,@"Id",_live_country.text ,@"Country", nil];
        
        NSLog(@"my params %@",logins);
        
        [[ServerController sharedController] callServiceSimplifiedPOST: @"http://www.indianhypnosisacademy.com/api/custom.php" userInfo:logins IsLoader:YES delegate:self];
        
    }
    
    
}
- (void)requestFinished:(NSDictionary *)dictionary
{
     NSLog(@"Response: %@",dictionary);
    
    if ([[dictionary objectForKey:@"status"]boolValue])
    {
        paymentView *spec = [self.storyboard instantiateViewControllerWithIdentifier:@"paymentView"];
        spec.productPrice = @"1000";
        spec.fromID = [dictionary objectForKey:@"form_id"];
        [self.navigationController pushViewController:spec animated:YES];
    }
    else
    {
        [GlobleClass alert:@"server problam please try again"];
        
        
    }
    [SVProgressHUD dismiss];

}

- (IBAction)CartBTN:(id)sender {
    if (cart == 0)
    {
        [GlobleClass alertWithMassage:@"Your cart is empty , keep shopping !!" Title:@"Alert"];
    }
    else
    {
        cartViewController *spec = [self.storyboard instantiateViewControllerWithIdentifier:@"cartViewController"];
        [self.navigationController pushViewController:spec animated:YES];
    }

    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:true];
    NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
    cart = [[session objectForKey:@"cardQty"] intValue];
    _Cartbutton.badgeValue = [NSString stringWithFormat:@"%d",cart];
    _Cartbutton.badgeBGColor = [UIColor colorWithRed:0.88 green:1.00 blue:0.10 alpha:1.0];
}


@end
