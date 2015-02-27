//
//  WeiBoDemo.m
//  sinaweibo
//
//  Created by aoi on 15/2/26.
//  Copyright (c) 2015年 cezr. All rights reserved.
//

#import "WeiBoDemo.h"

WeiBoDemo *weiboDemo = nil;

@interface WeiBoDemo ()

{
    NSString *token;
    NSString *userID;
}

@end

@implementation WeiBoDemo

-(instancetype)init {
    if (self = [super init]) {
        [WeiboSDK enableDebugMode:YES];
        if ([WeiboSDK registerApp:kAppKey]) {
            NSLog(@"登陆成功");
        }
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:@"/Users/aoi/Downloads/ax.txt"];
        
        token = [dic valueForKey:@"token"];
        userID = [dic valueForKey:@"userID"];
        
        NSLog(@"\ntoken:%@\tuserID:%@", token, userID);
        
    }
    return self;
}

+(instancetype)sharedWeiBo {
    if (weiboDemo == nil) {
        weiboDemo = [[WeiBoDemo alloc] init];
    }
    return weiboDemo;
}


-(BOOL)sigin {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"ViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    return [WeiboSDK sendRequest:request];
}

-(BOOL)sendMsgText:(NSString *)text Image:(UIImage *)image {
    //AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    WBMessageObject *message = [WBMessageObject message];
    message.text = text;
    
    WBImageObject *wbImage = [WBImageObject object];
    wbImage.imageData = UIImagePNGRepresentation(image);
    message.imageObject = wbImage;
    
    
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:token];
   /* request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};*/
    return [WeiboSDK sendRequest:request];
}












-(void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}
-(void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *title = NSLocalizedString(@"认证结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken],  NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        
        token = [(WBAuthorizeResponse *)response accessToken];
        userID = [(WBAuthorizeResponse *)response userID];
        [alert show];
        
        NSLog(@"token: %@", self.wbtoken);
        
        
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:token forKey:@"token"];
        [dic setValue:userID forKey:@"userID"];
        
        [dic writeToFile:@"/Users/aoi/Downloads/ax.txt" atomically:YES];
        
        
    }
}



@end
