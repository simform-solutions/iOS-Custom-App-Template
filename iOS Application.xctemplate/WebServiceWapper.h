//
//  HelperClass.h
//  CusomTemplate
//
//  Created by Tejas Ardeshna on 01/07/15.
//  Copyright (c) 2015 Tejas Ardeshna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"

typedef NS_ENUM (NSInteger, WebServiceResult)
{
    WebServiceResultSuccess = 0,
    WebServiceResultFail,
    WebServiceResultError
};

typedef void(^myCompletion)(NSDictionary *data,WebServiceResult result);
typedef void(^myCompletionA)(NSDictionary *data,WebServiceResult result);



@interface WebServiceWapper : NSObject<NSURLSessionDelegate,NSURLSessionDataDelegate>


+(WebServiceWapper *)getInstance;

+(void)postDataDict:(NSDictionary *)dict ofMethod:(NSString *)str isLoding:(BOOL)loading WithBlock:(myCompletionA)compileBlock;
+(void)getDataDict:(NSDictionary *)dict ofMethod:(NSString *)str isLoding:(BOOL)loading WithBlock:(myCompletionA)compileBlock;

+(void)multiPartImageUploadWith:(NSDictionary *)dict ofMethod:(NSString *)strMethod andImage:(UIImage *)image isLoading:(BOOL)loading withBlock:(myCompletionA)compileBlock;
@end
