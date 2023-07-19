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
    @State var selectedTab = 1
    
    var body: some View {
        VStack {
            // MARK: PICKER
            Picker("Pilih tujuan akhir", selection: $selectedTab) {
                Text("Dukuh Atas BNI").tag(0)
                Text("Bundaran HI").tag(1)
            }
            .pickerStyle(.segmented)
            
            switch selectedTab {
            case 0:
                LeftTrainTab()
            case 1:
                RightTrainTab()
            default:
                EmptyView()
            }
        }
    }
}

struct TrainInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TrainInfoView()
    }
}
