//
//  ContentView.swift
//  TimeZones
//
//  Created by Maxim Macari on 07/10/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @State var zones: [Zone]
    @State var searchCity = ""
    @State var isSearching = false
    
    var body: some View {
        
        
        VStack{
            HStack{
                
                VStack{
                    Text("World time")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    HStack{
                        HStack{
                            
                            
                            Image(systemName: "magnifyingglass")
                            
                            TextField("Search city", text: $searchCity)
                            
                            if isSearching {
                                Button(action: {
                                    searchCity = ""
                                }, label: {
                                    Image(systemName: "xmark.circle")
                                    
                                })
                            }
                            
                            
                            
                        }
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .onTapGesture(count: 1, perform: {
                            isSearching.toggle()
                        })
                        .transition(.move(edge: .trailing))
                        .animation(.spring())
                        
                        if isSearching{
                            Button(action: {
                                searchCity = ""
                                isSearching.toggle()
                                UIApplication.shared.dismisKeyboard()
                            }, label: {
                                Text("Cancel")
                                    .padding(.trailing)
                                    .padding(.leading, 0)
                                
                            })
                            .padding()
                        }
                    }
                }
            }
            
            ScrollView(.vertical, showsIndicators: true) {
                
                LazyVGrid(columns: columns){
                    
                    ForEach(zones.filter({"\($0)".lowercased().contains(searchCity.lowercased()) || searchCity.isEmpty})){ zone in
                        Card(zone: zone)
                    }
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(zones: getAllZonesTime())
    }
}

extension UIApplication{
    func dismisKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
