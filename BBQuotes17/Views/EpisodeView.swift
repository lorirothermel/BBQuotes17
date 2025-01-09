//
//  EpisodeView.swift
//  BBQuotes17
//
//  Created by Lori Rothermel on 1/8/25.
//

import SwiftUI

struct EpisodeView: View {
    
    let episode: Episode
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(episode.title)
                .font(.largeTitle)
            Text(episode.seasonEpisode)
                .font(.title2)
            
            AsyncImage(url: episode.image) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 15))
            } placeholder: {
                ProgressView()
            }  // AsyncImage
            
            Text(episode.synopsis)
                .font(.title3)
                .minimumScaleFactor(0.5)
                .padding(.bottom)
            Text("Written By: \(episode.writtenBy)")
                
            Text("Directed By: \(episode.directedBy)")
            Text("Aired: \(episode.airDate)")
            
        }  // VStack
        .padding()
        .foregroundStyle(.white)
        .background(.black.opacity(0.6))
        .clipShape(.rect(cornerRadius: 25))
        .padding(.horizontal)
        
        
    }  // some View
    
}  // EpisodeView

#Preview {
    EpisodeView(episode: ViewModel().episode)
}
