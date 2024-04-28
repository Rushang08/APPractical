//
//  MediaCoverage.swift
//  PrashantAdvaitPractical
//
//  Created by Rushang Prajapati on 25/04/24.
//

import Foundation
import UIKit
import SwiftUI
import Combine

struct MediaCoverage: Codable {
    let id: String
    let title: String
    let thumbnail: Thumbnail
    let coverageURL: String
}

struct Thumbnail: Codable {
    let domain: String
    let basePath: String
    let key: String
}
