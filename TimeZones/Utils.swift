//
//  Utils.swift
//  Clock_SwuiftUI
//
//  Created by Maxim Macari on 07/10/2020.
//

import Foundation

func getTime() -> String{
    
    let format = DateFormatter()
    format.dateFormat = "hh:mm:ss"
    
    return format.string(from: Date())
    
}

func getAllZonesTime() -> [Zone] {
    var allTimes: [Zone] = []
    
    //get all time zones
    let timeZoneIdentifiers = TimeZone.knownTimeZoneIdentifiers
    
    
    timeZoneIdentifiers.forEach{ identifier in
        if let timeZone = TimeZone(identifier: identifier) {
            allTimes.append(Zone(timeZone:timeZone))
        }
    }
    
//    //get all city names
//    let allcities = timeZoneIdentifiers.compactMap{ identifier in
//
//    }
//
//    allcities.forEach{ identifier in
//        if let timeZone = TimeZone(identifier: identifier) {
//            allTimes.append(Zone(timeZone:timeZone))
//        }
//    }
    
    return allTimes
}

func getTimeFromZone(timeZone: TimeZone) -> String{
    
    //get the time of each city
    let format = DateFormatter()
    format.dateFormat = "hh:mm:ss"
    
    format.timeZone = timeZone
    
    return format.string(from: Date())
    
//    let min = Int(currenTime.split(separator: ":")[0])
//    let sec = Int(currenTime.split(separator: ":")[1])
//    let hour = Int(currenTime.split(separator: ":")[2])
//
//    return Time(min: min!, sec: sec!, hour: hour!)
}
