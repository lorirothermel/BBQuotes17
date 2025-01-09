//
//  StringExt.swift
//  BBQuotes17
//
//  Created by Lori Rothermel on 1/8/25.
//

import Foundation

extension String {
    func removeSpaces() -> String {
        self.replacingOccurrences(of: " ", with: "")
    }  // func removeSpaces
    
    func removeCaseAndSpace() -> String {
        self.removeSpaces().lowercased()
    }
    
}  // extension String
