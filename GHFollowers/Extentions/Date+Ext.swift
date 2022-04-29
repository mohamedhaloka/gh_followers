//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Mohamed Nasr on 22/04/2022.
//  Copyright © 2022 Sean Allen. All rights reserved.
//

import Foundation


extension Date {
    func coonvertToStringDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
