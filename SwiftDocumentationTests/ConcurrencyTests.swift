//
//  ConcurrencyTests.swift
//  SwiftDocumentationTests
//
//  Created by feed0 on 2026/06/08.
//

import Testing
import Foundation

@Suite(.serialized)
struct ConcurrencyTests {
    
    // MARK: - Defining and Calling Asynchronous Functions
    // https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Defining-and-Calling-Asynchronous-Functions
    
    /// Synchronous functions/methods either i. return, or ii. throw, or iii. never return.
    /// While asynchronous ones do one of the three, but also can suspend in the middle of instructions.
    /// Asynchronous code can only be called from other async code. Even this test function!
    @Test("Async execution")
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
    
    /// asynchronously returns the whole array at once, after all of the array’s elements are ready.
    @Test("Async execution")
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
    func donwloadMultiplePhotos() async {
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
        for await photo in photosAsyncStream {
            print("\t📦 Downloaded \(photo.data.count) bytes for {\(photo.name)}.")
        }
        
        // Assert
        print("\t⏹️ End: Multiple photos processing complete.")
    }
    
    // MARK: - Calling Asynchronous Functions in Parallel
    // https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Calling-Asynchronous-Functions-in-Parallel
    
    @Test(
        "Async functions in parallel",
        arguments: [
            true,
            false
        ]
    )
    func sequentialAndParallelDownloads(isParalel: Bool) async {
        // Sequential
        if !isParalel {
            print("\t▶️ Start: Sequential downloads...")
            
            for photoName in ["seq1", "seq2", "seq3", "seq4", "seq5", "seq6", "seq7", "seq8", "seq9", "seq10", "seq11", "seq12", "seq13", "seq14", "seq15", "seq16", "seq17", "seq18", "seq19", "seq20"] {
                _ = await downloadPhoto(named: photoName)
                print("\t📦 Downloaded \(photoName)...")
            }
            
            print("\t⏹️ End: Sequential downloads complete.")
        }
        
        // Parallel
        if isParalel {
            Task {
                print("\t▶️ Start: Parallel downloads...")
                
                for photoName in ["par1", "par2", "par3", "par4", "par5", "par6", "par7", "par8", "par9", "par10", "par11", "par12", "par13", "par14", "par15", "par16", "par17", "par18", "par19", "par20"] {
                    async let _ = downloadPhoto(named: photoName)
                    print("\t📦 Downloaded \(photoName)...")
                    
                }
                
                print("\t⏹️ End: Parallel downloads complete.")
            }
        }
    }
}
