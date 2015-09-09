//
//  HelperClass.h
//  CusomTemplate
//
//  Created by Tejas Ardeshna on 01/07/15.
//  Copyright (c) 2015 Tejas Ardeshna. All rights reserved.
//

#import "WebServiceWapper.h"

static WebServiceWapper *instance;


@implementation WebServiceWapper

+(WebServiceWapper *)getInstance{
    if (instance==nil) {
        instance=[[WebServiceWapper alloc]init];
    }
    return instance;
}

+(void)postDataDict:(NSDictionary *)dict ofMethod:(NSString *)str isLoding:(BOOL)loading WithBlock:(myCompletionA)compileBlock{
    if ([objHelper connected]) {
        if (loading) {

            [SVProgressHUD showWithStatus:@"" maskType:SVProgressHUDMaskTypeClear];
        }
       
        NSString *urlString=[[NSString stringWithFormat:@"%@%@",BASE_URL,str] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
       // manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager POST:urlString parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [SVProgressHUD dismiss];
//            NSLog(@"Response : %@",responseObject);
            if ([responseObject[@"status"] isEqualToString:@"success"])
                compileBlock(responseObject,WebServiceResultSuccess);
            
            compileBlock(responseObject,WebServiceResultFail);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSDictionary *errorDict=[[NSDictionary alloc]initWithObjectsAndKeys:error,@"error", nil];
            compileBlock(errorDict,WebServiceResultError);
            NSLog(@"%@",error.description);
            [SVProgressHUD dismiss];
        } ];
    }else{
        [objHelper showMessage:@"No internet connection." withTitle:nil];
    }
}

+(void)getDataDict:(NSDictionary *)dict ofMethod:(NSString *)str isLoding:(BOOL)loading WithBlock:(myCompletionA)compileBlock{
    if ([objHelper connected]) {
        if (loading) {
            [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
            [SVProgressHUD show];
        }
        
        NSString *urlString=[NSString stringWithFormat:@"%@%@",BASE_URL,str];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager GET:urlString parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [SVProgressHUD dismiss];
            if ([responseObject[@"success"] isEqualToString:@"True"])
                compileBlock(dict,WebServiceResultSuccess);
            else
                compileBlock(dict,WebServiceResultFail);
        
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [SVProgressHUD dismiss];
            NSDictionary *errorDict=[[NSDictionary alloc]initWithObjectsAndKeys:error,@"error", nil];
            compileBlock(errorDict,WebServiceResultError);
           
        }];
    }else{
     [objHelper showMessage:@"No internet connection." withTitle:nil];
    }

    
}


+(void)multiPartImageUploadWith:(NSDictionary *)dict ofMethod:(NSString *)strMethod andImage:(UIImage *)image isLoading:(BOOL)loading withBlock:(myCompletionA)compileBlock
{
    if ([objHelper connected])
    {
        
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSMutableData *body = [NSMutableData data];
        
        //1
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"name"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[dict objectForKey:@"name"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        //2
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"email"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[dict objectForKey:@"email"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        //3
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"password"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[dict objectForKey:@"password"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        //4
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"dog_name"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[dict objectForKey:@"dog_name"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        //5
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"breed"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[dict objectForKey:@"breed"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        //6
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"dob"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[dict objectForKey:@"dob"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        //7
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"os"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[dict objectForKey:@"ios"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        //8
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"device"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[dict objectForKey:@"device"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        //9
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"timezone"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[[dict objectForKey:@"timezone"] description] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        if (image!=nil)
        {
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSData* imageData = UIImageJPEGRepresentation(image,0.8); //image compression
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"avatar\"; filename=\"%@.jpg\"\r\n",[self contentTypeForImageData:imageData]] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n"dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[NSData dataWithData:imageData]];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSData *imageData123 = body;
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        config.HTTPMaximumConnectionsPerHost = 1;
        
        [config setTimeoutIntervalForRequest:300];
        
        NSURLSession *upLoadSession;
        NSURLSessionUploadTask *uploadTask;
        upLoadSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        
        
        NSString *Insert_Question=[NSString stringWithFormat:@"%@%@",BASE_URL,strMethod];
        NSURL *url = [NSURL URLWithString:Insert_Question];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        [request setHTTPMethod:@"post"];
        
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        [request setTimeoutInterval:300];
        [request setAllowsCellularAccess:YES];
        
        uploadTask=[upLoadSession uploadTaskWithRequest:request fromData:imageData123 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSMutableDictionary *dict1=[[NSMutableDictionary alloc]init];
                NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                dict1=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
                [SVProgressHUD dismiss];
                if ([[dict1 valueForKey:@"status"] isEqualToString:@"success"])
                {
                    compileBlock(dict1,WebServiceResultSuccess);
                }
                else
                {
                    [SVProgressHUD dismiss];
                    compileBlock(dict1,WebServiceResultFail);
                }
            });
        }];
        
        [uploadTask resume];
    }
    else
    {
        [objHelper showMessage:@"No internet connection." withTitle:nil];
    }

}
+ (NSString *)contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
    }
    return nil;
}

@end

