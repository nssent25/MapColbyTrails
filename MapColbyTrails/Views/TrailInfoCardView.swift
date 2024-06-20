//
//  TrailInfoCardView.swift
//  MapColbyTrails
//
//  Created by Nithun S on 6/19/24.
//

import SwiftUI

struct TrailInfoCardView: View {
    let trailInfo: TrailInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(trailInfo.name)
                .font(.headline)
            Text(trailInfo.description)
                .font(.subheadline)
            HStack {
                Text("\(trailInfo.length, specifier: "%.1f") miles")
                Spacer()
                Text("Suitability: \(trailInfo.suitability)")
            }
            .font(.caption)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(15)
        .shadow(radius: 5)
//        .padding()
    }
}


#Preview {
    TrailInfoCardView(trailInfo: TrailInfo(name: "Sample Trail", description: "A sample trail description.", length: 3.0, suitability: "Walking, Biking"))
//        .previewLayout(.sizeThatFits)
}
