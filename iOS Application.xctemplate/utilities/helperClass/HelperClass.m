//
//  HelperClass.m
//  CusomTemplate
//
//  Created by Tejas Ardeshna on 01/07/15.
//  Copyright (c) 2015 Tejas Ardeshna. All rights reserved.
//

#import "HelperClass.h"

@implementation HelperClass
#ifndef NSDateTimeAgoLocalizedStrings
#define NSDateTimeAgoLocalizedStrings(key) \
NSLocalizedStringFromTableInBundle(key, @"NSDateTimeAgo", [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"NSDateTimeAgo.bundle"]], nil)
#endif


#pragma mark - square Image
- (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize //this make image square from landscape / portrait (ratio is maintained)
{
    CGAffineTransform scaleTransform;
    CGPoint origin;
    if (image.size.width > image.size.height)
    {
        CGFloat scaleRatio = newSize / image.size.height;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        origin = CGPointMake(-(image.size.width - image.size.height) / 2.0f, 0);
    }
    else
    {
        CGFloat scaleRatio = newSize / image.size.width;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        origin = CGPointMake(0, -(image.size.height - image.size.width) / 2.0f);
    }
    CGSize size = CGSizeMake(newSize, newSize);
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
    {
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    }
    else
    {
        UIGraphicsBeginImageContext(size);
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(context, scaleTransform);
    [image drawAtPoint:origin];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(void)makeCircleOf:(UIView *)view
{
    [view.layer setCornerRadius:view.frame.size.height/2];
    view.layer.masksToBounds=true;
}
-(void)makeCircleOf:(UIView *)view withBorderColor:(UIColor *)color andWidth:(int)borderWidth
{
    if (color==nil)
    {
        color=[UIColor whiteColor];
    }
    if (borderWidth<=0)
    {
        borderWidth=1;
    }
    [view.layer setCornerRadius:view.frame.size.height/2];
    [view.layer setBorderColor:color.CGColor];
    [view.layer setBorderWidth:borderWidth];
    view.layer.masksToBounds=true;

}
#pragma mark - get current timezone -
-(NSString *)getCurrentTimeZone
{
    return [NSTimeZone systemTimeZone].name;
}


#pragma - Rechability test -
- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}
#pragma mark - display alert -
-(void)showMessage:(NSString *)msg withTitle:(NSString *)title
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
}


@end
