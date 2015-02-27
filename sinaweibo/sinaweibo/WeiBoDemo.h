//
//  WeiBoDemo.h
//  sinaweibo
//
//  Created by aoi on 15/2/26.
//  Copyright (c) 2015年 cezr. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WeiboSDK.h"

#define kAppKey         @"4133137512"
#define kRedirectURI    @"https://api.weibo.com/oauth2/default.html"

@interface WeiBoDemo : NSObject
<WeiboSDKDelegate, WBHttpRequestDelegate>

@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbCurrentUserID;

+(instancetype)sharedWeiBo;

/**
    SSO授权
 */
-(BOOL)sigin;

/**
    发微博
    参数:
 */
-(BOOL)sendMsgText:(NSString *)text Image:(UIImage *)image;


@end
