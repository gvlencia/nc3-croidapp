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
    let kode_kereta: String?
    @State var selectedTab = 1
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
                        Text(stasiun_akhir)
                            .fontWeight(.semibold)
                            .font(.callout)
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        VStack(alignment: .leading, spacing: 12) {
                            if viewModel.isLoading {
                                VStack {
                                    ProgressView()
                                    Text("Mengambil data")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                            } else {
                                Text("Gerbong yang mungkin dapat dimasuki:")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                
                                ForEach(0..<(viewModel.keretaToShow?.count ?? 1), id:\.self) {index in
                                    if index % 2 != 1 {
                                        HStack(spacing: 36) {
                                            if (nama_stasiun == "Lebak Bulus Grab" || nama_stasiun == "Bundaran HI"){
                                                QuickInfoRow(crowdstatus: .kosong, namaGerbong: "Gerbong \(viewModel.keretaToShow?[index].nomorGerbong ?? "Unknown")")
                                                QuickInfoRow(crowdstatus: .kosong, namaGerbong: "Gerbong \(viewModel.keretaToShow?[index+1].nomorGerbong ?? "Unknown")")
                                            } else{
                                                QuickInfoRow(crowdstatus: viewModel.keretaToShow?[index].beratGerbong ?? .normal, namaGerbong: "Gerbong \(viewModel.keretaToShow?[index].nomorGerbong ?? "Unknown")")
                                                QuickInfoRow(crowdstatus: viewModel.keretaToShow?[index+1].beratGerbong ?? .normal, namaGerbong: "Gerbong \(viewModel.keretaToShow?[index+1].nomorGerbong ?? "Unknown")")
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }.task {
                        viewModel.loadBerat(kode_kereta: kode_kereta ?? "MRT-0002")
                    }
                    
                    Text("Data Terakhir Diperbaharui: " + getCurrentTime())
                        .font(.caption2)
                        .foregroundColor(Color(uiColor: .tertiaryLabel))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .padding(.horizontal, 12)
                .background(.white)
                .cornerRadius(8)
                .zIndex(1)
                .padding(16)
                
                LeftTrainTab(viewModel: viewModel, nama_stasiun: nama_stasiun)
                    .clipped()
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color(uiColor: .systemGroupedBackground))
        .navigationTitle("\(nama_stasiun)")
        .navigationBarTitleDisplayMode(.inline)
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
        HStack(spacing: 8) {
            Text(namaGerbong)
                .frame(width: 76, alignment: .leading)
                .font(.footnote)
                .fontWeight(.semibold)
            switch crowdstatus {
            case .kosong:
                Text("Kosong")
                    .font(.caption2)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .foregroundColor(.white)
                    .background(Constants.Colors.levelGreen)
                    .cornerRadius(.infinity)
            case .santai:
                Text("Santai")
                    .font(.caption2)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .foregroundColor(.white)
                    .background(Constants.Colors.levelBlue)
                    .cornerRadius(.infinity)
            case .normal:
                Text("Normal")
                    .font(.caption2)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .foregroundColor(.black)
                    .background(Constants.Colors.levelYellow)
                    .cornerRadius(.infinity)
            case .ramai:
                Text("Ramai")
                    .font(.caption2)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 2)
                    .padding(.horizontal, 8)
                    .foregroundColor(.white)
                    .background(Constants.Colors.levelOrange)
                    .cornerRadius(.infinity)
            case .penuh:
                Text("Penuh")
                    .font(.caption2)
                    .frame(maxWidth: .infinity)
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
        TrainInfoView(nama_stasiun: "Lebak Bulus Grab", stasiun_akhir: "Lebak Bulus Grab", kode_kereta: "MRT-0001")
    }
}
