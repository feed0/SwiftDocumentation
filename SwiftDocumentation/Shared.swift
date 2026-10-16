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

/// Shows a single given photo
@MainActor
public func show(_ photo: PhotoModel) {
    print("🖼️ Displaying photo bytes: \(photo.byteCount) bytes")
}

/// Shows a collections of given photos
@MainActor
public func show(_ photos: [PhotoModel]) {
    print("🖼️ Displaying a gallery of \(photos.count) photos.")
}

/// Pretends a network call
public func downloadPhoto(named name: String) async -> PhotoModel {
    try? await Task.sleep(for: .milliseconds(Int.random(in: 40...130)))
    return PhotoModel(name: name)
}
