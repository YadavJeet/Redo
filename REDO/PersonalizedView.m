//
//  PersonalizedView.m
//  REDO
//
//  Created by apple on 10/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "PersonalizedView.h"
#import "Header.h"
#import "NIDropDown.h"
#import "cartViewController.h"
#import "paymentView.h"

@interface PersonalizedView ()<NIDropDownDelegate>{
    bool isInstructorOpen;
    NIDropDown *dropDown;
    UIPickerView *picker;
    UIDatePicker *datePicker;
    UIDatePicker *timePicker;
    int cart;
}
@property (weak, nonatomic) IBOutlet UILabel *InstructionsLbl;

@end

@implementation PersonalizedView

-(void)datePickerValueChanged{
    NSLog(@"%@",datePicker.date);
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    
    NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:datePicker.date]];
    _personl_date.text = str;
    //assign text to label
    NSLog(@"Date %@",str);
    
}
-(void)datePickerValueChanged1{
    
    NSLog(@"%@",timePicker.date);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm a"];
    NSString *currentTime = [dateFormatter stringFromDate:timePicker.date];
    _personl_time.text = currentTime;
    NSLog(@"time %@",currentTime);
    
}
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    if ([_personl_date isFirstResponder]) {
        [self datePickerValueChanged];
    }
    else if ([_personl_time isFirstResponder]){
        [self datePickerValueChanged1];
    }
//    
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
    isInstructorOpen = NO;
    NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentJustified;
    style.firstLineHeadIndent = 10.0f;
    style.headIndent = 10.0f;
    style.tailIndent = -10.0f;
    
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:@"\nHave your own private live hypnotherapy session right on your phone with our certified hypnotherapist. Get your psychological issues healed at the comfort of your own place and time. The hypnotherapy session will be for 1 hour at 3500 per session and Past Life Regression Session will be for 90 minutes at INR 4500 per session. The personalised hypnotherapy session also included counselling inputs in the beginning where you can explain your issues/ concerns to the hypnotherapist for best results.\n\nHow it works: \n\n1. Fill the form below and enter a phone number to reach you\n2. Select the date and your preferred time\n3. Make the payment\n4. You will receive a call from our executive who will reconfirm your appointment\n5. You will receive a call from our counsellor as per appointment" attributes:@{ NSParagraphStyleAttributeName : style}];
    
     _InstructionsLbl.attributedText = attrText;
    

    _barbutton.target = self.revealViewController;
    _barbutton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    // Do any additional setup after loading the view.
    
    
    datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setDate:[NSDate date]];
    [datePicker setMinimumDate:[NSDate date]];
    
    [datePicker addTarget:self action:@selector(datePickerValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.personl_date setInputView:datePicker];
    
    timePicker = [[UIDatePicker alloc]init];
    timePicker.locale = [NSLocale currentLocale];
    timePicker.timeZone = [NSTimeZone localTimeZone];
    timePicker.datePickerMode = UIDatePickerModeTime;
    [timePicker setDate:[NSDate date]];
    
    [timePicker addTarget:self action:@selector(datePickerValueChanged1) forControlEvents:UIControlEventValueChanged];
    [self.personl_time setInputView:timePicker];
    
    
    
    
    UIToolbar *toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    [toolbar setTintColor:[UIColor lightGrayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expand2.png"] style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self.personal_age setInputAccessoryView:toolbar];
    [self.personl_phone setInputAccessoryView:toolbar];
    [toolbar setItems:[NSArray arrayWithObjects:space, doneBtn,nil]];
    
}
-(void)done
{
    if ([_personal_age isFirstResponder]){
        [self.personal_age resignFirstResponder];
    }else{
        [self.personl_phone resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:true];
    NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
     cart = [[session objectForKey:@"cardQty"] intValue];
    _Cartbutton.badgeValue = [NSString stringWithFormat:@"%d",cart];
    _Cartbutton.badgeBGColor = [UIColor colorWithRed:0.88 green:1.00 blue:0.10 alpha:1.0];
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
    if (sender == _personl_gender) {
        arr = [NSArray arrayWithObjects:@"Male", @"Female",nil];
        f = 80;
    }
    else if ( sender == _personl_language)
    {
        arr = [NSArray arrayWithObjects:@"Hindi", @"English",nil];
        f = 80;
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

- (IBAction)submitBTN:(id)sender {
    
    if ([_personl_name.text isEqualToString:@""] || [_personal_age.text isEqualToString:@""]|| [_personl_address.text isEqualToString:@""]|| [_personl_email.text isEqualToString:@""]|| [_personl_city.text isEqualToString:@""]|| [_personal_state.text isEqualToString:@""]|| [_personl_country.text isEqualToString:@""]|| [_personl_phone.text isEqualToString:@""]|| [_personl_date.text isEqualToString:@""]|| [_personl_time.text isEqualToString:@""]) {
        
        [GlobleClass alertWithMassage:@"Please Fill All The Fields" Title:@"Oppss!!!"];
    }
    else if (![ GlobleClass NSStringIsValidEmail:_personl_email.text]) {
        
        [GlobleClass alertWithMassage:@"Enter valid Email ID" Title:@"Alert"];
        
    }
    else
    {
        ;
        NSString *userid =  [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
        [SVProgressHUD showWithStatus:@"Please Wait..."];
        
        NSDictionary *logins = [[NSDictionary alloc]initWithObjectsAndKeys:_personl_name.text ,@"Name",_personl_address.text,@"Address",_personl_email.text,@"email",_personl_city.text,@"City",_personal_state.text,@"State",@"professions",@"professions" ,_personal_age.text,@"Age",_personl_phone.text ,@"phoneNo",_personl_date.text,@"preferedDate",_personl_time.text,@"preferedTime",_personl_gender.titleLabel.text,@"Gender",_personl_language.titleLabel.text,@"Language",_personl_country.text ,@"Country",userid,@"Id",@"",@"Issue", nil];
        
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
        spec.productPrice = @"3000";
        [self.navigationController pushViewController:spec animated:YES];
    }
    else
    {
        [GlobleClass alert:@"server problam please try again"];
        
        
    }
    [SVProgressHUD dismiss];
    
}

@end
