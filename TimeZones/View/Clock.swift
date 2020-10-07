//
//  Clock.swift
//  TimeZones
//
//  Created by Maxim Macari on 07/10/2020.
//

import SwiftUI

struct Clock: View {
    
    var timeZone: TimeZone
    var width = UIScreen.main.bounds.width * 0.58
    @State var currentTime = Time(min: 0, sec: 0, hour: 0)
    @State var receiver = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    
    var body: some View {
        
        VStack{
            ZStack{
                
                Circle()
                    .fill(Color.black.opacity(0.1))
                
                //Seconds and min dots
                ForEach(0..<60, id: \.self){ i in
                   
                    Circle()
                        // 60 / 12 = 5
                        .frame(maxWidth: i % 5 == 0 ? 5 : 2)
                        .foregroundColor(Color.primary)
                        .offset(y: (width - 110) / 2)
                        .rotationEffect(.degrees(Double(i * (360/60))))
                    
                    
                }
                
                ForEach(0..<12, id: \.self){ i in
                    Text(toRoman(number: (i == 0 ? 12 : i)))
                        .font(.custom("numeros",size: 8))
                        .foregroundColor(.black)
                        .offset(y: (width - 95) / 2)
                        .rotationEffect(.degrees(Double(i * (360/12))))
                }
                .rotationEffect(Angle(degrees: 180))
                
                
                //Sec...
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 2, height: (width - 0.4 * width) / 2)
                    .offset(y: -(width - 170) / 4)
                    .rotationEffect(.init(degrees: Double(currentTime.sec) * 6))
                
                //Min
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 4, height: (width - 0.48 * width) / 2)
                    .offset(y: -(width - 180) / 4)
                    .rotationEffect(.init(degrees: Double(currentTime.min) * 6))
                
                //Hour
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 4.5, height: (width - 0.6 * width) / 2)
                    .offset(y: -(width - 190) / 4)
                    .rotationEffect(.init(degrees: Double(currentTime.hour + (currentTime.min / 60)) * 30))
                
                //Center Circle
                
                Circle()
                    .fill(Color.primary)
                    .frame(width: 15, height: 15)
                
            }.frame(width: width - 80, height: width - 80)
        }
        .onAppear(perform: {
            let temp = getTimeFromZone(timeZone: timeZone).split(separator: ":")
            
            let min: Int = Int(temp[1])!
            let sec: Int = Int(temp[2])!
            let hour: Int = Int(temp[0])!
            
            withAnimation(Animation.linear(duration: 0.01)){
                self.currentTime = Time(min: min, sec: sec, hour: hour)
            }
            
        })
        .onReceive(receiver){ _ in
            
            let temp = getTimeFromZone(timeZone: timeZone).split(separator: ":")
            
            let min: Int = Int(temp[1])!
            let sec: Int = Int(temp[2])!
            let hour: Int = Int(temp[0])!
            
            withAnimation(Animation.linear(duration: 0.01)){
                self.currentTime = Time(min: min, sec: sec, hour: hour)
            }
        }
    }
}

private func toRoman(number: Int) -> String {
    let conversionTable: [(intNumber: Int, romanNumber: String)] =
        [(1000, "M"),
         (900, "CM"),
         (500, "D"),
         (400, "CD"),
         (100, "C"),
         (90, "XC"),
         (50, "L"),
         (40, "XL"),
         (10, "X"),
         (9, "IX"),
         (5, "V"),
         (4, "IV"),
         (1, "I")]
    var roman = ""
    var remainder = 0
    
    for entry in conversionTable {
        let quotient = (number - remainder) / entry.intNumber
        remainder += quotient * entry.intNumber
        roman += String(repeating: entry.romanNumber, count: quotient)
    }
    
    return roman
}




