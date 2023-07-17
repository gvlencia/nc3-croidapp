//
//  ItemModelData.swift
//  Croid-MRT
//
//  Created by Gaizka Valencia on 17/07/23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var lokasiStasiun: [LokasiStasiun] = []
    
    func loadLokasi() {
        guard let url = URL(string: "https://backend-croid-api.vercel.app/api/lokasistasiunmrt/") else {
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
}
