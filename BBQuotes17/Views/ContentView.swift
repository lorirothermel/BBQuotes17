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
            Text("Breaking Bad View")
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label("Breaking Bad", systemImage: "tortoise")
                }  // .tabItem
            Text("Better Call Saul View")
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label("Better Call Saul", systemImage: "briefcase")
                }  // .tabItem
        }  // TabView
        .preferredColorScheme(.dark)

        
    }  // some View
    
}  // ContentView

#Preview {
    ContentView()
}
