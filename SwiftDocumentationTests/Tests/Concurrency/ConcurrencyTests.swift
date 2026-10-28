//
//  ConcurrencyTests.swift
//  SwiftDocumentationTests
//
//  Created by feed0 on 2026/06/08.
//

import Testing
import Foundation

@Suite(.serialized)
private struct ConcurrencyTests {
    
    // MARK: - Defining and Calling Asynchronous Functions
    // https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Defining-and-Calling-Asynchronous-Functions
    
    /// Synchronous functions/methods either i. return, or ii. throw, or iii. never return.
    /// While asynchronous ones do one of the three, but also can suspend in the middle of instructions.
    /// Asynchronous code can only be called from other async code. Even this test function!
    @Test("Async download photo")
    func downloadPhoto_AsyncFunc() async {
        // Arrange
        print("\t▶️ Start: Preparing to download photo.")
        let photoName = PhotoModel.photoMock.name
        
        // Act
        print("\t🔄 Suspension: waiting for response...")
        let photo = await downloadPhoto(named: photoName)
        
        // Assert
        #expect(!photo.data.isEmpty)
        print("\t📦 Downloaded \(photo.byteCount) bytes for \(photoName).")
        print("\t⏹️ End: Photo processing complete.")
    }
    
    /// Asynchronously returns the whole array at once, after all of the array’s elements are ready.
    @Test("Async list photos")
    func listPhotos_AsyncFunc() async {
        // Arrange
        print("\t▶️ Start: Preparing to fetch photo names.")
        let galleryName = GalleryModel.Galleries.summerVacation.rawValue
        
        // Act
        print("\t🔄 Suspension: waiting for response...")
        let photoNames = await listPhotos(inGallery: galleryName)
        
        // Assert
        #expect(!photoNames.isEmpty)
        print("\t📦 Fetched all \(photoNames.count) photo(s) name(s) at once:")
        for photoName in photoNames {
            show(PhotoModel(name: photoName))
        }
        print("\t⏹️ End: Gallery fetch complete.")
    }
    
    // MARK: - Asynchronous Sequences
    // https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Asynchronous-Sequences
    
    /// Waits for the download of one photo of the collection at a time using an `asynchronous sequence`.
    @Test("Async array stream")
    func donwloadPhotos_inAsyncStream() async {
        // Arrange
        print("\t▶️ Start: Preparing to download multiple photos...")
        
        let photoNames = GalleryModel.summerVacationMock.photoNames
        
        let photosAsyncStream = AsyncStream<PhotoModel> { continuation in
            Task {
                for photoName in photoNames {
                    let photo = await downloadPhoto(named: photoName)
                    continuation.yield(photo)
                }
                continuation.finish()
            }
        }
        
        // Act
        var photosCount = 0
        for await photo in photosAsyncStream {
            photosCount += 1
            print("\t📦 Downloaded \(photo.data.count) bytes for {\(photo.name)}.")
        }
        
        // Assert
        #expect(photosCount == photoNames.count)
        print("\t⏹️ End: Multiple photos processing complete.")
    }
    
    // MARK: - Calling Asynchronous Functions in Parallel
    // https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Calling-Asynchronous-Functions-in-Parallel
    
    /// Calling an asynchronous function with await runs only one piece of code at a time.
    /// Each photo downloads completely before the next one starts downloading.
    @Test("Async functions in sequence")
    func downloadPhoto_whenInSequence() async {
        // Arrange
        print("\t▶️ Start: Sequential downloads...")
        
        let photoNames = GalleryModel.summerVacationMock.photoNames
        
        // Act
        let photo01 = await downloadPhoto(named: photoNames[0])
        let photo02 = await downloadPhoto(named: photoNames[1])
        let photo03 = await downloadPhoto(named: photoNames[2])
        let photo04 = await downloadPhoto(named: photoNames[3])
        let photo05 = await downloadPhoto(named: photoNames[4])
        let photo06 = await downloadPhoto(named: photoNames[5])
        let photo07 = await downloadPhoto(named: photoNames[6])
        let photo08 = await downloadPhoto(named: photoNames[7])
        let photo09 = await downloadPhoto(named: photoNames[8])
        let photo10 = await downloadPhoto(named: photoNames[9])
        
        let photos = [photo01, photo02, photo03, photo04, photo05, photo06, photo07, photo08, photo09, photo10]
        
        show(photos, prefix: "\t[Sequential]")
        
        // Assert
        #expect(photos.count == 10)
        print("\t⏹️ End: Sequential downloads complete.")
    }
    
    /// To call an asynchronous function and let it run in parallel with code around it,
    /// write async in front of let when you define a constant,
    /// and then write await each time you use the constant.
    @Test("Async functions in parallel")
    func downloadPhoto_whenInParallel() async {
        // Arrange
        print("\t▶️ Start: Parallel downloads...")
        
        let photoNames = GalleryModel.summerVacationMock.photoNames
        
        // Act
        async let photo01 = downloadPhoto(named: photoNames[0])
        async let photo02 = downloadPhoto(named: photoNames[1])
        async let photo03 = downloadPhoto(named: photoNames[2])
        async let photo04 = downloadPhoto(named: photoNames[3])
        async let photo05 = downloadPhoto(named: photoNames[4])
        async let photo06 = downloadPhoto(named: photoNames[5])
        async let photo07 = downloadPhoto(named: photoNames[6])
        async let photo08 = downloadPhoto(named: photoNames[7])
        async let photo09 = downloadPhoto(named: photoNames[8])
        async let photo10 = downloadPhoto(named: photoNames[9])
        
        let photos = await [photo01, photo02, photo03, photo04, photo05, photo06, photo07, photo08, photo09, photo10]
        
        show(photos, prefix: "\t[Parallel]")
        
        // Assert
        #expect(photos.count == 10)
        print("\t⏹️ End: Parallel downloads complete.")
    }
}
