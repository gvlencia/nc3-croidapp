//
//  TrainInfoView.swift
//  Croid-MRT
//
//  Created by Sae Pasomba on 17/07/23.
//

import SwiftUI

enum CrowdStatus {
    case kosong
    case santai
    case normal
    case ramai
    case penuh
}

struct TrainInfoView: View {
//    @State var selectedTab = 1
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                // MARK: Quick info card
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Tujuan akhir kereta:")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Text("Bundaran HI")
                            .fontWeight(.semibold)
                            .font(.callout)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Gerbong yang mungkin dapat dimasuki:")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 36) {
                                QuickInfoRow()
                                QuickInfoRow()
                            }
                            
                            HStack(spacing: 36) {
                                QuickInfoRow()
                                QuickInfoRow()
                            }
                            
                            HStack(spacing: 36) {
                                QuickInfoRow()
                                QuickInfoRow()
                            }
                        }
                    }
                    
                    Text("Data Terakhir Diperbaui: 16:45 WIB")
                        .font(.caption2)
                        .foregroundColor(Color(uiColor: .tertiaryLabel))
                    
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 12)
                .background(.white)
                .cornerRadius(8)
                .zIndex(1)
                .padding(16)
                
                if viewModel.isLoading {
                    Text("Loading...")
                }
                
                LeftTrainTab()
                    .clipped()
            }
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

struct QuickInfoRow: View {
    var body: some View {
        HStack {
            Text("Gerbong 02")
                .frame(width: 76, alignment: .leading)
                .font(.footnote)
                .fontWeight(.semibold)
            
            Text("Normal")
                .font(.caption2)
//                .frame(maxWidth: .infinity)
                .padding(.vertical, 2)
                .padding(.horizontal, 8)
                .foregroundColor(.white)
                .background(Constants.Colors.levelGreen)
                .cornerRadius(.infinity)
        }
    }
}

struct TrainInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TrainInfoView()
    }
}
