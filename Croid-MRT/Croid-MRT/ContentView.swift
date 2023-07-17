//
//  ContentView.swift
//  Croid-MRT
//
//  Created by Gaizka Valencia on 17/07/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State private var item: Int = 1
    
    var body: some View {
        NavigationView{
            VStack(){
                Spacer()
                Picker("Stasiun",selection: $item){
                    ForEach(viewModel.lokasiStasiun, id:\.self){item in
                        Text("\(item.nama_stasiun)")
                    }
                }.pickerStyle(.wheel)
                    .task{
                        viewModel.loadLokasi()
                    }
                    .padding()
                Spacer()
                CustomButton(text: "Cek Kepadatan Gerbong", action: {print("")}, isBordered: false)
                    .padding()
            }
            .navigationTitle("Pilih Stasiun Anda")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
