//
//  Trail.swift
//  MapColbyTrails
//
//  Created by Nithun S on 6/18/24.
//

import Foundation
import MapKit
import SwiftUI

struct Trail: Identifiable {
    let id = UUID() // Unique identifier for each trail
    var name: String // Name of the trail
    var coordinates: [CLLocationCoordinate2D] // Array of coordinates for the trail
    var color: Color // Color of the trail
}

import Foundation

struct TrailInfo: Identifiable, Codable {
    let id = UUID()
    let name: String
    let description: String
    let length: Double // Length in miles
    let suitability: String // e.g., "Easy", "Moderate", "Hard"
}
