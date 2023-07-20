//
//  ModelDaata.swift
//  Croid-MRT
//
//  Created by Gaizka Valencia on 17/07/23.
//

import Foundation

struct LokasiStasiun: Codable, Hashable{
    let id: Int
    let nama_stasiun: String
    let alamat_stasiun: String
}

struct KeretaMRT: Codable, Hashable{
    let id: Int
    let kereta_id: String
}

struct BeratGerbongKereta: Codable, Hashable{
    let kereta_id: KeretaMRT
    let nomor_gerbong: String
    let berat_gerbong: Int
}

struct JadwalKereta: Codable, Hashable{
    let kereta_id: KeretaMRT
    let posisi_kereta: LokasiStasiun
    let stasiun_akhir: String
    let waktu: String
}
