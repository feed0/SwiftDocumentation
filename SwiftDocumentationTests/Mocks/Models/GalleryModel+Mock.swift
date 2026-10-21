//
//  GalleryModel+Mock.swift
//  SwiftDocumentationTests
//
//  Created by Felipe Campelo on 2026/10/17.
//

import Foundation

// MARK: - Mocks

extension GalleryModel {
    
    static let emptyMock = GalleryModel(name: "Empty Galllery")
    
    static let summerVacationMock = GalleryModel(
        name: "Summer Vacation",
        photoNames: [
            "DSF00001.RAF",
            "DSF00002.RAF",
            "DSF00003.RAF",
            "DSF00004.RAF",
            "DSF00005.RAF",
            "DSF00006.RAF",
            "DSF00007.RAF",
            "DSF00008.RAF",
            "DSF00009.RAF",
            "DSF00010.RAF",
        ]
    )
}

// MARK: - Galleries enum

extension GalleryModel {
    enum Galleries: String {
        case summerVacation = "Summer Vacation"
    }
}
