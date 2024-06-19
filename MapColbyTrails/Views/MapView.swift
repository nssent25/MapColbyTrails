//
//  MapView.swift
//  MapColbyTrails
//
//  Created by Nithun S on 6/18/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var viewModel: MapViewModel

    // Define the region centered on Colby College
    private var colbyCollegeRegion: MKCoordinateRegion {
        MKCoordinateRegion(
            center: .colbyCollege,
            span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.020) // Level of zoom
        )
    }

    // Define the camera position centered on Colby College
    private var colbyCollegeCamera: MapCameraPosition {
        MapCameraPosition.region(colbyCollegeRegion)
    }

    var body: some View {
        Map(initialPosition: colbyCollegeCamera) {
            // Loop through each trail and add a MapPolyline
            ForEach(viewModel.trails) { trail in
                MapPolyline(coordinates: trail.coordinates)
                    .stroke(trail.color, lineWidth: 5)
            }
        }
        .mapControls {
            MapUserLocationButton()
            MapPitchToggle()
            MapCompass()
        }
    }
}

#Preview {
    MapView(viewModel: MapViewModel())
}

extension CLLocationCoordinate2D {
    static let colbyCollege = CLLocationCoordinate2D(latitude: 44.5639, longitude: -69.6590)
}
