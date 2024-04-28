//
//  ImageGridView.swift
//  PrashantAdvaitPractical
//
//  Created by Rushang Prajapati on 28/04/24.
//

import SwiftUI

struct ImageGridView: View {
    @StateObject var viewModel = ImageGridViewModel()
    @StateObject var networkObserver = NetworkObserver()
    let gridSpacing: CGFloat = 10

    var body: some View {
        if networkObserver.isConnected{
            Group{
                if viewModel.isLoading{
                    loadingView
                } else {
                    contentView
                }
                
            }
            .navigationTitle("Image Grid")
            
        } else{
            noInterView
        }
    }
    
    private var loadingView: some View {
        VStack {
            Spacer()
            ProgressView()
            Spacer()
        }
        
    }

    private var contentView: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: gridSpacing) {
                ForEach(viewModel.imageURLs, id: \.self) { url in
                    AsyncImageView(url: url)
                }
            }
            .padding()
        }
    }
    
    private var noInterView: some View {
        NoInternetView {
            viewModel.fetchMediaCoverages()
        }
        
    }
    
}

