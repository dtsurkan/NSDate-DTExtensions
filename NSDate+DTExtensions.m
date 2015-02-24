//
//  NSDate+DTExtensions.m
//
//
//  Created by DmitriyTsurkan on 2/24/15.
//  Copyright (c) 2015 dtsurkan. All rights reserved.
//

#import "NSDate+DTExtensions.h"

#define ISO_TIMEZONE_UTC_FORMAT @"Z"
#define ISO_TIMEZONE_OFFSET_FORMAT @"%+02d%02d"


#define SECS_MINUTE	60
#define SECS_HOUR	3600
#define SECS_DAY	86400
#define SECS_WEEK	604800
#define SECS_YEAR	31556926

@implementation NSDate (DTExtensions)

- (NSString *)DTHourAndMinutes{
    
    NSInteger hour = [self DTHour];
    NSInteger minute = [self DTMinute];
    
    return [NSString stringWithFormat:@"%@%d:%@%d",
            hour > 9 ? @"" : @"0",
            hour,
            minute > 9 ? @"" : @"0",
            minute
            ];
}

- (NSString *)DTDateDayMonthNameYear{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:kCFDateFormatterLongStyle];
    //    [df setDateFormat:@"dd MM yyyy"];
    [df setCalendar:[NSCalendar currentCalendar]];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    
    return [df stringFromDate:self];
}

- (NSString *)DTPolishNotationDate{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy.MM.dd"];
    [df setCalendar:[NSCalendar currentCalendar]];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    
    return [df stringFromDate:self];
}

- (NSString *)DTPolishInvertedNotationDate{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd.MM.yyyy"];
    [df setCalendar:[NSCalendar currentCalendar]];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    
    return [df stringFromDate:self];
}

- (NSInteger)DTRealWeekday{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:self];
    
    NSInteger weekday = [weekdayComponents weekday];
    
    NSInteger realWeekday = weekday - 1;
    
    if (realWeekday==0) {
        realWeekday = 7;
    }
    
    return realWeekday;
}


+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
                    hour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *systemTimeZone = [NSTimeZone systemTimeZone];
    
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setCalendar:gregorian];
    [dateComps setYear:year];
    [dateComps setMonth:month];
    [dateComps setDay:day];
    [dateComps setTimeZone:systemTimeZone];
    [dateComps setHour:hour];
    [dateComps setMinute:minute];
    [dateComps setSecond:second];
    
    
    return [dateComps date];
}

+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day{
    return [NSDate dateWithYear:year month:month day:day hour:0 minute:0 second:0];
}

- (NSString *)DTISO8601String{
    /*
     Source: http://www.radupoenaru.com/processing-nsdate-into-an-iso8601-string/
     */
    static NSDateFormatter* sISO8601 = nil;
    
    if (!sISO8601) {
        sISO8601 = [[NSDateFormatter alloc] init];
        
        NSTimeZone *timeZone = [NSTimeZone localTimeZone];
        int offset = [timeZone secondsFromGMT];
        
        NSMutableString *strFormat = [NSMutableString stringWithString:@"yyyyMMdd'T'HH:mm:ss"];
        offset /= 60; //bring down to minutes
        if (offset == 0)
            [strFormat appendString:ISO_TIMEZONE_UTC_FORMAT];
        else
            [strFormat appendFormat:ISO_TIMEZONE_OFFSET_FORMAT, offset / 60, offset % 60];
        
        [sISO8601 setTimeStyle:NSDateFormatterFullStyle];
        [sISO8601 setDateFormat:strFormat];
    }
    return[sISO8601 stringFromDate:self];
}

- (NSString *)DTDateTimeString{
    
    return @"Date(1320476364000+0100)";
}

- (NSString*)DTYearDashMonthDashDay{
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    
    return [df stringFromDate:self];
}

#pragma mark - Adding/Subtracting

- (NSDate *)DTDateByAddingSeconds:(NSInteger)seconds{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [comps setSecond:seconds];
    
    NSDate *newDate = [calendar dateByAddingComponents:comps toDate:self options:0];
    
    return newDate;
}

- (NSDate *)DTDateBySubtractingSeconds:(NSInteger)seconds{
    return [self DTDateByAddingSeconds:-seconds];
}

- (NSDate *)DTDateByAddingMinutes:(NSInteger)minutes{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [comps setMinute:minutes];
    
    NSDate *newDate = [calendar dateByAddingComponents:comps toDate:self options:0];
    
    return newDate;
}

- (NSDate *)DTDateBySubtractingMinutes:(NSInteger)minutes{
    return [self DTDateByAddingMinutes:-minutes];
}

- (NSDate *)DTDateByAddingHours:(NSInteger)hours{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [comps setHour:hours];
    
    NSDate *newDate = [calendar dateByAddingComponents:comps toDate:self options:0];
    
    return newDate;
}

- (NSDate *)DTDateBySubtractingHours:(NSInteger)hours{
    return [self DTDateByAddingHours:-hours];
}

- (NSDate *)DTDateByAddingDays:(NSInteger)days{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [comps setDay:days];
    
    NSDate *newDate = [calendar dateByAddingComponents:comps toDate:self options:0];
    
    return newDate;
}

- (NSDate *)DTDateBySubtractingDays:(NSInteger)days{
    return [self DTDateByAddingDays:-days];
}

- (NSDate *)DTDateByAddingWeeks:(NSInteger)weeks{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [comps setWeek:weeks];
    
    NSDate *newDate = [calendar dateByAddingComponents:comps toDate:self options:0];
    
    return newDate;
}

- (NSDate *)DTDateBySubtractingWeeks:(NSInteger)weeks{
    return [self DTDateByAddingWeeks:-weeks];
}

- (NSDate *)DTDateByAddingMonths:(NSInteger)months{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [comps setMonth:months];
    
    NSDate *newDate = [calendar dateByAddingComponents:comps toDate:self options:0];
    
    return newDate;
}

- (NSDate *)DTDateBySubtractingMonths:(NSInteger)months{
    return [self DTDateByAddingMonths:-months];
}

- (NSDate *)DTDateByAddingYears:(NSInteger)years{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [comps setYear:years];
    
    NSDate *newDate = [calendar dateByAddingComponents:comps toDate:self options:0];
    
    return newDate;
}

- (NSDate *)DTDateBySubtractingYears:(NSInteger)years{
    return [self DTDateByAddingYears:-years];
}


- (NSInteger)DTAgeInFullYears{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:self toDate:[NSDate date] options:0];
    
    NSInteger yearsSinceBirth = [comps year];
    
    
    return yearsSinceBirth;
}


- (NSInteger)DTYear{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self];
    return [dateComponents year];
}

- (NSInteger)DTMonth{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit fromDate:self];
    return [dateComponents month];
}

- (NSInteger)DTDay{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:self];
    return [dateComponents day];
}

- (NSInteger)DTHour{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSHourCalendarUnit fromDate:self];
    return [dateComponents hour];
}

- (NSInteger)DTMinute{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSMinuteCalendarUnit fromDate:self];
    return [dateComponents minute];
}

- (BOOL) isEarlierThanDate: (NSDate *) aDate{
    return ([self earlierDate:aDate] == self);
}

- (BOOL) isLaterThanDate: (NSDate *) aDate{
    return ([self laterDate:aDate] == self);
}

- (NSInteger) minutesAfterDate: (NSDate *) aDate{
    NSTimeInterval interval = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (interval / SECS_MINUTE);
}

- (NSString *)localDescription{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy, H:mm ,EEEE, LLLL"];
    [dateFormatter setCalendar:[NSCalendar currentCalendar]];
    return [dateFormatter stringFromDate:self];
}



- (NSDate *)DTDateByMovingToBeginningOfDay{
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    [parts setHour:0];
    [parts setMinute:0];
    [parts setSecond:0];
    
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}

- (NSDate *)DTDateByMovingToEndOfDay{
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    [parts setHour:23];
    [parts setMinute:59];
    [parts setSecond:59];
    
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}


- (NSDate *)DTDateByMovingToBeginningOfTheMonth{
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    
    [parts setDay:1];
    [parts setHour:0];
    [parts setMinute:0];
    [parts setSecond:0];
    
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}

- (NSDate *)DTDateByMovingToEndOfTheMonth{
    
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    
    [parts setMonth:[parts month]+1];
    [parts setDay:0];
    [parts setHour:23];
    [parts setMinute:59];
    [parts setSecond:59];
    
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}


- (NSDate *)DTDateByMovingToBeginningOfTheYear{
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    
    [parts setDay:1];
    [parts setHour:0];
    [parts setMinute:0];
    [parts setSecond:0];
    [parts setMonth:1];
    
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}

- (NSDate *)DTDateByMovingToEndOfTheYear{
    
    NSDate *firstDayNextYear = [[self DTDateByMovingToBeginningOfTheYear] DTDateByAddingYears:1];
    NSDate *lastDayThisYear = [firstDayNextYear DTDateBySubtractingDays:1];
    return [lastDayThisYear DTDateByMovingToEndOfDay];
}



- (NSInteger)DTDaysBetweenDate:(NSDate *)date{
    return [self timeIntervalSinceDate:date] / (60 * 60 * 24);
}



- (BOOL)isToday{
    NSDate *today = [NSDate date];
    return [self daysAreTheSame:today];
    
}

- (BOOL)isSunday{
    return self.DTRealWeekday == 7;
}

- (BOOL)isSaturday{
    return self.DTRealWeekday == 6;
}



- (BOOL)daysAreTheSame:(NSDate *)date{
    
    NSDateComponents *selfDateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
    
    return (dateComponents.year == selfDateComponents.year) && (dateComponents.month == selfDateComponents.month) && (dateComponents.day == selfDateComponents.day);
}

- (BOOL)weeksAreTheSame:(NSDate *)date{
    NSDateComponents *selfDateComponents = [[NSCalendar currentCalendar] components:NSWeekCalendarUnit fromDate:self];
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSWeekCalendarUnit fromDate:date];
    
    return (dateComponents.week == selfDateComponents.week);
}

- (BOOL)monthsAreTheSame:(NSDate *)date{
    NSDateComponents *selfDateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:date];
    
    return (dateComponents.year == selfDateComponents.year) && (dateComponents.month == selfDateComponents.month);
}

- (BOOL)yearsAreTheSame:(NSDate *)date{
    
    NSDateComponents *selfDateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:date];
    
    return (dateComponents.year == selfDateComponents.year);
}


- (NSDate *)centerBetweenDate:(NSDate *)date{
    return [self dateByAddingTimeInterval:[date timeIntervalSinceDate:self]/ 2];
}

@end


@implementation NSDate (DTExtensionsCachedCalednar)

- (NSDate *)DTDateByAddingUnit:(NSInteger)unit unitType:(NSCalendarUnit)unitType withCalendar:(NSCalendar *)calendar{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    switch (unitType) {
        case NSSecondCalendarUnit:
            [comps setSecond:unit];
            break;
        case NSMinuteCalendarUnit:
            [comps setMinute:unit];
            break;
        case NSHourCalendarUnit:
            [comps setHour:unit];
            break;
        case NSDayCalendarUnit:
            [comps setDay:unit];
            break;
        case NSMonthCalendarUnit:
            [comps setMonth:unit];
            break;
        case NSYearCalendarUnit:
            [comps setYear:unit];
            break;
        default:
            return nil;
            break;
    }
    
    return [calendar dateByAddingComponents:comps toDate:self options:0];
}


- (NSDate *)DTDateByAddingSeconds:(NSInteger)seconds withCalendar:(NSCalendar *)calendar{
    return [self DTDateByAddingUnit:seconds unitType:NSSecondCalendarUnit withCalendar:calendar];
}

- (NSDate *)DTDateBySubtractingSeconds:(NSInteger)seconds withCalendar:(NSCalendar *)calendar{
    return [self DTDateByAddingSeconds:-seconds withCalendar:calendar];
}


- (NSDate *)DTDateByAddingMinutes:(NSInteger)minutes withCalendar:(NSCalendar *)calendar{
    return [self DTDateByAddingUnit:minutes unitType:NSMinuteCalendarUnit withCalendar:calendar];
}

- (NSDate *)DTDateBySubtractingMinutes:(NSInteger)minutes withCalendar:(NSCalendar *)calendar{
    return [self DTDateByAddingMinutes:-minutes withCalendar:calendar];
}


- (NSDate *)DTDateByAddingHours:(NSInteger)hours withCalendar:(NSCalendar *)calendar{
    return [self DTDateByAddingUnit:hours unitType:NSHourCalendarUnit withCalendar:calendar];
}

- (NSDate *)DTDateBySubtractingHours:(NSInteger)hours withCalendar:(NSCalendar *)calendar{
    return [self DTDateByAddingHours:-hours withCalendar:calendar];
}


- (NSDate *)DTDateByAddingDays:(NSInteger)days withCalendar:(NSCalendar *)calendar{
    return [self DTDateByAddingUnit:days unitType:NSDayCalendarUnit withCalendar:calendar];
}

- (NSDate *)DTDateBySubtractingDays:(NSInteger)days withCalendar:(NSCalendar *)calendar{
    return [self DTDateByAddingDays:-days withCalendar:calendar];
}


- (NSDate *)DTDateByAddingWeeks:(NSInteger)weeks withCalendar:(NSCalendar *)calendar{
    return [self DTDateByAddingUnit:7 * weeks unitType:NSDayCalendarUnit withCalendar:calendar];
}

- (NSDate *)DTDateBySubtractingWeeks:(NSInteger)weeks withCalendar:(NSCalendar *)calendar{
    return [self DTDateByAddingWeeks:-weeks withCalendar:calendar];
}


- (NSDate *)DTDateByAddingMonths:(NSInteger)months withCalendar:(NSCalendar *)calendar{
    return [self DTDateByAddingUnit:months unitType:NSMonthCalendarUnit withCalendar:calendar];
}

- (NSDate *)DTDateBySubtractingMonths:(NSInteger)months withCalendar:(NSCalendar *)calendar{
    return [self DTDateByAddingMonths:-months withCalendar:calendar];
}


- (NSDate *)DTDateByAddingYears:(NSInteger)years withCalendar:(NSCalendar *)calendar{
    return [self DTDateByAddingUnit:years unitType:NSYearCalendarUnit withCalendar:calendar];
}

- (NSDate *)DTDateBySubtractingYears:(NSInteger)years withCalendar:(NSCalendar *)calendar{
    return [self DTDateByAddingYears:-years withCalendar:calendar];
}

- (NSDate *)DTDateByMovingToBeginningOfDayWithCalendar:(NSCalendar *)calendar{
    NSDateComponents* parts = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    [parts setHour:0];
    [parts setMinute:0];
    [parts setSecond:0];
    
    return [calendar dateFromComponents:parts];
}

- (NSDate *)DTDateByMovingToEndOfDayWithCalendar:(NSCalendar *)calendar{
    NSDateComponents* parts = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    [parts setHour:23];
    [parts setMinute:59];
    [parts setSecond:59];
    
    return [calendar dateFromComponents:parts];
}


- (NSDate *)DTDateByMovingToBeginningOfTheMonthWithCalendar:(NSCalendar *)calendar{
    NSDateComponents* parts = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    
    [parts setDay:1];
    [parts setHour:0];
    [parts setMinute:0];
    [parts setSecond:0];
    
    return [calendar dateFromComponents:parts];
}

- (NSDate *)DTDateByMovingToEndOfTheMonthWithCalendar:(NSCalendar *)calendar{
    NSDateComponents* parts = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    
    [parts setMonth:[parts month]+1];
    [parts setDay:0];
    [parts setHour:23];
    [parts setMinute:59];
    [parts setSecond:59];
    
    return [calendar dateFromComponents:parts];
}


- (NSDate *)DTDateByMovingToBeginningOfTheYearWithCalendar:(NSCalendar *)calendar{
    NSDateComponents* parts = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    
    [parts setDay:1];
    [parts setHour:0];
    [parts setMinute:0];
    [parts setSecond:0];
    [parts setMonth:1];
    
    return [calendar dateFromComponents:parts];
}

- (NSDate *)DTDateByMovingToEndOfTheYearWithCalendar:(NSCalendar *)calendar{
    NSDate *firstDayNextYear = [[self DTDateByMovingToBeginningOfTheYear] DTDateByAddingYears:1];
    NSDate *lastDayThisYear = [firstDayNextYear DTDateBySubtractingDays:1];
    return [lastDayThisYear DTDateByMovingToEndOfDay];
}


- (NSInteger)DTYearWithCalendar:(NSCalendar *)calendar{
    NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit fromDate:self];
    return [dateComponents year];
}

- (NSInteger)DTMonthWithCalendar:(NSCalendar *)calendar{
    NSDateComponents *dateComponents = [calendar components:NSMonthCalendarUnit fromDate:self];
    return [dateComponents month];
}

- (NSInteger)DTDayWithCalendar:(NSCalendar *)calendar{
    NSDateComponents *dateComponents = [calendar components:NSDayCalendarUnit fromDate:self];
    return [dateComponents day];
}

- (NSInteger)DTHourWithCalendar:(NSCalendar *)calendar{
    NSDateComponents *dateComponents = [calendar components:NSHourCalendarUnit fromDate:self];
    return [dateComponents hour];
}

- (NSInteger)DTMinuteWithCalendar:(NSCalendar *)calendar{
    NSDateComponents *dateComponents = [calendar components:NSMinuteCalendarUnit fromDate:self];
    return [dateComponents minute];
}


- (BOOL)daysAreTheSame:(NSDate *)date withCalendar:(NSCalendar *)calendar{
    
    NSDateComponents *selfDateComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
    NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
    
    return (dateComponents.year == selfDateComponents.year) && (dateComponents.month == selfDateComponents.month) && (dateComponents.day == selfDateComponents.day);
}

- (BOOL)weeksAreTheSame:(NSDate *)date withCalendar:(NSCalendar *)calendar{
    NSDateComponents *selfDateComponents = [calendar components:NSWeekCalendarUnit fromDate:self];
    NSDateComponents *dateComponents = [calendar components:NSWeekCalendarUnit fromDate:date];
    
    return (dateComponents.week == selfDateComponents.week);
}

- (BOOL)monthsAreTheSame:(NSDate *)date withCalendar:(NSCalendar *)calendar{
    NSDateComponents *selfDateComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
    NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:date];
    
    return (dateComponents.year == selfDateComponents.year) && (dateComponents.month == selfDateComponents.month);
}

- (BOOL)yearsAreTheSame:(NSDate *)date withCalendar:(NSCalendar *)calendar{
    
    NSDateComponents *selfDateComponents = [calendar components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit fromDate:date];
    
    return (dateComponents.year == selfDateComponents.year);
}



- (NSInteger)DTDaysBetweenDate:(NSDate *)date withCalendar:(NSCalendar *)calendar{
    NSDateComponents *dateComponents = [calendar components:NSDayCalendarUnit
                                                   fromDate:date
                                                     toDate:self
                                                    options:0];
    return [dateComponents day];
}

@end
