//
//  CharacterView.swift
//  BBQuotes17
//
//  Created by Lori Rothermel on 1/4/25.
//

import SwiftUI

struct CharacterView: View {
    
    let character: Character
    let show: String

    
    var body: some View {
        GeometryReader { geo in
            ScrollViewReader { proxy in
                ZStack(alignment: .top) {
//                  Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    Image(show.removeCaseAndSpace())
                        .resizable()
                        .scaledToFit()
                    
                    ScrollView {
                        TabView {
                            ForEach(character.images, id: \.self) { characherImageURL in
                                AsyncImage(url: characherImageURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }  // AsyncImage
                            }  // ForEach
                        }  // TabView
                        .tabViewStyle(.page)
                        .frame(width: geo.size.width / 1.2, height: geo.size.height / 1.7)
                        .clipShape(.rect(cornerRadius: 25))
                        .padding(.top, 60)
                        
                        VStack(alignment: .leading) {
                            Text(character.name)
                                .font(.largeTitle)
                            
                            Text("Portrayed By: \(character.portrayedBy)")
                                .font(.subheadline)
                            
                            Divider()
                            
                            Text("\(character.name) Character Info")
                                .font(.title2)
                            
                            Text("Born: \(character.birthday)")
                            
                            Divider()
                            
                            Text("Occupations:")
                            ForEach(character.occupations, id: \.self) { occupation in
                                Text("• \(occupation)")
                                    .font(.subheadline)
                            }  // ForEach
                            
                            Divider()
                            
                            Text("Nicknames:")
                            
                            if character.aliases.count > 0 {
                                ForEach(character.aliases, id: \.self) { alias in
                                    Text("•\(alias)")
                                        .font(.subheadline)
                                }  // ForEach
                            } else {
                                Text("None")
                                    .font(.subheadline)
                            }  // if..else
                            
                            Divider()
                            
                            DisclosureGroup("Status (Spoiler Alert!)") {
                                VStack(alignment: .leading) {
                                    Text(character.status)
                                        .font(.title2)
                                    
                                    if let death = character.death {
                                        AsyncImage(url: death.image) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(.rect(cornerRadius: 15))
                                                .onAppear {
                                                    withAnimation {
                                                        proxy.scrollTo(1, anchor: .bottom)
                                                    }  // withAnimation
                                                }  // .onAppear
                                        } placeholder: {
                                            ProgressView()
                                        }  // AsyncImage
                                        
                                        Text("How: \(death.details)")
                                            .padding(.bottom, 25)
                                        
                                        Text("Last Words: \"\(death.lastWords)\"")
                                    }  // if let
                                                                    
                                }  // VStack
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }  // DisclosureGroup
                            .tint(.primary)
                            
                        }  // VStack
                        .frame(width: geo.size.width / 1.25, alignment: .leading)
                        .padding(.bottom, 50)
                        .id(1)
                        
                    }  // ScrollView
                    .scrollIndicators(.hidden)
                                        
                }  // ZStack
                
            }  // ScrollViewReader
            
        }  // GeometryReader
        .ignoresSafeArea()
        
        
    }  // some View
    
}  // CharacterView


#Preview {
    CharacterView(character: ViewModel().character, show: Constants.bbName)
}
