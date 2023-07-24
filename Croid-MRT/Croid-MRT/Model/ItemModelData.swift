//
//  ItemModelData.swift
//  Croid-MRT
//
//  Created by Gaizka Valencia on 17/07/23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var lokasiStasiun: [LokasiStasiun] = []
    @Published var jadwalKereta: [JadwalKereta] = []
    @Published var beratKereta: [BeratGerbongKereta] = []
    @Published var keretaToShow: [Gerbong]?
    
    func loadLokasi() {
        guard let url = URL(string: "https://backend-croid-api.vercel.app/api/lokasistasiunmrt/") else {
            return
        }
        
//        guard let url = URL(string: "http://127.0.0.1:8000/api/lokasistasiunmrt/") else {
//            return
//        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak
            self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let lokasiStasiun = try JSONDecoder().decode([LokasiStasiun].self, from: data)
                DispatchQueue.main.async {
                    self?.lokasiStasiun = lokasiStasiun
                }
            }
            catch {
                print(error)
            }
        }
        
        
        task.resume()
    }
    
    func loadJadwal() {
        guard let url = URL(string: "https://backend-croid-api.vercel.app/api/jadwalkereta/") else {
            return
        }
        
//        guard let url = URL(string: "http://127.0.0.1:8000/api/jadwalkereta/") else {
//            return
//        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak
            self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let jadwalKereta = try JSONDecoder().decode([JadwalKereta].self, from: data)
                DispatchQueue.main.async {
                    self?.jadwalKereta = jadwalKereta
                    
                }
            }
            catch {
                print(error)
            }
        }
        
        
        task.resume()
    }
    
    func loadBerat(kode_kereta : String?) {
        guard let url = URL(string: "https://backend-croid-api.vercel.app/api/beratgerbongkereta/") else {
            return
        }
        
//        guard let url = URL(string: "http://127.0.0.1:8000/api/beratgerbongkereta/") else {
//            return
//        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak
            self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let beratKereta = try JSONDecoder().decode([BeratGerbongKereta].self, from: data)
                DispatchQueue.main.async {
                    
                    print("Getting data!")
                    self?.beratKereta = beratKereta
                    print("Data receiver. Processing...")
                    print(kode_kereta)
                    
                    let currentKereta = self?.beratKereta.filter({ gerbong in
                        return gerbong.kereta_id.kereta_id == kode_kereta
                    })
                    
                    if let safeKereta = currentKereta{
                        self?.keretaToShow = safeKereta.compactMap({kereta in
                            let kondisiGerbong: CrowdStatus = {
                                switch kereta.berat_gerbong{
                                case 0:
                                    return .kosong
                                case 1...3240:
                                    return .santai
                                case 3241...7200:
                                    return .normal
                                case 7201...11339:
                                    return .ramai
                                case 11340...15000:
                                    return .penuh
                                default:
                                    return .kosong
                                }
                            }()
                            return Gerbong(nomorGerbong: kereta.nomor_gerbong, beratGerbong: kondisiGerbong)
                        })
                    }
                    self?.keretaToShow?.sort(by: {$0.nomorGerbong < $1.nomorGerbong})
                    print("Date has been processed!")
                    
                    self?.isLoading = false
                }
            }
            catch {
                print(error)
            }
        }
        
        
        task.resume()
    }
}
