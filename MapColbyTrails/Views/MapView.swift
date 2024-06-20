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
    @State private var mapType: MapStyle = .standard
    @State private var satelliteMap: Bool = false
    @State private var timer: Timer?

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
//            .gesture(TapGesture().onEnded {
//                withAnimation {
//                    showMenu.toggle()
//                }
//                resetInactivityTimer()
//            })
            .mapStyle(mapType)
            .mapControls {
                MapPitchToggle()
                MapScaleView()
                MapCompass()
                    .mapControlVisibility(.visible)
                MapUserLocationButton()
                    .onTapGesture {
                        if let location = viewModel.userLocation.currentLocation {
                            cameraPosition = .region(MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.020)))
                        }
                    }
            }

            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        cameraPosition = .colbyCollegeCam
//                        resetInactivityTimer()
                    }) {
                        Image(systemName: "house")
                            .padding(12)
                            .background(.thickMaterial)
                            .foregroundColor(.accentColor)
                            .cornerRadius(8)
                            .shadow(radius: 28)
                    }

                    Button(action: {
                        showTrailCards = true
//                        resetInactivityTimer()
                    }) {
                        Label("Show Trails", systemImage: "figure.walk")
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                            .shadow(radius: 28)
                    }
                    .padding()

                    Button(action: {
                        satelliteMap.toggle()
                        mapType = satelliteMap ? .imagery : .standard
//                        resetInactivityTimer()
                    }) {
                        Image(systemName: "map")
                            .padding(12)
                            .background(.thickMaterial)
                            .foregroundColor(.accentColor)
                            .cornerRadius(8)
                            .shadow(radius: 28)
                    }
                }
                .offset(y: showMenu ? 10 : UIScreen.main.bounds.height)
                .opacity(showMenu ? 1 : 0)
                .animation(.easeInOut(duration: 0.5), value: showMenu)
            }
            .sheet(isPresented: $showTrailCards) {
                ZStack {
                    TrailInfosView(viewModel: viewModel, showTrailCards: $showTrailCards)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                }
            }
            .onAppear {
//                startInactivityTimer()
            }
            .onDisappear() {
//                startInactivityTimer()
            }
        }
    }

    // Function to reset the inactivity timer
    private func resetInactivityTimer() {
        timer?.invalidate()
        startInactivityTimer()
    }

    // Function to start the inactivity timer
    private func startInactivityTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            withAnimation {
                showMenu = false
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
