//
//  ItemModelData.swift
//  Croid-MRT
//
//  Created by Gaizka Valencia on 17/07/23.
//

import Foundation

struct Gerbong {
    let id = UUID()
    let nomorGerbong: String
    let beratGerbong: CrowdStatus
}

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
                    self?.isLoading = false
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
    
    func loadBerat() {
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
                    print("Date received. Processing...")
                    
                    // MARK: Process received data
                    let currentKereta = self?.beratKereta.filter({ gerbong in // Get ID from kereta MRT-0012
                        return gerbong.kereta_id.kereta_id == "MRT-0012"
                    })
                    
                    if let safeKereta = currentKereta { // Nentuin CrowdStatus tiap gerbong
                        self?.keretaToShow = safeKereta.compactMap({ kereta in
                            let kondisiGerbong: CrowdStatus = {
                                switch kereta.berat_gerbong {
                                case ..<200:
                                    return .kosong
                                case 200...400:
                                    return .santai
                                default:
                                    return .normal
                                }
                            }()
                            return Gerbong(nomorGerbong: kereta.nomor_gerbong, beratGerbong: kondisiGerbong)
                        })
                    }
                    
                    self?.keretaToShow?.sort(by:{$0.nomorGerbong < $1.nomorGerbong})
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
