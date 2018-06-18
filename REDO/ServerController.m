//
//  mDietGuru
//
//  Created by Navjot Singh on 2/23/16.
//  Copyright (c) 2016 eMeN_Global_Solutions. All rights reserved.
//

#import "ServerController.h"
#import "Reachability.h"
#import "SVProgressHUD.h"

@implementation ServerController

static ServerController* _sharedServerController;
@synthesize delegate = delegate_;
- (id)init
{
    if (self = [ super init ] )
    {
        hitCount = 0;
    }
    return self;
}

+ (ServerController *)sharedController {
    
    @synchronized(self) {
        if (_sharedServerController == nil) {
            _sharedServerController = [[self alloc] init];
        }
    }
    return _sharedServerController;
}

- (BOOL)checkNetworkStatusWithAlert:(BOOL)shouldAlert
{
    Reachability *internetReachable = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    BOOL isNetworkAvail = YES;
    
    switch (internetStatus)
    {
        case NotReachable:
        {
            NSLog(@"The internet is down.");
            isNetworkAvail = NO;
            break;
            
        }
        case ReachableViaWiFi:
        {
            NSLog(@"The internet is working via WIFI.");
            isNetworkAvail = YES;
            break;
            
        }
        case ReachableViaWWAN:
        {
            NSLog(@"The internet is working via WWAN.");
            isNetworkAvail = YES;
            break;
        }
    }
    
    if(isNetworkAvail == NO && shouldAlert == YES) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No internet connection!" message:@"Internet connection appears to be offline. Try again." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        [alert show];
        [SVProgressHUD dismiss];
    }
    
    return isNetworkAvail;
}

- (void)callServiceSimplifiedGET:(NSString *)url userInfo:(NSDictionary *)userParams  IsLoader:(BOOL)isLoader delegate:(id)delegate
{
    self.delegate = delegate;
    if (isLoader){
        [SVProgressHUD showWithStatus:@"Please Wait..."];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    }
    if (![self checkNetworkStatusWithAlert:YES]) {
        [SVProgressHUD dismiss];
        return;
    }
    
    NSDictionary *parameters = [userParams mutableCopy];
    if (!parameters) {
        parameters = userParams;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    operation.userInfo = userParams;
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *res = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"Success:callServiceSimplified:*******%@", res);
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestFinished:)]) {
            [self.delegate requestFinished:res];
            [SVProgressHUD dismiss];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        
        [[[UIAlertView alloc] initWithTitle:@"Error!" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        NSLog(@"error %@",[error localizedDescription]);
    }];
    
    [operation start];
    
}



- (void)callServiceSimplifiedPOST:(NSString *)url userInfo:(NSDictionary *)userParams  IsLoader:(BOOL)isLoader delegate:(id)delegate
{
    self.delegate = delegate;
    vars = userParams;
    aUrl = url;
    
    if (![self checkNetworkStatusWithAlert:YES]) {
        return;
    }
    
    NSDictionary *parameters = [userParams mutableCopy];
    if (!parameters) {
        parameters = userParams;
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *res = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
        [manager.requestSerializer setTimeoutInterval:120];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestFinished:)]) {
            [self.delegate requestFinished:res];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (hitCount <3) {
            [self callServiceSimplifiedPOST:aUrl userInfo:vars IsLoader:YES delegate:self.delegate];
            hitCount ++;
        }
        else{
            [SVProgressHUD dismiss];
            [[[UIAlertView alloc] initWithTitle:@"Error!" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }
        
        
    }];
    
}


+(AFHTTPRequestOperationManager*)GetserverManager
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    ServerController *sv = [[ServerController alloc]init];
    
    if (![sv checkNetworkStatusWithAlert:YES]) {
        
        [SVProgressHUD dismiss];
        return NULL;
    }
    
    return manager;
}



@end
