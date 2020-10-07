//
//  Card.swift
//  TimeZones
//
//  Created by Maxim Macari on 07/10/2020.
//

import SwiftUI

struct Card: View {
    
    var zone: Zone
    
    var body: some View {
        
        VStack(alignment: .center, spacing: -5){
            Clock(timeZone: zone.timeZone)
            
            Text(getTimeFromZone(timeZone: zone.timeZone))
                .font(.title)
                .fontWeight(.light)
                .padding(.top, 2)
            
            let city = zone.timeZone.identifier.split(separator: "/")
            
            if city.count > 1 {
                Text("\(String(city[1]))")
                    .font(.title)
                    .fontWeight(.heavy)
                    .lineLimit(1)
                    .allowsTightening(true)
                    .minimumScaleFactor(0.5)
                    .scaledToFit()
            }
        }
        
    }
}
