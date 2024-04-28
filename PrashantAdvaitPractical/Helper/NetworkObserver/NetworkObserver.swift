//
//  NetworkObserver.swift
//  PrashantAdvaitPractical
//
//  Created by Rushang Prajapati on 28/04/24.
//

import Foundation
import Network

class NetworkObserver: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    @Published var isConnected: Bool = true
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
