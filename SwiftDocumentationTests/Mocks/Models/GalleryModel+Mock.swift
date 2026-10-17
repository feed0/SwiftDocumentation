//
//  GalleryModel+Mock.swift
//  SwiftDocumentationTests
//
//  Created by Felipe Campelo on 2026/10/17.
//

import Foundation

extension GalleryModel {
    
    // MARK: - Mocks
    
    static let emptyMock = GalleryModel(name: "Empty Galllery")
    
    static let summerVacationMock = GalleryModel(
        name: "Summer Vacation",
        photoNames: [
            "DSF00001.RAF",
            "DSF00002.RAF",
            "DSF00003.RAF",
        ]
    )
}
