//
//  NSDate+Addons.m
//  FengChao
//
//  Created by Wang Daolong on 11/29/12.
//  Copyright (c) 2012 Baidu, Inc. All rights reserved.
//

#import "NSDate+Addons.h"
#import "NSDate-Utilities.h"


#define DaySeconds 24 * 3600

@interface NSDate (Private)
+ (NSString *)dateString:(NSDate *)date format:(NSString *)format;
@end


@implementation NSDate (Private)
+ (NSString *)dateString:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //    [dateFormat setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    //    [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateFormat setDateFormat:format];
    NSString *sdate = [dateFormat stringFromDate:date];
    return sdate;
}

@end

@implementation NSDate (Addons)
+ (NSString *)dateStringWithTimeString {
    return [self dateString:[NSDate date] format:OUTPUT_DATE_FORMAT];
}

+ (NSString *)dateStringWithoutTimeString {
    return [self dateString:[NSDate date] format:OUTPUT_DATE_FORMAT_YYYY_MM_DD];
}

+ (NSString *)dateStringTillMinute {
    return [self dateString:[NSDate date] format:OUTPUT_DATE_FORMAT_YYYY_MM_DD_HH_MM];
}

+ (NSString *)dateStringWithDayInterval:(int)dayInterval {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:dayInterval * DaySeconds];
    return [self dateString:date format:OUTPUT_DATE_FORMAT];
}

+ (NSString *)dateStringWithDayInterval:(int)dayInterval format:(NSString *)format {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:dayInterval * DaySeconds];
    return [self dateString:date format:format];
}

- (NSString *)dateStringWithDateFormat:(NSString *)format {
    return [NSDate dateString:self format:format];
}

- (NSString *)dateString {
    return [[self class] dateString:self format:OUTPUT_DATE_FORMAT];
}

- (NSString *)dateStringWithDayInterval:(int)dayInterval {
    NSDate *date = [self dateByAddingTimeInterval:dayInterval * DaySeconds];
    return [[self class] dateString:date format:OUTPUT_DATE_FORMAT];
}

- (NSString *)dateStringWithDayInterval:(int)dayInterval format:(NSString *)format {
    NSDate *date = [self dateByAddingTimeInterval:dayInterval * DaySeconds];
    return [[self class] dateString:date format:format];
}

- (NSInteger)weekdayInGregorianCalendar {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:self];
    return comps.weekday;
}

- (NSInteger)weekdayInChineseCalendar {
    NSInteger weekday = [self weekdayInGregorianCalendar];
    if (weekday == 1) {
        weekday = 7;
    } else {
        weekday -= 1;
    }
    return weekday;
}

+ (NSInteger)weekdayInChineseCalendar {
    return [[NSDate date] weekdayInChineseCalendar];
}

+ (NSDate *)dateFromString:(NSString *)dateString {
    return [self dateFromString:dateString format:INPUT_DATE_FORMAT];
}

+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format {
   // DebugLog(@"todo:reuse dateformat to avoid too many alloc/init calls");
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //    [dateFormat setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    //    [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateFormat setDateFormat:format];
    NSDate *date = [dateFormat dateFromString:dateString];
    return date;
}

+ (NSDate *)dateFromTimeStampString:(NSString *)timeStampString {
    return [NSDate dateWithTimeIntervalSince1970:[timeStampString doubleValue] / 1000];
}

+ (NSDate *)dateFromMillisecond:(int64_t)timeStampValue {
    return [NSDate dateWithTimeIntervalSince1970:timeStampValue / 1000];
}

- (NSInteger)dayOfYear {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger dayOfYear =
    [calendar ordinalityOfUnit:NSCalendarUnitDay
                        inUnit:NSCalendarUnitYear forDate:self];
    return dayOfYear;
}

+ (NSDate *)dateWithDayInterval:(int)dayInterval {
    return [NSDate dateWithTimeIntervalSinceNow:dayInterval * DaySeconds];
}

- (NSDate *)earliestTimeOfTheDay {
    // Use the user's current calendar and time zone
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [calendar setTimeZone:timeZone];
    
    // Selectively convert the date components (year, month, day) of the input date
    NSDateComponents *dateComps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    // Set the time components manually
    [dateComps setHour:0];
    [dateComps setMinute:0];
    [dateComps setSecond:0];
    
    // Convert back
    NSDate *date = [calendar dateFromComponents:dateComps];
    return date;
}

- (NSDate *)latestTimeOfTheDay {
    // Use the user's current calendar and time zone
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [calendar setTimeZone:timeZone];
    
    // Selectively convert the date components (year, month, day) of the input date
    NSDateComponents *dateComps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    // Set the time components manually
    [dateComps setHour:23];
    [dateComps setMinute:59];
    [dateComps setSecond:59];
    
    // Convert back
    NSDate *date = [calendar dateFromComponents:dateComps];
    return date;
}

- (NSNumber *)timestampInMilliSeconds {
    long long milliSeconds = [self timeIntervalSince1970] * 1000;
    return [NSNumber numberWithLongLong:milliSeconds];
}

- (NSString *)onlyDateString {
    if ([self isToday]) {
        return @"今天";
    } else if ([self isYesterday]) {
        return @"昨天";
    } else {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        return [dateFormat stringFromDate:self];
    }
}

- (NSString *)friendlyDateTimeString {
    NSString *dateString = nil;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    if ([self isToday]) {
        [dateFormat setDateFormat:@"HH:mm"];
        dateString = [dateFormat stringFromDate:self];
    } else if ([self isYesterday]) {
        [dateFormat setDateFormat:@"HH:mm"];
        dateString = [NSString stringWithFormat:@"昨天 %@", [dateFormat stringFromDate:self]];
    } else {
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
        dateString = [dateFormat stringFromDate:self];
    }
    
    return dateString;
}

- (NSString *)onlyTimeString {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm"];
    return [dateFormat stringFromDate:self];
}

/*!
 返回性能数据的时间长度字符串，统一使用精度为.3f
 */
- (NSString *)performanceTimesString {
    return [NSString stringWithFormat:@"%.3f", [[NSDate date] timeIntervalSinceDate:self]];
}

@end
