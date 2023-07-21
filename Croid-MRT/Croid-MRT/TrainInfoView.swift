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
    let nama_stasiun: String
    let stasiun_akhir: String
    @State var selectedTab = 1
    @StateObject var viewModel = ViewModel()
    @State private var kode_kereta: String?
    
    var filteredJadwalKereta: [JadwalKereta] {
        return viewModel.jadwalKereta.filter( { $0.posisi_kereta.nama_stasiun == nama_stasiun && ($0.waktu >= "16:00:00" && $0.waktu <= "17:30:00") && $0.stasiun_akhir == stasiun_akhir})
    }
//    var kode_kereta: String? {
//        return filteredJadwalKereta.first?.kereta_id.kereta_id
//    }
    
    var body: some View {
        ScrollView {
            
            VStack {
                // MARK: Quick info card
//                let x = print(filteredJadwalKereta)
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Tujuan akhir kereta:")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Text(stasiun_akhir)
                            .fontWeight(.semibold)
                            .font(.callout)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        
                        Text("Gerbong yang mungkin dapat dimasuki:")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            
                            ForEach(0..<(viewModel.keretaToShow?.count ?? 1), id:\.self) {index in
                                if index % 2 != 1 {
                                    HStack(spacing: 36) {
                                        QuickInfoRow(crowdstatus: viewModel.keretaToShow?[index].beratGerbong ?? .normal, namaGerbong: "Gerbong \(viewModel.keretaToShow?[index].nomorGerbong ?? "Unknown")")
                                        QuickInfoRow(crowdstatus: viewModel.keretaToShow?[index+1].beratGerbong ?? .normal, namaGerbong: "Gerbong \(viewModel.keretaToShow?[index+1].nomorGerbong ?? "Unknown")")
                                    }
                                }
                            }
                        }
                    }.task {
                        viewModel.loadJadwal()
                        viewModel.loadBerat(kode_kereta: filteredJadwalKereta.first?.kereta_id.kereta_id ?? "MRT-0002")
                    }
                    
                    Text("Data Terakhir Diperbaharui: " + getCurrentTime())
                        .font(.caption2)
                        .foregroundColor(Color(uiColor: .tertiaryLabel))
                    
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 12)
                .background(.white)
                .cornerRadius(8)
                .zIndex(1)
                .padding(16)
                
                LeftTrainTab()
                    .clipped()
            }
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }
    
    func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let currentTime = Date()
        let formattedTime = dateFormatter.string(from: currentTime)
        return formattedTime
    }
}

struct QuickInfoRow: View {
    let crowdstatus : CrowdStatus
    let namaGerbong: String
    var body: some View {
        HStack {
            Text(namaGerbong)
                .frame(width: 76, alignment: .leading)
                .font(.footnote)
                .fontWeight(.semibold)
            switch crowdstatus {
            case .kosong:
                Text("Kosong")
                    .font(.caption2)
                //                .frame(maxWidth: .infinity)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .foregroundColor(.white)
                    .background(Constants.Colors.levelGreen)
                    .cornerRadius(.infinity)
            case .santai:
                Text("Santai")
                    .font(.caption2)
                //                .frame(maxWidth: .infinity)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .foregroundColor(.white)
                    .background(Constants.Colors.levelBlue)
                    .cornerRadius(.infinity)
            case .normal:
                Text("Normal")
                    .font(.caption2)
                //                .frame(maxWidth: .infinity)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .foregroundColor(.black)
                    .background(Constants.Colors.levelYellow)
                    .cornerRadius(.infinity)
            case .ramai:
                Text("Ramai")
                    .font(.caption2)
                //                .frame(maxWidth: .infinity)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .foregroundColor(.white)
                    .background(Constants.Colors.levelOrange)
                    .cornerRadius(.infinity)
            case .penuh:
                Text("Penuh")
                    .font(.caption2)
                //                .frame(maxWidth: .infinity)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .foregroundColor(.white)
                    .background(Constants.Colors.levelRed)
                    .cornerRadius(.infinity)
//            default:
//                Text("No Respon")
//                    .font(.caption2)
//                //                .frame(maxWidth: .infinity)
//                    .padding(.vertical, 2)
//                    .padding(.horizontal, 8)
//                    .foregroundColor(.white)
//                    .background(Constants.Colors.levelRed)
//                    .cornerRadius(.infinity)
            }
        }
    }
}

struct TrainInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TrainInfoView(nama_stasiun: "Lebak Bulus Grab", stasiun_akhir: "Lebak Bulus Grab")
    }
}
