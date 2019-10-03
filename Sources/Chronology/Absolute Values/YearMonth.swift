//
//  YearMonth.swift
//  Chronology
//
//  Created by Dave DeLong on 2/19/18.
//

import Foundation

public struct YearMonth: Absolute, YearMonthFields {
    public static var representedComponents: Set<Calendar.Component> = [.era, .year, .month]
    
    public let region: Region
    public let dateComponents: DateComponents
    
    public init(region: Region, dateComponents: DateComponents) {
        self.region = region
        self.dateComponents = dateComponents.requireAndRestrict(to: type(of: self).representedComponents)
    }
    
    public func firstDay() -> YearMonthDay {
        return YearMonthDay(instant: range.lowerBound, region: region)
    }
    
    public func lastDay() -> YearMonthDay {
        return YearMonthDay(instant: range.upperBound, region: region)
    }
    
    public func nthDay(_ ordinal: Int) throws -> YearMonthDay {
        guard ordinal >= 1 else { throw AdjustmentError() }
        let offsetDay = firstDay() + .days(ordinal - 1)
        
        let monthRange = self.range
        let dayRange = offsetDay.range
        
        guard monthRange.lowerBound <= dayRange.lowerBound else { throw AdjustmentError() }
        guard dayRange.upperBound <= monthRange.upperBound else { throw AdjustmentError() }
        return offsetDay
    }
    
    public func days() -> ValueSequence<YearMonthDay> {
        return ValueSequence(parent: self)
    }
    
    public func hours() -> ValueSequence<YearMonthDayHour> {
        return ValueSequence(parent: self)
    }
    
    public func minutes() -> ValueSequence<YearMonthDayHourMinute> {
        return ValueSequence(parent: self)
    }
    
    public func seconds() -> ValueSequence<YearMonthDayHourMinuteSecond> {
        return ValueSequence(parent: self)
    }
    
}
