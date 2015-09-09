//
//  HelperClass.h
//  CusomTemplate
//
//  Created by Tejas Ardeshna on 01/07/15.
//  Copyright (c) 2015 Tejas Ardeshna. All rights reserved.
//



@interface NSDate (TimeAgo)
- (NSString *) timeAgoSimple;
- (NSString *) timeAgo;
- (NSString *) timeAgoWithLimit:(NSTimeInterval)limit;
- (NSString *) timeAgoWithLimit:(NSTimeInterval)limit dateFormat:(NSDateFormatterStyle)dFormatter andTimeFormat:(NSDateFormatterStyle)tFormatter;
- (NSString *) timeAgoWithLimit:(NSTimeInterval)limit dateFormatter:(NSDateFormatter *)formatter;

// this method only returns "{value} {unit} ago" strings and no "yesterday"/"last month" strings
- (NSString *)dateTimeAgo;

// this method gives when possible the date compared to the current calendar date: "this morning"/"yesterday"/"last week"/..
// when more precision is needed (= less than 6 hours ago) it returns the same output as dateTimeAgo
- (NSString *)dateTimeUntilNow;

//this method give you next date obj
-(NSDate *)nextDate;
//linux time stamp
-(NSString *)getCurrentTimeStamp;
-(NSDate *)getDateFromTimeStamp:(int)timeStamp;
//google server date will be returned
+(NSDate *) serverDate;

-(int)daysBetween:(NSDate *)fromDate :(NSDate *)toDate;
@end

