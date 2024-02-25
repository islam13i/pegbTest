//
//  Date+EXT.swift
//  NewsApp
//
//  Created by Islam Baigaziev on 25/2/24.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "en_US")
        let formattedDate = dateFormatter.string(from: self)
        
        return formattedDate
    }
    func convertToDayMonthYearFormat() -> String  {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM, yyyy"
        let formattedDate = dateFormatterPrint.string(from: self)
        
        return formattedDate
    }
}

extension String {
    
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone  = .current
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
    func convertToDisplayCellFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToDayMonthYearFormat()
    }
}

