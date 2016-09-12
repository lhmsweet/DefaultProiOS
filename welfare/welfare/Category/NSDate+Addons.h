//
//  NSDate+Addons.h
//  FengChao
//
//  Created by Wang Daolong on 11/29/12.
//  Copyright (c) 2012 Baidu, Inc. All rights reserved.
//

#define OUTPUT_DATE_FORMAT                          @"yyyy'-'MM'-'dd' 'HH':'mm':'ss"

#define OUTPUT_DATE_FORMAT_YYYY_MM_DD_HH_MM         @"yyyy'-'MM'-'dd' 'HH':'mm"

#define OUTPUT_DATE_FORMAT_YYYY_MM_DD               @"yyyy'-'MM'-'dd'"

#define OUTPUT_DATE_FORMAT_YYYY_MM_DD_HH_MM_SS_SSS  @"yyyy'-'MM'-'dd' 'HH':'mm':'ss.SSS"

#define INPUT_DATE_FORMAT                           OUTPUT_DATE_FORMAT

#import <Foundation/Foundation.h>

@interface NSDate (Addons)
+ (NSString *)dateStringWithTimeString; //OUTPUT_DATE_FORMAT
+ (NSString *)dateStringWithoutTimeString; //OUTPUT_DATE_FORMAT_YYYY_MM_DD
+ (NSString *)dateStringTillMinute; // #define OUTPUT_DATE_FORMAT_YYYY_MM_DD_HH_MM
+ (NSString *)dateStringWithDayInterval:(int)dayInterval; //OUTPUT_DATE_FORMAT
+ (NSString *)dateStringWithDayInterval:(int)dayInterval format:(NSString *)format;

- (NSString *)dateStringWithDateFormat:(NSString *)format;
- (NSString *)dateString; //OUTPUT_DATE_FORMAT
- (NSString *)dateStringWithDayInterval:(int)dayInterval; //OUTPUT_DATE_FORMAT
- (NSString *)dateStringWithDayInterval:(int)dayInterval format:(NSString *)format;

- (NSInteger)weekdayInGregorianCalendar;
- (NSInteger)weekdayInChineseCalendar; //星期几就是几，如星期一这里就是1
+ (NSInteger)weekdayInChineseCalendar; //星期几就是几，如星期一这里就是1

+ (NSDate *)dateFromString:(NSString *)dateString;
+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format; // OUTPUT_DATE_FORMAT
+ (NSDate *)dateFromTimeStampString:(NSString *)timeStampString;

/*!
 根据时间戳得到NSDate对象
 @param timeStampValue 时间戳值
 @return NSDate数据
 */
+ (NSDate *)dateFromMillisecond:(int64_t)timeStampValue;

- (NSInteger)dayOfYear;

/*!
 间隔dayInterval的日期
 */
+ (NSDate *)dateWithDayInterval:(int)dayInterval;

/*!
 当日0点0分0秒
 */
- (NSDate *)earliestTimeOfTheDay;

/*!
 当日23点59分59秒
 */
- (NSDate *)latestTimeOfTheDay;

/*!
 毫秒数,long long类型
 */
- (NSNumber *)timestampInMilliSeconds;

/*!
 仅获取日期字符串类型  会有今天，昨天的判断
 @retrun 日期字符串。比如2013-11-03，今天，昨天等
 */
- (NSString *)onlyDateString;

/*!
 友好的日期时间
 
 显示举例
 今天时：14:11
 昨天时：昨天 14:11
 非今天或昨天时：2013-11-14 14:11
 @retrun 日期时间字符串
 */
- (NSString *)friendlyDateTimeString;

/*!
 仅获取时间字符串类型
 @param date数据
 @retrun 时间字符串
 */
- (NSString *)onlyTimeString;

/*!
 返回性能数据的时间长度字符串，统一使用精度为.3f
 */
- (NSString *)performanceTimesString;

@end
