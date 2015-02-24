//
//  NSDate+DTExtensions.h
//
//
//  Created by DmitriyTsurkan on 2/24/15.
//  Copyright (c) 2015 dtsurkan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DTExtensions)

- (NSString *)DTHourAndMinutes;
- (NSString *)DTPolishNotationDate;
- (NSString *)DTDateDayMonthNameYear;
- (NSString *)DTPolishInvertedNotationDate;
- (NSInteger)DTRealWeekday;

+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
                    hour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second;

+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day;

- (NSString *)DTISO8601String;
- (NSString *)DTDateTimeString;
- (NSString *)DTYearDashMonthDashDay;
- (NSDate *)DTDateByAddingSeconds:(NSInteger)seconds;
- (NSDate *)DTDateBySubtractingSeconds:(NSInteger)seconds;
- (NSDate *)DTDateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)DTDateBySubtractingMinutes:(NSInteger)minutes;
- (NSDate *)DTDateByAddingHours:(NSInteger)hours;
- (NSDate *)DTDateBySubtractingHours:(NSInteger)hours;
- (NSDate *)DTDateByAddingDays:(NSInteger)days;
- (NSDate *)DTDateBySubtractingDays:(NSInteger)days;
- (NSDate *)DTDateByAddingWeeks:(NSInteger)weeks;
- (NSDate *)DTDateBySubtractingWeeks:(NSInteger)weeks;
- (NSDate *)DTDateByAddingMonths:(NSInteger)months;
- (NSDate *)DTDateBySubtractingMonths:(NSInteger)months;
- (NSDate *)DTDateByAddingYears:(NSInteger)years;
- (NSDate *)DTDateBySubtractingYears:(NSInteger)years;


- (NSInteger)DTAgeInFullYears;
- (NSInteger)DTYear;
- (NSInteger)DTMonth;
- (NSInteger)DTDay;
- (NSInteger)DTHour;
- (NSInteger)DTMinute;

- (BOOL)isEarlierThanDate:(NSDate *)aDate;
- (BOOL)isLaterThanDate:(NSDate *)aDate;

- (NSInteger)minutesAfterDate:(NSDate *)aDate;
- (NSString *)localDescription;

/* Begining/End of the unit */


- (NSDate *)DTDateByMovingToBeginningOfDay;
- (NSDate *)DTDateByMovingToEndOfDay;
- (NSDate *)DTDateByMovingToBeginningOfTheMonth;
- (NSDate *)DTDateByMovingToEndOfTheMonth;
- (NSDate *)DTDateByMovingToBeginningOfTheYear;
- (NSDate *)DTDateByMovingToEndOfTheYear;
- (NSInteger)DTDaysBetweenDate:(NSDate *)date;



- (BOOL)isToday;
- (BOOL)isSunday;
- (BOOL)isSaturday;



- (BOOL)daysAreTheSame:(NSDate *)date;
- (BOOL)weeksAreTheSame:(NSDate *)date;
- (BOOL)monthsAreTheSame:(NSDate *)date;
- (BOOL)yearsAreTheSame:(NSDate *)date;

/* Assuming object is earlier than date */
- (NSDate *)centerBetweenDate:(NSDate *)date;

@end



@interface NSDate (DTExtensionsCachedCalednar)

- (NSDate *)DTDateByAddingSeconds:(NSInteger)seconds withCalendar:(NSCalendar *)calendar;
- (NSDate *)DTDateBySubtractingSeconds:(NSInteger)seconds withCalendar:(NSCalendar *)calendar;

- (NSDate *)DTDateByAddingMinutes:(NSInteger)minutes withCalendar:(NSCalendar *)calendar;
- (NSDate *)DTDateBySubtractingMinutes:(NSInteger)minutes withCalendar:(NSCalendar *)calendar;

- (NSDate *)DTDateByAddingHours:(NSInteger)hours withCalendar:(NSCalendar *)calendar;
- (NSDate *)DTDateBySubtractingHours:(NSInteger)hours withCalendar:(NSCalendar *)calendar;

- (NSDate *)DTDateByAddingDays:(NSInteger)days withCalendar:(NSCalendar *)calendar;
- (NSDate *)DTDateBySubtractingDays:(NSInteger)days withCalendar:(NSCalendar *)calendar;

- (NSDate *)DTDateByAddingWeeks:(NSInteger)weeks withCalendar:(NSCalendar *)calendar;
- (NSDate *)DTDateBySubtractingWeeks:(NSInteger)weeks withCalendar:(NSCalendar *)calendar;

- (NSDate *)DTDateByAddingMonths:(NSInteger)months withCalendar:(NSCalendar *)calendar;
- (NSDate *)DTDateBySubtractingMonths:(NSInteger)months withCalendar:(NSCalendar *)calendar;

- (NSDate *)DTDateByAddingYears:(NSInteger)years withCalendar:(NSCalendar *)calendar;
- (NSDate *)DTDateBySubtractingYears:(NSInteger)years withCalendar:(NSCalendar *)calendar;

- (NSDate *)DTDateByMovingToBeginningOfDayWithCalendar:(NSCalendar *)calendar;
- (NSDate *)DTDateByMovingToEndOfDayWithCalendar:(NSCalendar *)calendar;


- (NSDate *)DTDateByMovingToBeginningOfTheMonthWithCalendar:(NSCalendar *)calendar;
- (NSDate *)DTDateByMovingToEndOfTheMonthWithCalendar:(NSCalendar *)calendar;
- (NSDate *)DTDateByMovingToBeginningOfTheYearWithCalendar:(NSCalendar *)calendar;
- (NSDate *)DTDateByMovingToEndOfTheYearWithCalendar:(NSCalendar *)calendar;


- (NSInteger)DTYearWithCalendar:(NSCalendar *)calendar;
- (NSInteger)DTMonthWithCalendar:(NSCalendar *)calendar;
- (NSInteger)DTDayWithCalendar:(NSCalendar *)calendar;
- (NSInteger)DTHourWithCalendar:(NSCalendar *)calendar;
- (NSInteger)DTMinuteWithCalendar:(NSCalendar *)calendar;


- (BOOL)daysAreTheSame:(NSDate *)date withCalendar:(NSCalendar *)calendar;
- (BOOL)weeksAreTheSame:(NSDate *)date withCalendar:(NSCalendar *)calendar;
- (BOOL)monthsAreTheSame:(NSDate *)date withCalendar:(NSCalendar *)calendar;
- (BOOL)yearsAreTheSame:(NSDate *)date withCalendar:(NSCalendar *)calendar;


- (NSInteger)DTDaysBetweenDate:(NSDate *)date withCalendar:(NSCalendar *)calendar;

@end
