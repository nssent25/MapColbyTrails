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
    @State private var selectedTrail: Trail? = nil
    @State private var showMenu: Bool = true
    @State var showTrailCards: Bool = false
    @State private var cameraPosition: MapCameraPosition = .colbyCollegeCam

    var body: some View {
        ZStack {
            Map(position: $cameraPosition) {
                // Loop through each trail and add a MapPolyline
                ForEach(viewModel.trails) { trail in
                    MapPolyline(coordinates: trail.coordinates)
                        .stroke(trail.color, lineWidth: 4)
                }
                UserAnnotation()
            }
            .mapControls {
                MapUserLocationButton()
                    .onTapGesture {
                        if let location = viewModel.userLocation.currentLocation {
                            cameraPosition = .region(MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.020)))
                        }
                    }
                MapPitchToggle()
                Button("Center"){
                    cameraPosition = .colbyCollegeCam
                }
                MapScaleView()
                MapCompass()
                    .mapControlVisibility(.visible)
            }
//            .onTapGesture {
//                showMenu.toggle()
//            }
            
            if showMenu {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        VStack {
                            Button("Show All Trails") {
                                showTrailCards = true
                            }
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .padding()
                        }
                        Spacer()
                    }
                }
                .sheet(isPresented: $showTrailCards) {
                    ZStack {
//                        Color.black.edgesIgnoringSafeArea(.all)
                        TrailInfosView(viewModel: viewModel, showTrailCards: $showTrailCards)
                            .presentationDetents([.medium])
                            .presentationDragIndicator(.visible)
                    }
                }
            }
                
        }
    }
}

#Preview {
    MapView(viewModel: MapViewModel())
}

extension CLLocationCoordinate2D {
    static let colbyCollege = CLLocationCoordinate2D(latitude: 44.5639, longitude: -69.6590)
}

extension MKCoordinateRegion {
    static let colbyCollegeRegion = MKCoordinateRegion(
        center: .colbyCollege,
        span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.020)
    )
}

extension MapCameraPosition {
    static var colbyCollegeCam: MapCameraPosition {
        .region(.colbyCollegeRegion)
    }
}
