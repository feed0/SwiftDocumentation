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
    
    /// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Defining-and-Calling-Asynchronous-Functions
    @Test("Sequential async execution")
    func downloadPhotoFlow() async {
        /// Arrange
        print("\t▶️ Start: Preparing to download photo...")
        
        let name = "Summer_Vacation_01"
        
        /// Act
        let photo = await downloadPhoto(named: name)
        
        /// Assert
        #expect(!photo.data.isEmpty)
        print("\t📦 Downloaded \(photo.byteCount) bytes for \(name).")
        print("\t⏹️ End: Photo processing complete.")
    }
    
    /// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Asynchronous-Sequences
    @Test("Async array stream")
    func donwloadMultiplePhotos() async {
        /// Arrange
        print("\t▶️ Start: Preparing to download multiple photos...")
        
        let photoNames = ["Sunset", "Mountain", "City_Lights", "Whale", "Dawn", "Dusk", "Tides", "Waves", "Model", "Editorial"]
        
        let photosAsyncStream = AsyncStream<PhotoModel> { continuation in
            Task {
                for photoName in photoNames {
                    let photo = await downloadPhoto(named: photoName)
                    continuation.yield(photo)
                }
                continuation.finish()
            }
        }
        
        /// Act
        for await photo in photosAsyncStream {
            print("\t📦 Downloaded \(photo.data.count) bytes for {\(photo.name)}.")
        }
        
        /// Assert
        print("\t⏹️ End: Multiple photos processing complete.")
    }
    
    /// https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/#Calling-Asynchronous-Functions-in-Parallel
    @Test(
        "Async functions in parallel",
        arguments: [
            true,
            false
        ]
    )
    func sequentialAndParallelDownloads(isParalel: Bool) async {
        /// Sequential
        if !isParalel {
            print("\t▶️ Start: Sequential downloads...")
            
            for photoName in ["seq1", "seq2", "seq3", "seq4", "seq5", "seq6", "seq7", "seq8", "seq9", "seq10", "seq11", "seq12", "seq13", "seq14", "seq15", "seq16", "seq17", "seq18", "seq19", "seq20"] {
                _ = await downloadPhoto(named: photoName)
                print("\t📦 Downloaded \(photoName)...")
            }
            
            print("\t⏹️ End: Sequential downloads complete.")
        }
        
        /// Parallel
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
