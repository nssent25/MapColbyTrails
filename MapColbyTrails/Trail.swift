//
//  Trail.swift
//  MapColbyTrails
//
//  Created by Nithun S on 6/18/24.
//

import Foundation
import MapKit

struct Trail: Identifiable {
    let id = UUID() // Unique identifier for each trail
    var name: String // Name of the trail
    var coordinates: [CLLocationCoordinate2D] // Array of coordinates for the trail
    var color: UIColor // Color of the trail
}
