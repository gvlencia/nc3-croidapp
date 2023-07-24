//
//  DetailCrowdKereta.swift
//  Croid-MRT
//
//  Created by Gaizka Valencia on 18/07/23.
//

import SwiftUI

struct DetailCrowdKereta: View {
    let nama_stasiun: String
    let stasiun_akhir: String
    let kode_kereta: String?
    @StateObject var viewModel = ViewModel()
    @State private var timeNow: String = ""
    
    var filteredJadwalKereta: [JadwalKereta] {
        return viewModel.jadwalKereta.filter( { $0.posisi_kereta.nama_stasiun == nama_stasiun && ($0.waktu >= "16:00:00" && $0.waktu <= "17:30:00") && $0.stasiun_akhir == stasiun_akhir})
    }
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Text("Waktu menunjukkan pukul: ")
                    Text(getCurrentTime())
                }
                .padding()
                
                if viewModel.jadwalKereta.isEmpty{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(3)
                } else {
                    ForEach(viewModel.jadwalKereta.filter(
                        {
                            $0.posisi_kereta.nama_stasiun == nama_stasiun && (
                                $0.waktu >= "16:00:00" && $0.waktu <= "17:30:00"
                            )
                            && $0.stasiun_akhir == stasiun_akhir

                        }
                    ), id:\.self){item in
                        HStack{
                            Text("\(item.kereta_id.kereta_id)")
                            Text("\(item.waktu)")
                        }
                    }
                    HStack{
                        Text(kode_kereta ?? "MRT-No gada")
                    }
                    ForEach(viewModel.beratKereta.filter({$0.kereta_id.kereta_id == kode_kereta}), id:\.self){beratItem in
                        HStack{
                            Text("Gerbong \(beratItem.nomor_gerbong):")
                            Text("\(getCountPeople(beratGebrong:beratItem.berat_gerbong)) orang")
                        }
                        
                    }
                    .padding()
                }
            }
        }
        .task {
            viewModel.loadJadwal()
            viewModel.loadBerat(kode_kereta: kode_kereta)
        }
        .navigationTitle(nama_stasiun)
        
        
    }
    
    func getCurrentTime() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let currentTime = Date()
            let formattedTime = dateFormatter.string(from: currentTime)
            return formattedTime
        }
    func getCountPeople(beratGebrong: Int) -> Int {
        let countPeople = beratGebrong / 60
        return countPeople
    }
}

struct DetailCrowdKereta_Previews: PreviewProvider {
    static var previews: some View {
        DetailCrowdKereta(nama_stasiun: "Lebak Bulus Grab", stasiun_akhir: "Lebak Bulus Grab", kode_kereta: "MRT-0001")
    }
}
