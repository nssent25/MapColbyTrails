//
//  MapView.swift
//  MapColbyTrails
//
//  Created by Nithun S on 6/18/24.
//
//
//import SwiftUI
//import MapKit
//
//struct MapView: UIViewRepresentable {
//    @ObservedObject var viewModel: MapViewModel
//    
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        mapView.delegate = context.coordinator
//        mapView.showsUserLocation = true
//        return mapView
//    }
//    
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//        uiView.removeOverlays(uiView.overlays)
//        for trail in viewModel.trails {
//            let coordinatesPointer = trail.coordinates.withUnsafeBufferPointer { $0.baseAddress! }
//            let polyline = MKPolyline(coordinates: coordinatesPointer, count: trail.coordinates.count)
//            polyline.title = trail.name
//            uiView.addOverlay(polyline)
//        }
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    class Coordinator: NSObject, MKMapViewDelegate {
//        var parent: MapView
//        
//        init(_ parent: MapView) {
//            self.parent = parent
//        }
//        
//        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//            if let polyline = overlay as? MKPolyline {
//                let renderer = MKPolylineRenderer(polyline: polyline)
//                renderer.strokeColor = UIColor(named: "blue") ?? .blue // Assuming each trail has a unique color
//                renderer.lineWidth = 4
//                return renderer
//            }
//            return MKOverlayRenderer(overlay: overlay)
//        }
//    }
//}
//
//extension MKPolyline {
//    var coordinates: [CLLocationCoordinate2D] {
//        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: pointCount)
//        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))
//        return coords
//    }
//}


//import SwiftUI
//import MapKit
//
//struct MapView: View {
//    @ObservedObject var viewModel: MapViewModel
//    
//    @State private var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
//        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//    )
//    // Define the region centered on Colby College
//    private var colbyCollegeRegion: MKCoordinateRegion {
//        MKCoordinateRegion(
//            center: .colbyCollege,
//            span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.020) // Level of zoom
//        )
//    }
//
//    // Define the camera position centered on Colby College
//    private var colbyCollegeCamera: MapCameraPosition {
//        MapCameraPosition.region(colbyCollegeRegion)
//    }
//    
//    var body: some View {
//            Map(initialPosition: colbyCollegeCamera)
//                .mapControls {
//                    MapUserLocationButton()
//                    MapPitchToggle()
//                    MapCompass()
//                }
//            .edgesIgnoringSafeArea(.all)
//
//    }
//}
//
//#Preview {
//    MapView(viewModel: MapViewModel())
//}
//
//extension CLLocationCoordinate2D {
//    static let colbyCollege = CLLocationCoordinate2D(latitude: 44.5639, longitude: -69.6590)
//}



//struct MapPolyline: MapAnnotation<MapView> {
//    var coordinates: [CLLocationCoordinate2D]
//    
//    var body: some View {
//        Path { path in
//            guard let firstCoordinate = coordinates.first else { return }
//            let startPoint = CGPoint(x: firstCoordinate.latitude, y: firstCoordinate.longitude)
//            path.move(to: startPoint)
//            
//            for coordinate in coordinates.dropFirst() {
//                let nextPoint = CGPoint(x: coordinate.latitude, y: coordinate.longitude)
//                path.addLine(to: nextPoint)
//            }
//        }
//        .stroke(Color.blue, lineWidth: 4)
//    }
//}
