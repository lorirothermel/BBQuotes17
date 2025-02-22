//
//  FetchService.swift
//  BBQuotes17
//
//  Created by Lori Rothermel on 1/3/25.
//

import Foundation


struct FetchService {

    private enum FetchError: Error {
        case badResponse
    }  // enum FetchError
    
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    // URL = https://breaking-bad-api-six.vercel.app/api/quotes/random?production=Breaking+Bad
    
    
    func fetchQuote(from show: String) async throws -> Quote {
        // Build the fetch url
        let quoteURL = baseURL.appending(path: "quotes/random")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        // Fetch the data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }  // guard let
        
        // Decode data
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        // Return Quote
        return quote
        
    }  // func fetchQuote
    
    
    
    func fetchCharacter(_ name: String) async throws -> Character {
        let characterURL = baseURL.appending(path: "characters")
        let fetchURL = characterURL.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }  // guard let
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
                
        let characters = try decoder.decode([Character].self, from: data)
        
        return characters[0]
        
    }  // func fetchCharacter
    
    
    func fetchDeath(for character: String) async throws -> Death? {
        let fetchURL = baseURL.appending(path: "deaths")
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }  // guard let
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let deaths = try decoder.decode([Death].self, from: data)
        
        for death in deaths {
            if death.character == character {
                return death
            }  // if
        }  // for
        
        return nil
        
    }  // fetchDeath
    
    
    func fetchEpisode(from show: String) async throws -> Episode? {
        let episodeURL = baseURL.appending(path: "episodes")
        let fetchURL = episodeURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }  // guard let
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
                
        let episodes = try decoder.decode([Episode].self, from: data)
        
        return episodes.randomElement()
        
    }  // func fetchEpisode
    
    
    
    
}  // struct FetchService


