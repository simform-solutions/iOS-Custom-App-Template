//
//  HelperClass.h
//  CusomTemplate
//
//  Created by Tejas Ardeshna on 01/07/15.
//  Copyright (c) 2015 Tejas Ardeshna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTAlertView.h"
@interface HelperClass : NSObject

//Image customization
- (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize;
-(void)makeCircleOf:(UIView *)view;
-(void)makeCircleOf:(UIView *)view withBorderColor:(UIColor *)color andWidth:(int)width;
//date Time customization
-(NSString *)getCurrentTimeZone;

typedef void(^AlertCompletion)(DTAlertView *_alertView, NSUInteger buttonIndex, NSUInteger cancelButtonIndex);
// alert view methods
-(void)showMessage:(NSString *)msg withTitle:(NSString *)title;
-(void)showMessage:(NSString *)msg withTitle:(NSString *)title CancelButtonTitle:(NSString *)cancelTitle PositiveButtonTitle:(NSString *)PositiveTitle WithBlock:(AlertCompletion)compileBlock;

//check connection
- (BOOL)connected;

//check email varification
-(BOOL) NSStringIsValidEmail:(NSString *)checkString;

//random functions
-(NSString *) randomStringWithLength: (int) len;
-(int)getRandomNumberBetween:(int)minNo and:(int)maxNo;

//some basic animations
typedef void (^HelperAnimationFinished)(void);
-(void)bounce:(CGFloat)height of:(UIView *)view finished:(HelperAnimationFinished)finished;
-(void)pulseof:(UIView *)view :(HelperAnimationFinished)finished ;
-(void)shakeof:(UIView*)view :(HelperAnimationFinished)finished;

@end
