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
    @Published var trailInfos: [TrailInfo] = [] // Array of trail information
    @Published var userLocation = UserLocation() // User location

    // Load the trails on initialization
    init() {
        loadTrails()
        loadTrailInfos()
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
    
    // Function to get trail information
    func loadTrailInfos() {
        guard let url = Bundle.main.url(forResource: "trails-2", withExtension: "json") 
        else { print("Missing"); return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            trailInfos = try decoder.decode([TrailInfo].self, from: data)
        } catch {
            print("Failed to load or decode trails.json: \(error)")
        }
    }

    // Parse a GeoJSON feature into a Trail object
    func parseFeature(_ feature: MKGeoJSONFeature) -> Trail? {
        guard let propertiesData = feature.properties else { return nil }
        do {
            let properties = try JSONSerialization.jsonObject(with: propertiesData) as? [String: Any]
            let name: String = properties?["name"] as? String ?? "Unknown"
            let coordinates = (feature.geometry as? [MKPolyline])?.flatMap { $0.coordinates } ?? []
            let color = colorForTrail(named: name)
            return Trail(name: name, coordinates: coordinates, color: color)
        } catch {
            print("Error parsing feature properties: \(error)")
            return nil
        }
    }
    
    // Function to determine color based on trail name
    private func colorForTrail(named name: String) -> Color {
        switch name {
        case "Blue Trail":
            return .blue
        case "Green Trail":
            return .green
        case "Purple Trail":
            return .purple
        case "Red Trail":
            return .red
        case "Runnals Trails":
            return .brown
        case "White Trail":
            return .gray
        case "Yellow Trail":
            return .yellow
        case "PPD Trails":
            return .teal
        default:
            return .black // Default color if the trail name is not recognized
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
