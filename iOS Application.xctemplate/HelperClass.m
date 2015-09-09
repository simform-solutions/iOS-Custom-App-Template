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
   // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    //[alert show];
    DTAlertView *alertView = [DTAlertView alertViewWithTitle:title
                                                     message:msg
                                                    delegate:nil cancelButtonTitle:@"Cancel" positiveButtonTitle:nil];
    [alertView show];
    
}
-(void)showMessage:(NSString *)msg withTitle:(NSString *)title CancelButtonTitle:(NSString *)cancelTitle PositiveButtonTitle:(NSString *)PositiveTitle WithBlock:(AlertCompletion)compileBlock
{
    DTAlertView *alertView = [DTAlertView alertViewUseBlock:compileBlock title:@"Barkparks" message:@"Are you sure?" cancelButtonTitle:@"Cancel" positiveButtonTitle:@"Yes"];
    
    [alertView show];
}
#pragma mark - check email validation -
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

#pragma mark - random functions -
-(NSString *) randomStringWithLength: (int) len {
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

-(int)getRandomNumberBetween:(int)minNo and:(int)maxNo
{
   return  rand() % (maxNo - minNo) + minNo;
}

-(UIColor *)getRandomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


#pragma mark - UIAnimations -
-(void)bounce:(CGFloat)height of:(UIView *)view finished:(HelperAnimationFinished)finished
{
    [self moveY:-height duration:0.25 of:view finished:^{
        [self moveY:height duration:0.15 of:view finished:^{
            [self moveY:-(height/2) duration:0.15 of:view finished:^{
                [self moveY:height/2 duration:0.05 of:view finished:^{
                    if(finished)
                        finished();
                }];
            }];
        }];
    }];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)pulseof:(UIView *)view :(HelperAnimationFinished)finished
{
    [UIView animateWithDuration:0.5 animations:^{
        view.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL f){
        [UIView animateWithDuration:0.5 delay:0.1 options:0 animations:^{
            view.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL f){
            if(finished)
                finished();
        }];
    }];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)shakeof:(UIView*)view :(HelperAnimationFinished)finished
{
    float dist = 10;
    [self moveX:-dist duration:0.15 of:view finished:^{
        [self moveX:dist*2 duration:0.15 of:view finished:^{
            [self moveX:-(dist*2) duration:0.15 of:view finished:^{
                [self moveX:dist duration:0.15 of:view finished:^{
                    if(finished)
                        finished();
                }];
            }];
        }];
    }];
}


-(void)moveX:(CGFloat)x duration:(NSTimeInterval)time of:(UIView *)view finished:(HelperAnimationFinished)finished
{
    [self setX:(view.frame.origin.x+x) duration:time of:view finished:finished];
}
-(void)setX:(CGFloat)x duration:(NSTimeInterval)time of:(UIView *)view finished:(HelperAnimationFinished)finished
{
    [UIView animateWithDuration:time animations:^{
        CGRect frame = view.frame;
        frame.origin.x = x;
        view.frame = frame;
    } completion:^(BOOL f){
        if(finished)
            finished();
    }];
}
CGFloat degreesToRadians(CGFloat degrees)
{
    return degrees * M_PI / 180;
}
-(void)setY:(CGFloat)y duration:(NSTimeInterval)time of:(UIView *)view finished:(HelperAnimationFinished)finished
{
    [UIView animateWithDuration:time animations:^{
        CGRect frame = view.frame;
        frame.origin.y = y;
        view.frame = frame;
    }completion:^(BOOL f){
        if(finished)
            finished();
    }];
}

-(void)moveY:(CGFloat)y duration:(NSTimeInterval)time of:(UIView *)view finished:(HelperAnimationFinished)finished
{
    [self setY:(view.frame.origin.y+y) duration:time of:view finished:finished];
}
@end
