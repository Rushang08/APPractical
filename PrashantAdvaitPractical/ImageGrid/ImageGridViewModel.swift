//
//  ImageGridViewModel.swift
//  PrashantAdvaitPractical
//
//  Created by Rushang Prajapati on 25/04/24.
//

import Foundation
import UIKit
import Combine
import SwiftUI

class ImageGridViewModel: ObservableObject {
    @Published var mediaCoverages: [MediaCoverage] = []
    @Published var isLoading:Bool
    private var cancellable: AnyCancellable?
    var imageURLs: [URL] {
        return self.mediaCoverages.map { URL(string: "\($0.thumbnail.domain)/\($0.thumbnail.basePath)/0/\($0.thumbnail.key)")!}
    }

    init() {
        self.isLoading = false
        fetchMediaCoverages()
    }
    
    func fetchMediaCoverages() {
        self.isLoading = true
        guard let url = URL(string: APIEndpoints.mediaCoverages) else { return }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [MediaCoverage].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.isLoading = false
                }                
            }, receiveValue: { mediaCoverages in
                self.mediaCoverages = mediaCoverages
            })

    }
}
