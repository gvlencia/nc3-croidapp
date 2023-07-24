//
//  TrainInfoTab.swift
//  Croid-MRT
//
//  Created by Sae Pasomba on 20/07/23.
//

import SwiftUI


struct LeftTrainTab: View {
    @ObservedObject var viewModel: ViewModel
    let nama_stasiun: String
    
    var body: some View {
        if viewModel.isLoading {
            VStack {
                ProgressView()
                Text("Mengambil Data")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        } else {
            ZStack {
                Image("Lantai")
                    .resizable()
                    .scaleEffect(1.17)
                HStack {
                    Image("Rel Kereta")
                        .scaleEffect(1.2)
                        .background {
                            Color(.darkGray)
                                .scaleEffect(x: 1.35, y: 1.2)
                        }
                    Spacer()
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(viewModel.keretaToShow ?? [], id:\.id) { gerbong in
                        
                        HStack(alignment: .top, spacing: 0) {
                            ZStack {
                                Image(gerbong.nomorGerbong == "1"
                                      ? "Gerbong Depan"
                                      : gerbong.nomorGerbong == "6"
                                      ? "Gerbong Belakang"
                                      : "Gerbong Tengah")
                                .scaledToFit()
                                if (nama_stasiun == "Lebak Bulus Grab" || nama_stasiun == "Bundaran HI"){
                                    VStack{
                                        Spacer()
                                        Image("Bar Kosong").scaledToFit()
                                    }
                                } else {
                                    VStack {
                                        Spacer()
                                        switch gerbong.beratGerbong {
                                        case .kosong: Image("Bar Kosong").scaledToFit()
                                        case .santai: Image("Bar Santai").scaledToFit()
                                        case .normal: Image("Bar Normal").scaledToFit()
                                        case .ramai: Image("Bar Ramai").scaledToFit()
                                        case .penuh: Image("Bar Penuh").scaledToFit()
                                        }
                                        
                                    }
                                }
                                
                            }
                            
                            Group {
                                HStack(spacing: -15) {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 16)
                                    Rectangle()
                                        .fill(.white)
                                        .frame(width: 100, height: 4)
                                }
                                .padding(.top, 16)
                                .offset(x: -40)
                                
                                if (nama_stasiun == "Lebak Bulus Grab" || nama_stasiun == "Bundaran HI"){
                                    InfoCard(gateNumber: gerbong.nomorGerbong, crowdStatus: .kosong)
                                        .padding(.leading, (-100 + 32))
                                } else {
                                    InfoCard(gateNumber: gerbong.nomorGerbong, crowdStatus: gerbong.beratGerbong)
                                        .padding(.leading, (-100 + 32))
                                }
                            }
                            .padding(.top)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct RightTrainTab: View {
    var body: some View {
        ScrollView(.vertical) {
            ZStack {
                Image("Lantai")
                    .resizable()
                    .scaleEffect(1.17)
                
                HStack {
                    Spacer()
                    
                    Image("Rel Kereta")
                        .scaleEffect(1.2)
                        .background {
                            Color(.darkGray)
                                .scaleEffect(x: 1.35, y: 1.2)
                        }
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(1...6, id:\.self) { index in
                        HStack(alignment: .top, spacing: 0) {
                            Group {
                                InfoCard(gateNumber: "Gate 00", crowdStatus: index == 1 ? .santai : index == 2 ? .kosong : .penuh, isWomanGate: index == 1 || index == 6)
                                    .padding(.trailing, (-100 + 32))
                                
                                HStack(spacing: -15) {
                                    Rectangle()
                                        .fill(.white)
                                        .frame(width: 100, height: 4)
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 16)
                                }
                                .zIndex(1)
                                .padding(.top, 16)
                                .offset(x: 40)
                                
                            }
                            .padding(.top)
                            
                            ZStack {
                                Image(index == 1
                                      ? "Gerbong Depan"
                                      : index == 6
                                      ? "Gerbong Belakang"
                                      : "Gerbong Tengah")
                                .scaledToFit()
                                VStack {
                                    Spacer()
                                    Image("Bar Normal")
                                        .scaledToFit()
                                }
                            }
                            
                        }
                    }
                }
                .padding(.horizontal)
            }
            
        }
        .scrollIndicators(.hidden)
    }
}



struct TrainInfoTab_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            LeftTrainTab(viewModel: ViewModel(), nama_stasiun: "Lebak Bulus Grab")
        }
    }
}
