//
//  String+Ext.swift
//  GHFollowers
//
//  Created by Mohamed Nasr on 22/04/2022.
//  Copyright © 2022 Sean Allen. All rights reserved.
//

import Foundation

extension String {
    func coonvertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: self)
    }
    
    
    func convertToReadableDate() -> String {
        guard let date = self.coonvertToDate() else{
            return "N/A"
        }
        return date.coonvertToStringDate()
    }
    
}
