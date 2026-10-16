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

// MARK: Show photo

/// Shows a single given photo
public func show(_ photo: PhotoModel) {
    print("🖼️ Displaying photo \(photo.name) bytes: \(photo.byteCount) bytes")
}

/// Shows a collections of given photos
public func show(_ photos: [PhotoModel]) {
    print("🖼️ Displaying a gallery of \(photos.count) photos.")
}

// MARK: Download photo

/// Pretends a network call
public func downloadPhoto(named name: String) async -> PhotoModel {
    try? await Task.sleep(for: .milliseconds(Int.random(in: 40...130)))
    return PhotoModel(name: name)
}
