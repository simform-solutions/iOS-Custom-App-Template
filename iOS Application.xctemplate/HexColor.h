//
//  HexColor.h
//
//  CusomTemplate
//
//  Created by Tejas Ardeshna on 01/07/15.
//  Copyright (c) 2015 Tejas Ardeshna. All rights reserved.
//

#if (TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE)
    #import <UIKit/UIKit.h>
    #define HXColor UIColor
#else
    #import <Foundation/Foundation.h>
    #define HXColor NSColor
#endif

@interface HXColor (HexColorAddition)

+ (HXColor *)colorWithHexString:(NSString *)hexString;
+ (HXColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (HXColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;
+ (HXColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;

@end
