//
//  HealerView.m
//  REDO
//
//  Created by apple on 17/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "HealerView.h"

@interface HealerView ()
{
    int cart;
}
@property (weak, nonatomic) IBOutlet UILabel *instructionLBL;

@end

@implementation HealerView

- (void)viewDidLoad {
    [super viewDidLoad];
    isInstructorOpen = NO;
    
    
    NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentJustified;
    style.firstLineHeadIndent = 10.0f;
    style.headIndent = 10.0f;
    style.tailIndent = -10.0f;
    
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:@"\n\nThe world is dominated by Humans, Humans are controlled by their minds. Human mind works as the cycle of balance where negative elements are balanced by positive energies just like: calmness balances unrest, hope balances chaos, love balances hate, peace balances everything and so on. The cycle gets disturbed when positive energies fall short to balance the negative elements.This imbalance causes most of the problems Humanity is facing today be it identity crisis, political issues, hate, greed etc. Hypnosis has this super ability to restore the positive energies. They say the world needs heroes, yes it does but not those who can win wars but those who can heal the people, who can understand the real problems, who can help, who can lead and who can treat pain. With this difficult initiative in our mind, with this hope that we together can make things better for few people to start with and with this vision of bringing the long lost peace of mind, we here at Indian Hypnosis Academy welcomes you." attributes:@{ NSParagraphStyleAttributeName : style}];
    
     _instructionLBL.attributedText = attrText;
    _instructionLBL.font = [UIFont systemFontOfSize:13];
    
    
    _barbutton.target = self.revealViewController;
    _barbutton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    // Do any additional setup after loading the view.
    
    UIToolbar *toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    [toolbar setTintColor:[UIColor lightGrayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"expand2.png"] style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    [self.healer_age setInputAccessoryView:toolbar];
    [self.healer_phone setInputAccessoryView:toolbar];
    [toolbar setItems:[NSArray arrayWithObjects:space, doneBtn,nil]];
    
}
-(void)done
{
    if ([_healer_age isFirstResponder]){
        [self.healer_age resignFirstResponder];
    }else{
         [self.healer_phone resignFirstResponder];
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

- (IBAction)DropDownClicked:(UIButton *)sender {
    
    NSArray * arr = [[NSArray alloc] init];
    CGFloat f;
    if (sender == _healer_gender) {
        arr = [NSArray arrayWithObjects:@"Male", @"Female",nil];
        f = 80;
    }
    else if ( sender == _healer_occup)
    {
        arr = [NSArray arrayWithObjects:@"Student",@"Farming", @"Sales",@"Marketing", @"Engineer",@"Doctor", @"Defence personal",@"Housewife", @"Business",@"Self_Employed", @"Other",nil];
        f = 200;
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


- (void) niDropDownDelegateMethod: (NIDropDown *) sender
{
    [self rel];
}

-(void)rel
{

    dropDown = nil;
}

- (IBAction)submitBTN:(id)sender {
    
    if ([_healer_name.text isEqualToString:@""] || [_healer_age.text isEqualToString:@""]|| [_healer_phone.text isEqualToString:@""]) {
        
        [GlobleClass alertWithMassage:@"Please Fill All The Fields" Title:@"Oppss!!!"];
    }
    else
    {
        NSUserDefaults *session = [NSUserDefaults standardUserDefaults];
        NSString *userid =  [session objectForKey:@"userID"];
        [SVProgressHUD showWithStatus:@"Please Wait..."];
        
        NSDictionary *logins = [[NSDictionary alloc]initWithObjectsAndKeys:_healer_name.text ,@"Name",_healer_age.text,@"Age",_healer_phone.text,@"phoneNo",_healer_gender.titleLabel.text,@"Gender",userid,@"Id",_healer_occup.titleLabel.text,@"occupation",@"healer",@"healer", nil];
        
        NSLog(@"my params %@",logins);
        
        [[ServerController sharedController] callServiceSimplifiedPOST: @"http://www.indianhypnosisacademy.com/api/custom.php" userInfo:logins IsLoader:YES delegate:self];
    }
}
- (void)requestFinished:(NSDictionary *)dictionary
{
    NSLog(@"Response: %@",dictionary);

    if ([[dictionary objectForKey:@"status"]boolValue])
    {
        [GlobleClass alert:[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"msg"]]];
        _healer_name.text = nil;
        _healer_age.text = nil;
        _healer_phone.text=nil;
        _healer_gender.titleLabel.text=nil;
        _healer_occup.titleLabel.text=nil;

        
//        paymentView *spec = [self.storyboard instantiateViewControllerWithIdentifier:@"paymentView"];
//        spec.productPrice = @"3000";
//        [self.navigationController pushViewController:spec animated:YES];
    }
//    else
//    {
//        [GlobleClass alert:@"server problam please try again"];
//        
//        
//    }
    [SVProgressHUD dismiss];
    
}



@end
