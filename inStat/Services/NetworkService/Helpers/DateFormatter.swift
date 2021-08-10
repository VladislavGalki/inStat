//
//  DateFormatter.swift
//  inStat
//
//  Created by Владислав Галкин on 10.08.2021.
//

import Foundation

func convertDateFormat(inputDate: String) -> String {
    
    let olDateFormatter = DateFormatter()
    olDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
    
    let oldDate = olDateFormatter.date(from: inputDate)
    
    let convertDateFormatter = DateFormatter()
    convertDateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
    
    return convertDateFormatter.string(from: oldDate!)
}
