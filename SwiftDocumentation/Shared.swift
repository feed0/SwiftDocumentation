//
//  Shared.swift
//  SwiftDocumentation
//
//  Created by feed0 on 2026/06/08.
//

import Foundation

// MARK: - Properties

/// Shared global array for the "Main Actor" and "Unstructured Concurrency" sections
@MainActor var photos = [String]()

// MARK: - Functions

// MARK: Download photo

/// Given a photo name,
/// suspends until the PhotoModel is returned.
func downloadPhoto(named name: String) async -> PhotoModel {
    try? await Task.sleep(for: .milliseconds(Int.random(in: 40...130)))
    return PhotoModel(name: name)
}

// MARK: List photos

/// Given a gallery name,
/// suspends until all photo names are returned at once.
func listPhotos(inGallery name: String) async -> [String] {
    try? await Task.sleep(for: .milliseconds(Int.random(in: 40...130)))
    switch name {
    case "Summer Vacation":
        return GalleryModel.summerVacationMock.photoNames
    default:
        return GalleryModel.emptyMock.photoNames
    }
}

// MARK: Show photo

/// Shows a single given photo
func show(_ photo: PhotoModel) {
    print("🖼️ Displaying photo '\(photo.name)' bytes: \(photo.byteCount) bytes")
}

/// Shows a collections of given photos
func show(_ photos: [PhotoModel]) {
    print("🖼️ Displaying a gallery of \(photos.count) photos.")
    for photo in photos {
        show(photo)
    }
}
