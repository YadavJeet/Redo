//
//  mDietGuru
//
//  Created by Navjot Singh on 2/23/16.
//  Copyright (c) 2016 eMeN_Global_Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerController.h"
#import "AFNetworking.h"
@protocol ServerProtocol <NSObject>
- (void)requestFinished:(NSDictionary *)dictionary;
@end

@interface ServerController : NSObject <NSXMLParserDelegate>

{
    NSDictionary *vars;
    NSString* aUrl;
    int hitCount;
    
}
@property (nonatomic, assign) id<ServerProtocol> delegate;

+ (ServerController *)sharedController;
+(AFHTTPRequestOperationManager*)GetserverManager;


- (void)callServiceSimplifiedGET:(NSString *)url userInfo:(NSDictionary *)userParams  IsLoader:(BOOL)isLoader delegate:(id)delegate;

- (void)callServiceSimplifiedPOST:(NSString *)url userInfo:(NSDictionary *)userParams  IsLoader:(BOOL)isLoader delegate:(id)delegate;


@end
