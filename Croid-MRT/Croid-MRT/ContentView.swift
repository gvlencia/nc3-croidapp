//
//  ContentView.swift
//  Croid-MRT
//
//  Created by Gaizka Valencia on 17/07/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showModal = false
    @StateObject var viewModel = ViewModel()
    @State private var nama_stasiun: String = "Lebak Bulus Grab"
    @State private var stasiun_akhir: String = "Bundaran HI"
    @State private var isOnStasiun: Bool = false
    @State private var isOnTujuan: Bool = false
    let stasiun = ["Lebak Bulus Grab", "Bundaran HI"]
    
    var body: some View {
        NavigationView{
            VStack(){
                Spacer()
                if viewModel.lokasiStasiun.isEmpty {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(3)
                } else {
                    Form{
                        HStack{
                            Text("Stasiun")
                            Spacer()
                            Button(action:{
                                isOnStasiun.toggle()
                            }){
                                Text(nama_stasiun)
                                    .foregroundColor(Color.black)
                            }
                            .buttonBorderShape(.roundedRectangle)
                            .buttonStyle(.bordered)
                            
                        }
                        if isOnStasiun{
                            Picker("Stasiun",selection: $nama_stasiun) {
                                ForEach(viewModel.lokasiStasiun.filter({$0.nama_stasiun != stasiun_akhir}), id:\.self){item in
                                    Text("\(item.nama_stasiun)").tag(item.nama_stasiun)
                                }
                            }.pickerStyle(WheelPickerStyle())
                        }
                        Picker("Stasiun Akhir", selection: $stasiun_akhir){
                            ForEach(stasiun, id:\.self){
                                Text($0)
                            }
                        }
                        
                        
//                        if isOnTujuan{
//                            Picker("",selection: $stasiun_akhir) {
//                                ForEach(stasiun.filter($0.stasiun != stasiun_akhir), id:\.self){
//                                    Text($0)
//                                }
//                            }.pickerStyle(WheelPickerStyle())
//                        }
                    }
                    
                    .scrollContentBackground(.hidden)
                }
                
                Spacer()
                CustomButton(text: "Cek Kepadatan Gerbong", action: {showModal.toggle()}, isBordered: false)
                    .padding()
                NavigationLink("", destination: DetailCrowdKereta(nama_stasiun: nama_stasiun, stasiun_akhir: stasiun_akhir), isActive: $showModal)
                
            }
            .background(Color.gray.opacity(0.1))
            .task{
                viewModel.loadLokasi()
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
