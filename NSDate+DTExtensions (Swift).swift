//
//  NSDate+DTExtensions (Swift).swift
//  DreamApp
//
//  Created by Dmitriy Tsurkan on 4/12/16.
//  Copyright © 2016 Dmitriy Tsurkan. All rights reserved.
//

import Foundation

let ISO_TIMEZONE_UTC_FORMAT = "Z"
let ISO_TIMEZONE_OFFSET_FORMAT = "%+02d%02d"

let SECS_MINUTE = 60
let SECS_HOUR = 3600
let SECS_DAY = 86400
let SECS_WEEK = 604800
let SECS_YEAR = 31556926

extension NSDate {
    
    func dtHourAndMinutes() -> String {
        let hour = dtHour()
        let minute = dtMinute()
        
        return String(format: "\(hour)%@:\(minute)%@", hour > 9 ? "" : "0", minute > 9 ? "" : "0")
    }
    
    func dtDateDayMonthNameYear() -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .LongStyle
        formatter.calendar = NSCalendar.currentCalendar()
        formatter.timeZone = NSTimeZone.localTimeZone()
        
        return formatter.stringFromDate(self)
    }
    
    func dtRealWeekday() -> Int {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let weekday = calendar?.component(.Weekday, fromDate: self)
        var realWeekday = weekday!  - 1
        
        if realWeekday == 0 {
            realWeekday = 7
        }
        
        return realWeekday
    }
    
    func dtISO8601String() -> String {
        /*
            Source: http://www.radupoenaru.com/processing-nsdate-into-an-iso8601-string/
         */
        
        var sISO8601: NSDateFormatter? = nil
        
        if sISO8601 == nil {
            sISO8601 = NSDateFormatter()
            
            let timeZone = NSTimeZone.localTimeZone()
            var offset = timeZone.secondsFromGMT
            
            let strFormat = NSMutableString(string: "yyyyMMdd'T'HH:mm:ss")
            offset = offset / 60
            
            if offset == 0 {
                strFormat.appendString(ISO_TIMEZONE_UTC_FORMAT)
            } else {
                strFormat.appendFormat(ISO_TIMEZONE_OFFSET_FORMAT, offset / 60, offset % 60)
            }
            
            sISO8601?.timeStyle = .FullStyle
            sISO8601?.dateFormat = strFormat as String
        }
        
        return (sISO8601?.stringFromDate(self))!
    }
    
    func dtDateTimeString() -> String {
        return "Date(1320476364000+0100)"
    }
    
    func dtYearDashMonthDashDay() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = NSTimeZone.localTimeZone()
        
        return formatter.stringFromDate(self)
    }
    
    //MARK: - Adding/Subtracting
    func dtDateByAddingSeconds(seconds: Int) -> NSDate {
        let dateComp = NSDateComponents()
        let calendar = NSCalendar.currentCalendar()
        
        dateComp.second = seconds
        let newDate = calendar.dateByAddingComponents(dateComp, toDate: self, options: .WrapComponents)
        
        return newDate!
    }
    
    func dtDateVySubractingSeconds(seconds: Int) -> NSDate {
        return self.dtDateByAddingSeconds(-seconds)
    }
    
    func dtDateByAddingMinutes(minutes: Int) -> NSDate {
        let dateComp = NSDateComponents()
        let calendar = NSCalendar.currentCalendar()
        
        dateComp.minute = minutes
        let newDate = calendar.dateByAddingComponents(dateComp, toDate: self, options: .WrapComponents)
        
        return newDate!
    }
    
    func dtDateBySubractingMinutes(minutes: Int) -> NSDate {
        return self.dtDateByAddingMinutes(-minutes)
    }
    
    func dtDateByAddingHours(hours: Int) -> NSDate {
        let dateComp = NSDateComponents()
        let calendar = NSCalendar.currentCalendar()
        
        dateComp.hour = hours
        let newDate = calendar.dateByAddingComponents(dateComp, toDate: self, options: .WrapComponents)
        
        return newDate!
    }
    
    func dtDateBySubractingHours(hours: Int) -> NSDate {
        return self.dtDateByAddingHours(-hours)
    }
    
    
    //MARK: - Class Methods
    
    class func dtDateWithYear(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> NSDate {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let systemTimeZone = NSTimeZone.systemTimeZone()
        
        let dateComp = NSDateComponents()
        dateComp.calendar = calendar
        dateComp.year = year
        dateComp.month = month
        dateComp.day = day
        dateComp.timeZone = systemTimeZone
        dateComp.hour = hour
        dateComp.minute = minute
        dateComp.second = second
        
        return dateComp.date!
    }
    
    class func dtDateWithYear(year: Int, month: Int, day: Int) -> NSDate {
        return NSDate.dtDateWithYear(year, month: month, day: day, hour: 0, minute: 0, second: 0)
    }
    
    //MARK: - Base
    func dtYear() -> Int {
        return NSCalendar.currentCalendar().component(.Year, fromDate: self)
    }
    
    func dtMonth() -> Int {
        return NSCalendar.currentCalendar().component(.Month, fromDate: self)
    }
    
    func dtDay() -> Int {
        return NSCalendar.currentCalendar().component(.Day, fromDate: self)
    }
    
    func dtHour() -> Int {
        return NSCalendar.currentCalendar().component(.Hour, fromDate: self)
    }
    
    func dtMinute() -> Int {
        return NSCalendar.currentCalendar().component(.Minute, fromDate: self)
    }
    
    
    //MARK: - 
    func dateStamp(date: String) -> String {
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let commCreatedDate: NSDate = formatter.dateFromString(date)!
        
        let currentDate: String = formatter.stringFromDate(NSDate())
        let curDate: NSDate = formatter.dateFromString(currentDate)!
        
        
        let calendar: NSCalendar = NSCalendar.currentCalendar()
        let flagsYear = NSCalendarUnit.Year
        let flagsDayHours = NSCalendarUnit.Hour
        let flagsDayMin = NSCalendarUnit.Minute
        let flagsDaySec = NSCalendarUnit.Second
        
        //текущее время
        let currentMin = calendar.component(.Minute, fromDate: curDate)
        let currentSec = calendar.component(.Second, fromDate: curDate)
        let currentHour = calendar.component(.Hour, fromDate: curDate)
        
        //дата от сервера
        let MinServ = calendar.component(.Minute, fromDate: commCreatedDate)
        let HourServ = calendar.component(.Hour, fromDate: commCreatedDate)
        let MonthServ = calendar.component(.Month, fromDate: commCreatedDate)
        let DayServ = calendar.component(.Day, fromDate: commCreatedDate)
        let YearServ = calendar.component(.Year, fromDate: commCreatedDate)
        
        //разница между компонентами
        let componentsYears = calendar.components(flagsYear, fromDate: commCreatedDate, toDate: curDate, options: [])
        let componentsHours = calendar.components(flagsDayHours, fromDate: commCreatedDate, toDate: curDate, options: [])
        let componentsMin = calendar.components(flagsDayMin, fromDate: commCreatedDate, toDate: curDate, options: [])
        let compontentsSec = calendar.components(flagsDaySec, fromDate: commCreatedDate, toDate: curDate, options: [])
        
        
        let YEAR_STAMP:Int = componentsYears.year
        let SEC_STAMP: Int = compontentsSec.second
        let HOURS_STAMP: Int = componentsHours.hour
        let MIN_STAMP: Int = componentsMin.minute
        
        
        let currentMilliSec: Int  = (currentHour * 3600 + currentMin * 60 + currentSec)
        
        var rightNow = ""
        let months = []
        
        if (YEAR_STAMP == 0) {
            if (SEC_STAMP < 3) {
                // Только что
                rightNow = "right now";
            } else {
                if (HOURS_STAMP < 1) {
                    // * минут * секунд назад
                    rightNow = String(MIN_STAMP) + " " + String(SEC_STAMP) + " ago";
                } else {
                    if (HOURS_STAMP < 4) {
                        // * часов * минут назад
                        rightNow = String(HOURS_STAMP) + " " + String(MIN_STAMP)+" ago";
                    } else {
                        if (SEC_STAMP > currentMilliSec) &&
                            (SEC_STAMP < currentMilliSec + 24 * 3600){
                            // Вчера
                            rightNow = "Вчера"
                        } else{
                            if (SEC_STAMP >= (currentHour * 3600 + currentMin * 60 + currentSec) + 24 * 3600) {
                                rightNow = String(DayServ) + " " + (months[MonthServ] as! String);
                            } else {
                                rightNow = "в " + String(HourServ) + ":" + String(MinServ);
                            }
                        }
                    }
                }
            }
        } else {
            rightNow = String(DayServ) + "." + String(MonthServ) + "." + String(YearServ);
        }
        
        log.info("rightNow: \(rightNow)")
        
        return rightNow
    }
    
}







