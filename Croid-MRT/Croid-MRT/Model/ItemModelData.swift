//
//  ItemModelData.swift
//  Croid-MRT
//
//  Created by Gaizka Valencia on 17/07/23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var lokasiStasiun: [LokasiStasiun] = []
    @Published var jadwalKereta: [JadwalKereta] = []
    @Published var beratKereta: [BeratGerbongKereta] = []
    
    func loadLokasi() {
//        guard let url = URL(string: "https://backend-croid-api.vercel.app/api/lokasistasiunmrt/") else {
//            return
//        }
        
        guard let url = URL(string: "http://127.0.0.1:8000/api/lokasistasiunmrt/") else {
            return
        }
        
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
//        guard let url = URL(string: "https://backend-croid-api.vercel.app/api/jadwalkereta/") else {
//            return
//        }
        
        guard let url = URL(string: "http://127.0.0.1:8000/api/jadwalkereta/") else {
            return
        }
        
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
//        guard let url = URL(string: "https://backend-croid-api.vercel.app/api/beratgerbongkereta/") else {
//            return
//        }
        guard let url = URL(string: "http://127.0.0.1:8000/api/beratgerbongkereta/") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak
            self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let beratKereta = try JSONDecoder().decode([BeratGerbongKereta].self, from: data)
                DispatchQueue.main.async {
                    self?.beratKereta = beratKereta
                }
            }
            catch {
                print(error)
            }
        }
        
        
        task.resume()
    }
}
