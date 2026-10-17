//
//  PhotoModel.swift
//  SwiftDocumentation
//
//  Created by feed0 on 2026/06/08.
//

import Foundation

struct PhotoModel {
    
    // MARK: - Properties
    
    let name: String
    let data: Data
    
    // MARK: Computed properties
    
    var byteCount: Int {
        data.count
    }
    
    // MARK: - Init
    
    init(
        name: String,
    ) {
        self.name = name
        self.data = Data("📷 [\(name)]".utf8)
    }
}
