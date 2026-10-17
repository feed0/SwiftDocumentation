//
//  GalleryModel.swift
//  SwiftDocumentation
//
//  Created by Felipe Campelo on 2026/10/17.
//

import Foundation

struct GalleryModel {
    
    // MARK: - Porperties
    
    let name: String
    var photoNames: [String]
    
    // MARK: - Init
    
    /// Initializes an empty gallery
    init(name: String) {
        self.name = name
        self.photoNames = []
    }
    
    /// Initializes a gallery with photo names
    init(
        name: String,
        photoNames: [String],
    ) {
        self.name = name
        self.photoNames = photoNames
    }
    
    // MARK: - Private methods
    
    mutating func addPhoto(named name: String) {
        photoNames.append(name)
    }
}
