//
//  TrailInfoCardView.swift
//  MapColbyTrails
//
//  Created by Nithun S on 6/19/24.
//

import SwiftUI

struct TrailInfoCardView: View {
    let trailInfo: TrailInfo
    @ObservedObject var viewModel: MapViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(trailInfo.name)
                .font(.headline)
                .foregroundStyle(viewModel.colorForTrail(named: trailInfo.name))
            Text(trailInfo.description)
                .font(.subheadline)
            HStack {
                Text("\(trailInfo.length, specifier: "%.1f") miles")
                Spacer()
                HStack(spacing: 5) {
                    ForEach(viewModel.suitabilitySymbols(for: trailInfo.suitability), id: \.self) { symbol in
                        Image(systemName: symbol)
                    }
                }
            }
            .font(.caption)
        }
        .padding()
        .background(.thinMaterial.opacity(0.35))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

#Preview {
    TrailInfoCardView(trailInfo: TrailInfo(name: "Blue Trail", description: "A sample trail description.", length: 3.0, suitability: "Walking, Biking"), viewModel: MapViewModel())
}
