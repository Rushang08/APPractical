//
//  ImageCacheManager.swift
//  PrashantAdvaitPractical
//
//  Created by Rushang Prajapati on 28/04/24.
//

import Foundation
import UIKit
import Combine

class ImageCacheManager {
    static let shared = ImageCacheManager()
    
    // In-memory cache
    private var memoryCache = [String: UIImage]()
    private let memoryCacheMaxCount = AppConfig.maxCacheCount // Max number of images to keep in memory
    
    // Disk cache
    private let fileManager = FileManager.default
    private let diskCacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent("ImageCache")
    
    init() {
        // Create disk cache directory if not exists
        try? fileManager.createDirectory(at: diskCacheDirectory, withIntermediateDirectories: true, attributes: nil)
    }
    
    // Function to retrieve image from cache
    func getImage(withURL url: URL) -> UIImage? {
        let cacheKey = url.absoluteString
        
        // Check memory cache
        if let image = memoryCache[cacheKey] {
            return image
        }
        
        // Check disk cache
        if let imageData = try? Data(contentsOf: diskCacheDirectory.appendingPathComponent(cacheKey)),
           let image = UIImage(data: imageData) {
            // Store image in memory cache
            storeImageInMemory(image, withKey: cacheKey)
            return image
        }
        
        return nil // Image not found in cache
    }
    
    // Function to store image in memory cache
    func storeImageInMemory(_ image: UIImage, withKey key: String) {
        // Remove oldest image if memory cache limit exceeded
        if memoryCache.count >= memoryCacheMaxCount, let oldestKey = memoryCache.keys.first {
            memoryCache.removeValue(forKey: oldestKey)
        }
        
        // Store image in memory cache
        print("KEYWHICHSTORE", key)
        memoryCache[key] = image
    }
    
    // Function to store image in disk cache
    private func storeImageInDiskCache(_ image: UIImage, withKey key: String) {
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            try? imageData.write(to: diskCacheDirectory.appendingPathComponent(key))
        }
    }
    }
