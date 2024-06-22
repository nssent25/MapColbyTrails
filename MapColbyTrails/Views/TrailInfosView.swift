//
//  TrailInfosView.swift
//  MapColbyTrails
//
//  Created by Nithun S on 6/19/24.
//

import SwiftUI

struct TrailInfosView: View {
    @ObservedObject var viewModel: MapViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("All Trails")
                    .font(.title)
                    .bold()
                .padding()
                Spacer()
            }
            .padding()
            
            ScrollView {
                ForEach(viewModel.trailInfos) { trailInfo in
                    TrailInfoCardView(trailInfo: trailInfo, viewModel: viewModel)
                        .padding(.horizontal)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
//            .frame(height: 200)
            .background(.clear)
            .cornerRadius(16)
//            .padding()
        }
    }
}

#Preview {
        TrailInfosView(viewModel: MapViewModel())
}
