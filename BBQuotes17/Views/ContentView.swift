//
//  ContentView.swift
//  BBQuotes17
//
//  Created by Lori Rothermel on 1/2/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FetchView(show: Constants.bbName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Constants.bbName, systemImage: "tortoise")
                }  // .tabItem
            
            FetchView(show: Constants.bcsName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Constants.bcsName, systemImage: "briefcase")
                }  // .tabItem
            
            FetchView(show: Constants.ecName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Constants.ecName, systemImage: "car")
                }  // .tabItem
            
        }  // TabView
        .preferredColorScheme(.dark)
        
    }  // some View
}  // ContentView

#Preview {
    ContentView()
}
