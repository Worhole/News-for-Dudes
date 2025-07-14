//
//  DateFormater.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-14.
//

import Foundation


struct newsDateFormatter {
    static func formatDate(_ dateStr:String?)->String{
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]
        
        guard let dateStr = dateStr, let date = isoFormatter.date(from: dateStr) else { return "" }
        
        let displayFormatter = DateFormatter()
        displayFormatter.locale = Locale.current
        displayFormatter.dateStyle = .medium
        displayFormatter.timeStyle = .short
        
        return displayFormatter.string(from: date)
    }
}
