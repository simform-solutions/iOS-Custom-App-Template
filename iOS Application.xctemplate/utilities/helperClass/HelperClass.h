//
//  HelperClass.h
//  CusomTemplate
//
//  Created by Tejas Ardeshna on 01/07/15.
//  Copyright (c) 2015 Tejas Ardeshna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HelperClass : NSObject

//Image customization
- (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize;
-(void)makeCircleOf:(UIView *)view;
-(void)makeCircleOf:(UIView *)view withBorderColor:(UIColor *)color andWidth:(int)width;
//date Time customization
-(NSString *)getCurrentTimeZone;


// alert view methods
-(void)showMessage:(NSString *)msg withTitle:(NSString *)title;

//check connection
- (BOOL)connected;


@end
