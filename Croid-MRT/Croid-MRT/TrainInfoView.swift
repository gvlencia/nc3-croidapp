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

struct InfoCard: View {
    
    struct GateInformation {
        var tagLabel: String
        var tagIcon: String
        var tagColor: Color
        var description: String
    }
    
    var gateNumber: String
    var crowdStatus: CrowdStatus
    var gateInformation: GateInformation {
        switch crowdStatus {
        case .kosong:
            return GateInformation(
                tagLabel: "Kosong",
                tagIcon: "door.french.open",
                tagColor: Constants.Colors.levelGreen,
                description: "Hampir tidak ada penumpang, banyak tempat duduk yang tersedia."
            )
        case .santai:
            return GateInformation(
                tagLabel: "Santai",
                tagIcon: "door.french.open",
                tagColor: Constants.Colors.levelBlue,
                description: "Beberapa penumpang, banyak tempat duduk kosong."
            )
        case .normal:
            return GateInformation(
                tagLabel: "Normal",
                tagIcon: "door.french.open",
                tagColor: Constants.Colors.levelYellow,
                description: "Lebih banyak penumpang, masih ada ruang berdiri yang nyaman."
            )
        case .ramai:
            return GateInformation(
                tagLabel: "Ramai",
                tagIcon: "door.french.open",
                tagColor: Constants.Colors.levelOrange,
                description: "Penumpang memenuhi gerbong, ruang berdiri sangat terbatas."
            )
        case .penuh:
            return GateInformation(
                tagLabel: "Penuh",
                tagIcon: "door.french.open",
                tagColor: Constants.Colors.levelRed,
                description: "Gerbong penuh sesak, sulit untuk bergerak."
            )
        }
    }
    var isWomanGate = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(gateNumber)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                HStack(spacing: 4) {
                    Text("\(gateInformation.tagLabel)")
                    Image(systemName: "\(gateInformation.tagIcon)")
                }
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(gateInformation.tagColor)
                .cornerRadius(.infinity)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("\(gateInformation.description)")
                if isWomanGate {
                    Text("Dari jam 7.00 - 9:00, gerbong ini khusus untuk wanita")
                        .foregroundColor(.red)
                }
            }
            .font(.caption2)
        }
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}

struct TrainInfoView: View {
    @State var selectedTab = 1
    
    var body: some View {
        VStack {
            // MARK: PICKER
            Picker("Pilih tujuan akhir", selection: $selectedTab) {
                Text("Dukuh Atas BNI").tag(0)
                Text("Bundaran HI").tag(1)
            }
            .pickerStyle(.segmented)
            
            switch selectedTab {
            case 0:
                LeftTrainTab()
            case 1:
                RightTrainTab()
            default:
                EmptyView()
            }
        }
    }
}

struct TrainInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TrainInfoView()
    }
}

struct LeftTrainTab: View {
    var body: some View {
        ScrollView(.vertical) {
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
                    ForEach(1...6, id:\.self) { index in
                        HStack(alignment: .top, spacing: 0) {
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
                                
                                InfoCard(gateNumber: "Gate 00", crowdStatus: index == 1 ? .santai : index == 2 ? .kosong : .penuh)
                                    .padding(.leading, (-100 + 32))
                            }
                            .padding(.top)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .scrollIndicators(.hidden)
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

