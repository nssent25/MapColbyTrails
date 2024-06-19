//
//  MapViewModel.swift
//  MapColbyTrails
//
//  Created by Nithun S on 6/18/24.
//

import Foundation
import MapKit
import SwiftUI

// Class for managing map-related data
class MapViewModel: ObservableObject {
    @Published var trails: [Trail] = [] // Array of trails
    @Published var userLocation = UserLocation() // User location

    // Load the trails on initialization
    init() {
        loadTrails()
    }

    // Load the trails from a GeoJSON file
    func loadTrails() {
        guard let url = Bundle.main.url(forResource: "map-2", withExtension: "geojson") else { return }
        do {
            let data = try Data(contentsOf: url)
            let geoJSON = try MKGeoJSONDecoder().decode(data)
            for feature in geoJSON { // Parse each feature in the GeoJSON data
                if let feature = feature as? MKGeoJSONFeature {
                    if let trail = parseFeature(feature) {
                        trails.append(trail) // Add the trail to the array
                    }
                }
            }
        } catch {
            print("Error loading trails: \(error)")
        }
    }

    // Parse a GeoJSON feature into a Trail object
    func parseFeature(_ feature: MKGeoJSONFeature) -> Trail? {
        guard let propertiesData = feature.properties else { return nil }
        do {
            let properties = try JSONSerialization.jsonObject(with: propertiesData) as? [String: Any]
            let name: String = properties?["name"] as? String ?? "Unknown"
            let coordinates = (feature.geometry as? [MKPolyline])?.flatMap { $0.coordinates } ?? []
            let color: Color = .blue // Use a default color if the named color is not found
            return Trail(name: name, coordinates: coordinates, color: color)
        } catch {
            print("Error parsing feature properties: \(error)")
            return nil
        }
    }
}

extension MKPolyline {
    var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: pointCount)
        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))
        return coords
    }
}
