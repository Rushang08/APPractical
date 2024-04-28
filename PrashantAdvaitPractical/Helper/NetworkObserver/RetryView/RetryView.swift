//
//  RetryView.swift
//  PrashantAdvaitPractical
//
//  Created by Rushang Prajapati on 28/04/24.
//

import SwiftUI

struct NoInternetView: View {
    var retryAction: () -> Void
    
    var body: some View {
        VStack {
            Image(systemName: "wifi.slash")
                .font(.system(size: 100))
                .foregroundColor(.gray)
                .padding(.bottom, 30)
            Text("No Internet Connection")
                .font(.title)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
            Button(action: retryAction) {
                Text("Retry")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 30)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}
