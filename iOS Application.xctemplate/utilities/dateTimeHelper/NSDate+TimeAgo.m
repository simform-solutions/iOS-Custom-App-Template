
//
//  HelperClass.h
//  CusomTemplate
//
//  Created by Tejas Ardeshna on 01/07/15.
//  Copyright (c) 2015 Tejas Ardeshna. All rights reserved.
//

#import "NSDate+TimeAgo.h"

#define _SD_SERVER @"http://google.com/"
#define _SD_FORMAT @"EEE, dd MMM yyyy HH:mm:ss z"

static NSTimeInterval   _SDInterval;

@interface NSDate()

-(NSString *)getLocaleFormatUnderscoresWithValue:(double)value;

@end

@implementation NSDate (TimeAgo)

#ifndef NSDateTimeAgoLocalizedStrings
#define NSDateTimeAgoLocalizedStrings(key) \
NSLocalizedStringFromTableInBundle(key, @"NSDateTimeAgo", [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"NSDateTimeAgo.bundle"]], nil)
#endif

// shows 1 or two letter abbreviation for units.
// does not include 'ago' text ... just {value}{unit-abbreviation}
// does not include interim summary options such as 'Just now'
- (NSString *)timeAgoSimple
{
    NSDate *now = [NSDate date];
    double deltaSeconds = fabs([self timeIntervalSinceDate:now]);
    double deltaMinutes = deltaSeconds / 60.0f;
    
    int value;
    
    if(deltaSeconds < 60)
    {
        return [self stringFromFormat:@"%%d%@s" withValue:deltaSeconds];
    }
    else if (deltaMinutes < 60)
    {
        return [self stringFromFormat:@"%%d%@m" withValue:deltaMinutes];
    }
    else if (deltaMinutes < (24 * 60))
    {
        value = (int)floor(deltaMinutes/60);
        return [self stringFromFormat:@"%%d%@h" withValue:value];
    }
    else if (deltaMinutes < (24 * 60 * 7))
    {
        value = (int)floor(deltaMinutes/(60 * 24));
        return [self stringFromFormat:@"%%d%@d" withValue:value];
    }
    else if (deltaMinutes < (24 * 60 * 31))
    {
        value = (int)floor(deltaMinutes/(60 * 24 * 7));
        return [self stringFromFormat:@"%%d%@w" withValue:value];
    }
    else if (deltaMinutes < (24 * 60 * 365.25))
    {
        value = (int)floor(deltaMinutes/(60 * 24 * 30));
        return [self stringFromFormat:@"%%d%@mo" withValue:value];
    }
    
    value = (int)floor(deltaMinutes/(60 * 24 * 365));
    return [self stringFromFormat:@"%%d%@yr" withValue:value];
}

- (NSString *)timeAgo
{
    NSDate *now = [NSDate date];
    double deltaSeconds = fabs([self timeIntervalSinceDate:now]);
    double deltaMinutes = deltaSeconds / 60.0f;
    
    int minutes;
    
    if(deltaSeconds < 5)
    {
        return NSDateTimeAgoLocalizedStrings(@"Just now");
    }
    else if(deltaSeconds < 60)
    {
        return [self stringFromFormat:@"%%d %@seconds ago" withValue:deltaSeconds];
    }
    else if(deltaSeconds < 120)
    {
        return NSDateTimeAgoLocalizedStrings(@"A minute ago");
    }
    else if (deltaMinutes < 60)
    {
        return [self stringFromFormat:@"%%d %@minutes ago" withValue:deltaMinutes];
    }
    else if (deltaMinutes < 120)
    {
        return NSDateTimeAgoLocalizedStrings(@"An hour ago");
    }
    else if (deltaMinutes < (24 * 60))
    {
        minutes = (int)floor(deltaMinutes/60);
        return [self stringFromFormat:@"%%d %@hours ago" withValue:minutes];
    }
    else if (deltaMinutes < (24 * 60 * 2))
    {
        return NSDateTimeAgoLocalizedStrings(@"Yesterday");
    }
    else if (deltaMinutes < (24 * 60 * 7))
    {
        minutes = (int)floor(deltaMinutes/(60 * 24));
        return [self stringFromFormat:@"%%d %@days ago" withValue:minutes];
    }
    else if (deltaMinutes < (24 * 60 * 14))
    {
        return NSDateTimeAgoLocalizedStrings(@"Last week");
    }
    else if (deltaMinutes < (24 * 60 * 31))
    {
        minutes = (int)floor(deltaMinutes/(60 * 24 * 7));
        return [self stringFromFormat:@"%%d %@weeks ago" withValue:minutes];
    }
    else if (deltaMinutes < (24 * 60 * 61))
    {
        return NSDateTimeAgoLocalizedStrings(@"Last month");
    }
    else if (deltaMinutes < (24 * 60 * 365.25))
    {
        minutes = (int)floor(deltaMinutes/(60 * 24 * 30));
        return [self stringFromFormat:@"%%d %@months ago" withValue:minutes];
    }
    else if (deltaMinutes < (24 * 60 * 731))
    {
        return NSDateTimeAgoLocalizedStrings(@"Last year");
    }
    
    minutes = (int)floor(deltaMinutes/(60 * 24 * 365));
    return [self stringFromFormat:@"%%d %@years ago" withValue:minutes];
}

// Similar to timeAgo, but only returns "
- (NSString *)dateTimeAgo
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate * now = [NSDate date];
    NSDateComponents *components = [calendar components:
                                    NSCalendarUnitYear|
                                    NSCalendarUnitMonth|
                                    NSCalendarUnitWeekOfYear|
                                    NSCalendarUnitDay|
                                    NSCalendarUnitHour|
                                    NSCalendarUnitMinute|
                                    NSCalendarUnitSecond
                                               fromDate:self
                                                 toDate:now
                                                options:0];
    
    if (components.year >= 1)
    {
        if (components.year == 1)
        {
            return NSDateTimeAgoLocalizedStrings(@"1 year ago");
        }
        return [self stringFromFormat:@"%%d %@years ago" withValue:components.year];
    }
    else if (components.month >= 1)
    {
        if (components.month == 1)
        {
            return NSDateTimeAgoLocalizedStrings(@"1 month ago");
        }
        return [self stringFromFormat:@"%%d %@months ago" withValue:components.month];
    }
    else if (components.weekOfYear >= 1)
    {
        if (components.weekOfYear == 1)
        {
            return NSDateTimeAgoLocalizedStrings(@"1 week ago");
        }
        return [self stringFromFormat:@"%%d %@weeks ago" withValue:components.weekOfYear];
    }
    else if (components.day >= 1)    // up to 6 days ago
    {
        if (components.day == 1)
        {
            return NSDateTimeAgoLocalizedStrings(@"1 day ago");
        }
        return [self stringFromFormat:@"%%d %@days ago" withValue:components.day];
    }
    else if (components.hour >= 1)   // up to 23 hours ago
    {
        if (components.hour == 1)
        {
            return NSDateTimeAgoLocalizedStrings(@"An hour ago");
        }
        return [self stringFromFormat:@"%%d %@hours ago" withValue:components.hour];
    }
    else if (components.minute >= 1) // up to 59 minutes ago
    {
        if (components.minute == 1)
        {
            return NSDateTimeAgoLocalizedStrings(@"A minute ago");
        }
        return [self stringFromFormat:@"%%d %@minutes ago" withValue:components.minute];
    }
    else if (components.second < 5)
    {
        return NSDateTimeAgoLocalizedStrings(@"Just now");
    }
    
    // between 5 and 59 seconds ago
    return [self stringFromFormat:@"%%d %@seconds ago" withValue:components.second];
}



- (NSString *)dateTimeUntilNow
{
    NSDate * now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitHour
                                               fromDate:self
                                                 toDate:now
                                                options:0];
    
    if (components.hour >= 6) // if more than 6 hours ago, change precision
    {
        NSInteger startDay = [calendar ordinalityOfUnit:NSCalendarUnitDay
                                                 inUnit:NSCalendarUnitEra
                                                forDate:self];
        NSInteger endDay = [calendar ordinalityOfUnit:NSCalendarUnitDay
                                               inUnit:NSCalendarUnitEra
                                              forDate:now];
        
        NSInteger diffDays = endDay - startDay;
        if (diffDays == 0) // today!
        {
            NSDateComponents * startHourComponent = [calendar components:NSCalendarUnitHour fromDate:self];
            NSDateComponents * endHourComponent = [calendar components:NSCalendarUnitHour fromDate:self];
            if (startHourComponent.hour < 12 &&
                endHourComponent.hour > 12)
            {
                return NSDateTimeAgoLocalizedStrings(@"This morning");
            }
            else if (startHourComponent.hour >= 12 &&
                     startHourComponent.hour < 18 &&
                     endHourComponent.hour >= 18)
            {
                return NSDateTimeAgoLocalizedStrings(@"This afternoon");
            }
            return NSDateTimeAgoLocalizedStrings(@"Today");
        }
        else if (diffDays == 1)
        {
            return NSDateTimeAgoLocalizedStrings(@"Yesterday");
        }
        else
        {
            NSInteger startWeek = [calendar ordinalityOfUnit:NSCalendarUnitWeekOfYear
                                                      inUnit:NSCalendarUnitEra
                                                     forDate:self];
            NSInteger endWeek = [calendar ordinalityOfUnit:NSCalendarUnitWeekOfYear
                                                    inUnit:NSCalendarUnitEra
                                                   forDate:now];
            NSInteger diffWeeks = endWeek - startWeek;
            if (diffWeeks == 0)
            {
                return NSDateTimeAgoLocalizedStrings(@"This week");
            }
            else if (diffWeeks == 1)
            {
                return NSDateTimeAgoLocalizedStrings(@"Last week");
            }
            else
            {
                NSInteger startMonth = [calendar ordinalityOfUnit:NSCalendarUnitMonth
                                                           inUnit:NSCalendarUnitEra
                                                          forDate:self];
                NSInteger endMonth = [calendar ordinalityOfUnit:NSCalendarUnitMonth
                                                         inUnit:NSCalendarUnitEra
                                                        forDate:now];
                NSInteger diffMonths = endMonth - startMonth;
                if (diffMonths == 0)
                {
                    return NSDateTimeAgoLocalizedStrings(@"This month");
                }
                else if (diffMonths == 1)
                {
                    return NSDateTimeAgoLocalizedStrings(@"Last month");
                }
                else
                {
                    NSInteger startYear = [calendar ordinalityOfUnit:NSCalendarUnitYear
                                                              inUnit:NSCalendarUnitEra
                                                             forDate:self];
                    NSInteger endYear = [calendar ordinalityOfUnit:NSCalendarUnitYear
                                                            inUnit:NSCalendarUnitEra
                                                           forDate:now];
                    NSInteger diffYears = endYear - startYear;
                    if (diffYears == 0)
                    {
                        return NSDateTimeAgoLocalizedStrings(@"This year");
                    }
                    else if (diffYears == 1)
                    {
                        return NSDateTimeAgoLocalizedStrings(@"Last year");
                    }
                }
            }
        }
    }
    
    // anything else uses "time ago" precision
    return [self dateTimeAgo];
}



- (NSString *) stringFromFormat:(NSString *)format withValue:(NSInteger)value
{
    NSString * localeFormat = [NSString stringWithFormat:format, [self getLocaleFormatUnderscoresWithValue:value]];
    return [NSString stringWithFormat:NSDateTimeAgoLocalizedStrings(localeFormat), value];
}

- (NSString *) timeAgoWithLimit:(NSTimeInterval)limit
{
    return [self timeAgoWithLimit:limit dateFormat:NSDateFormatterFullStyle andTimeFormat:NSDateFormatterFullStyle];
}

- (NSString *) timeAgoWithLimit:(NSTimeInterval)limit dateFormat:(NSDateFormatterStyle)dFormatter andTimeFormat:(NSDateFormatterStyle)tFormatter
{
    if (fabs([self timeIntervalSinceDate:[NSDate date]]) <= limit)
        return [self timeAgo];
    
    return [NSDateFormatter localizedStringFromDate:self
                                          dateStyle:dFormatter
                                          timeStyle:tFormatter];
}

- (NSString *) timeAgoWithLimit:(NSTimeInterval)limit dateFormatter:(NSDateFormatter *)formatter
{
    if (fabs([self timeIntervalSinceDate:[NSDate date]]) <= limit)
        return [self timeAgo];

    return [formatter stringFromDate:self];
}
-(NSDate *)nextDate
{
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:[NSDate date] options:0];
    return nextDate;
}
-(NSString *)getCurrentTimeStamp
{
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
}
-(NSDate *)getDateFromTimeStamp:(int)timeStamp
{
    return  [NSDate dateWithTimeIntervalSince1970:timeStamp];
}

+(NSDate *)serverDate{
    if(!_SDInterval){
        [self _SDresetServerTime];
    }
    
    return [[NSDate date] dateByAddingTimeInterval: _SDInterval];
}
#pragma mark - Server date Helpers -
+(void)_SDresetServerTime{
    NSHTTPURLResponse *resp;
    NSError *err;
    
    NSMutableURLRequest *req        = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:_SD_SERVER]];
    req.HTTPMethod                  = @"HEAD";
    
    [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:&err];
    NSString *httpDate              = [resp allHeaderFields][@"Date"];
    
    NSDateFormatter *df             = [[NSDateFormatter alloc] init];
    df.dateFormat                   = _SD_FORMAT;
    df.locale                       = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    
    NSDate *serverDate             = [df dateFromString: httpDate];
    _SDInterval                    = [serverDate timeIntervalSinceNow];
    
    [[NSNotificationCenter defaultCenter] removeObserver:[self class] name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:[self class] selector:@selector(_SDresetServerTime) name:UIApplicationWillEnterForegroundNotification object:nil];
    
#ifdef DEBUG
    NSLog(@"Server Clock resetted to: %@", serverDate);
#endif
}
-(int)daysBetween:(NSDate *)fromDate :(NSDate *)toDate
{
    NSTimeInterval  seconds = [toDate timeIntervalSinceDate:fromDate];
    int             days    = seconds / 60 / 60 / 24;
    return abs(days);
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"


-(NSString *)getLocaleFormatUnderscoresWithValue:(double)value
{
    NSString *localeCode = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    // Russian (ru)
    if([localeCode isEqual:@"ru"]) {
        int XY = (int)floor(value) % 100;
        int Y = (int)floor(value) % 10;
        
        if(Y == 0 || Y > 4 || (XY > 10 && XY < 15)) return @"";
        if(Y > 1 && Y < 5 && (XY < 10 || XY > 20))  return @"_";
        if(Y == 1 && XY != 11)                      return @"__";
    }
    
    // Add more languages here, which are have specific translation rules...
    
    return @"";
}

#pragma clang diagnostic pop

@end
