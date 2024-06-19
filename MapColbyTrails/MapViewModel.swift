//
//  MapViewModel.swift
//  MapColbyTrails
//
//  Created by Nithun S on 6/18/24.
//

import Foundation
import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    @Published var trails: [Trail] = []
    @Published var userLocation = UserLocation()

    init() {
        loadTrails()
    }

    func loadTrails() {
        guard let url = Bundle.main.url(forResource: "map-2", withExtension: "geojson") else { return }
        do {
            let data = try Data(contentsOf: url)
            let geoJSON = try MKGeoJSONDecoder().decode(data)
            for feature in geoJSON {
                if let feature = feature as? MKGeoJSONFeature {
                    if let trail = parseFeature(feature) {
                        trails.append(trail)
                    }
                }
            }
        } catch {
            print("Error loading trails: \(error)")
        }
    }

    func parseFeature(_ feature: MKGeoJSONFeature) -> Trail? {
        guard let propertiesData = feature.properties else { return nil }
        do {
            let properties = try JSONSerialization.jsonObject(with: propertiesData) as? [String: Any]
            let name: String = properties?["name"] as? String ?? "Unknown"
            let coordinates = (feature.geometry as? [MKPolyline])?.flatMap { $0.coordinates } ?? []
            let color = UIColor(named: "blue") ?? .blue // Use a default color if the named color is not found
            return Trail(name: name, coordinates: coordinates, color: color)
        } catch {
            print("Error parsing feature properties: \(error)")
            return nil
        }
    }
}

