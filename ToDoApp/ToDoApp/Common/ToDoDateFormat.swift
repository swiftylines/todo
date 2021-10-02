//
//  ToDoDateFormat.swift
//  ToDoApp
//
//  Created by Manish on 03/10/21.
//

import Foundation

enum ToDoDateFormat {
    
    static func localFormate(from data: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "hh:mm a"
        
        if Calendar.current.isDateInToday(data) {
            return "Today at \(dateFormatter.string(from: data))"
        } else if Calendar.current.isDateInYesterday(data) {
            return "Yesterday at \(dateFormatter.string(from: data))"
        } else {
            dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
            return dateFormatter.string(from: data)
        }
        
    }
    
}
