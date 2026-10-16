//
//  PhotoModel.swift
//  SwiftDocumentation
//
//  Created by feed0 on 2026/06/08.
//

import Foundation

public struct PhotoModel {

    // MARK: - Init
    
    init(
        name: String,
    ) {
        self.name = name
        self.data = "📷 [\(name)]".data(using: .utf8)!
    }
    
    // MARK: - Properties
    
    let name: String
    let data: Data
    
    // MARK: Computed properties
    
    var byteCount: Int { data.count }
}

// MARK: - Sample data

extension PhotoModel {
    public static let sample = PhotoModel(name: "sample.jpg")
}
