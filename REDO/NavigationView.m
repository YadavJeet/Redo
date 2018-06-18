//
//  NavigationView.m
//  REDO
//
//  Created by apple on 09/03/17.
//  Copyright © 2017 jitendra yadav. All rights reserved.
//

#import "NavigationView.h"
#import "ProductShowView.h"
#import "Header.h"

@interface NavigationView ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *menu;
    NSArray *menuicone;
    UILabel * maillabel;
    NSUserDefaults *session;
    UIImageView *imageView;
    UIView* headerView;
    UIImage *img;
    UILabel * namelabel;
}

@end

@implementation NavigationView

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    menu = @[@"one", @"two", @"three", @"four",@"zero", @"five",@"six",@"seven", @"eight", @"nine", @"ten", @"nextone",@"nextonenext"];
    
    menuicone = @[@"sound", @"live", @"personal", @"healer",@"", @"training",@"book",@"e-book", @"course",@"personal", @"about", @"about", @"contacts"];
    
    session = [NSUserDefaults standardUserDefaults];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [menu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [menu objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor  = [UIColor blackColor];
    tableView.separatorColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:[menuicone objectAtIndex:indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    headerView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    
    
    
   img = [[UIImage alloc] init];
    
    if ([session objectForKey:@"profileImage"] != nil){
        NSData *profileData = [[NSData alloc] initWithData:[session objectForKey:@"profileImage"]];
        img = [[UIImage alloc] initWithData:profileData];
    }else{
        img = [UIImage imageNamed:@"userimage.png"];
        
    }
    imageView = [[UIImageView alloc] initWithImage:img];
    imageView.frame = CGRectMake(10,10,60,60);
    [headerView addSubview:imageView];
    
    namelabel = [[UILabel alloc]init];
    namelabel.frame = CGRectMake(80, 20,headerView.frame.size.width, 20);
    namelabel.text = @"      Hello";
    namelabel.textAlignment = NSTextAlignmentLeft;
    [namelabel setFont:[UIFont boldSystemFontOfSize:17]];
    namelabel.numberOfLines = 1;
    namelabel.adjustsFontSizeToFitWidth = YES;
    [headerView addSubview:namelabel];
    
    maillabel = [[UILabel alloc]init];
    maillabel.frame = CGRectMake(100, 45,headerView.frame.size.width, 20);
    maillabel.textAlignment = NSTextAlignmentLeft;
    maillabel.numberOfLines = 1;
    maillabel.adjustsFontSizeToFitWidth = YES;
    [maillabel setFont:[UIFont boldSystemFontOfSize:17]];
    NSLog(@"%@",[session objectForKey:@"username"]);
    maillabel.text = [[session objectForKey:@"username"]capitalizedString];
    [headerView addSubview:maillabel];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"book"])
    {
        UINavigationController *navCtrl = (UINavigationController *)[segue destinationViewController];
        ProductShowView *tableVC = (ProductShowView *)navCtrl.topViewController;
        tableVC.identifire = @"books";
    }
    else if ([segue.identifier isEqualToString:@"ebook"])
    {
        UINavigationController *navCtrl = (UINavigationController *)[segue destinationViewController];
        ProductShowView *tableVC = (ProductShowView *)navCtrl.topViewController;
        tableVC.identifire = @"e-books";
    }
    else if ([segue.identifier isEqualToString:@"training"])
    {
        UINavigationController *navCtrl = (UINavigationController *)[segue destinationViewController];
        ProductShowView *tableVC = (ProductShowView *)navCtrl.topViewController;
        tableVC.identifire = @"training-course";
    }else if ([segue.identifier isEqualToString:@"ecore"])
    {
        UINavigationController *navCtrl = (UINavigationController *)[segue destinationViewController];
        ProductShowView *tableVC = (ProductShowView *)navCtrl.topViewController;
        tableVC.identifire = @"e-course";
    }
}


@end
