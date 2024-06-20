//
//  TrailInfosView.swift
//  MapColbyTrails
//
//  Created by Nithun S on 6/19/24.
//

import SwiftUI

struct TrailInfosView: View {
    @ObservedObject var viewModel: MapViewModel
    @Binding var showTrailCards: Bool
    
    var body: some View {
        VStack {
            Spacer()
            TabView {
                ForEach(viewModel.trailInfos) { trailInfo in
                    TrailInfoCardView(trailInfo: trailInfo)
                        .padding()  // Optional: Add padding for better aesthetics
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .frame(height: 200)
            .background(.clear)  // Use thin material for the background
            .cornerRadius(16)  // Optional: Add corner radius for rounded corners
//            .padding()
        }
        .background(.thinMaterial)
    }
}

#Preview {
    StateWrapper {
        TrailInfosView(viewModel: MapViewModel(), showTrailCards: $0)
    }
}

struct StateWrapper<Content: View>: View {
    @State private var value = true
    var content: (Binding<Bool>) -> Content

    var body: some View {
        content($value)
    }
}
