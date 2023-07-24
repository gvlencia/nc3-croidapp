//
//  ContentView.swift
//  Croid-MRT
//
//  Created by Gaizka Valencia on 17/07/23.
//

import SwiftUI

struct ContentView: View {
    @State var isOnboardingCompleted = false
    @State private var showModal = false
    @StateObject var viewModel = ViewModel()
    @State private var nama_stasiun: String = "Blok M BCA"
    @State private var stasiun_akhir: String = "Bundaran HI"
    @State private var isOnStasiun: Bool = false
    @State private var isOnTujuan: Bool = false
    @State private var kode_kereta: String? = "MRT-0001"
    let stasiun = ["Lebak Bulus Grab", "Bundaran HI"]
    
    var body: some View {
        if isOnboardingCompleted{
            NavigationView{
                VStack(){
                    Spacer()
                    if viewModel.lokasiStasiun.isEmpty {
                        ProgressView()
                    } else {
                        Form {
                            Section {
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
                            }
                                
                            Section {
                                Picker("Stasiun Akhir", selection: $stasiun_akhir){
                                    ForEach(stasiun, id:\.self){
                                        Text($0)
                                    }
                                }
                            }
                        }
                        
                        .scrollContentBackground(.hidden)
                    }
                    
                    Spacer()
                    CustomButton(text: "Cek Kepadatan Gerbong", action: {
                        showModal.toggle()
                        kode_kereta = viewModel.jadwalKereta.filter( { $0.posisi_kereta.nama_stasiun == nama_stasiun && ($0.waktu >= getCurrentTime()) && $0.stasiun_akhir == stasiun_akhir}).first?.kereta_id.kereta_id
                        print(kode_kereta)
                    }, isBordered: false)
                        .padding()
                    NavigationLink("", destination: TrainInfoView(nama_stasiun: nama_stasiun, stasiun_akhir: stasiun_akhir, kode_kereta: kode_kereta), isActive: $showModal)
//                    NavigationLink("", destination: DetailCrowdKereta(nama_stasiun: nama_stasiun, stasiun_akhir: stasiun_akhir), isActive: $showModal)
                }
                .background(Color.gray.opacity(0.1))
                .task{
                    viewModel.loadLokasi()
                    viewModel.loadJadwal()
                }
                .navigationTitle("Pilih Stasiun Anda")
                
            }
        }
        else{
            WelcomePageView(isOnboardingCompleted: $isOnboardingCompleted)
        }
    }
    func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let currentTime = Date()
        let formattedTime = dateFormatter.string(from: currentTime)
        return formattedTime
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
