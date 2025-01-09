//
//  FetchView.swift
//  BBQuotes17
//
//  Created by Lori Rothermel on 1/4/25.
//

import SwiftUI

struct FetchView: View {
    @State private var showCharacerInfo = false
    
    
    let vm = ViewModel()
    let show: String
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
//              Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                Image(show.removeCaseAndSpace())
                    .resizable()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                VStack {
                    VStack {
                        Spacer(minLength: 60)
                        
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                        case .fetching:
                            ProgressView()
                        case .success:
                            Text("\"\(vm.quote.quote)\"")
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 25))
                                .padding(.horizontal)
                            
                            ZStack(alignment: .bottom) {
                                AsyncImage(url: vm.character.images[0]) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }  // AsyncImage
                                .frame(width: geo.size.width / 1.1, height: geo.size.height / 1.8)
                                
                                Text(vm.quote.character)
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                                
                            }  // ZStack
                            .frame(width: geo.size.width / 1.1, height: geo.size.height / 1.8)
                            .clipShape(.rect(cornerRadius: 50))
                            .onTapGesture {
                                showCharacerInfo.toggle()
                            }  // .onTapGesture
                            .sheet(isPresented: $showCharacerInfo) {
                                CharacterView(character: vm.character, show: show)
                            }  // .sheet
                            
                        case .failed(let error):
                            Text(error.localizedDescription)
                        }  // switch
                        
                        Spacer()
                        
                    }  // VStack
                    
                    Button {
                        Task {
                            await vm.getQuoteData(for: show)
                        }  // Task
                    } label: {
                        Text("Get Random Quote")
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding()
//                          .background(Color("\(show.replacingOccurrences(of: " ", with: ""))Button"))
                            .background(Color("\(show.removeSpaces())Button"))
                            .clipShape(.rect(cornerRadius: 7))
                            .shadow(color: Color("\(show.removeSpaces())Shadow"), radius: 2)
                        
                    }  // Button
                    
                    Spacer(minLength: 95)
                    
                }  // VStack
                .frame(width: geo.size.width, height: geo.size.height)
            }  // ZStack
            .frame(width: geo.size.width, height: geo.size.height)
            
            
        }  // GeometryReader
        .ignoresSafeArea()
    }  // some View
}  // QuoteView

#Preview {
    FetchView(show: Constants.bbName)
        .preferredColorScheme(.dark)
}
