//
//  ContentView.swift
//  MapColbyTrails
//
//  Created by Nithun S on 6/18/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        MapView(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}
