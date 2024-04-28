//
//  AsyncImage.swift
//  PrashantAdvaitPractical
//
//  Created by Rushang Prajapati on 28/04/24.
//

import SwiftUI
import Combine

struct AsyncImageView: View {
    @StateObject private var imageLoader: ImageLoader
    var urlToStore:String
    
    init(url: URL) {
        self.urlToStore = url.absoluteString
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        if let url = URL(string: self.urlToStore),
           let image = ImageCacheManager.shared.getImage(withURL: url) {
            imageView(for: image)
        } else if let image = imageLoader.image {
            imageView(for: image)
                .onAppear {
                    ImageCacheManager.shared.storeImageInMemory(image, withKey: self.urlToStore)
                }
        } else {
            // Placeholder or loading indicator
            if let image = UIImage(named: Constant.placeHolderImage){
                imageView(for:image)
            }

        }
    }
    
    @ViewBuilder
    func imageView(for image:UIImage) -> some View{
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
            .cornerRadius(10) // Optional: Add corner radius
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
        
    }
    
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?
    private let placeholder: UIImage? // Placeholder image
    
    init(url: URL) {
        self.placeholder = UIImage(systemName: Constant.placeHolderImage)
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .map { UIImage(data: $0) ?? self.placeholder } // Use placeholder if image data is nil
            .replaceError(with: placeholder) // Use placeholder if there's an error
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
}
