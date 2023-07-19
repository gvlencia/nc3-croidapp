//
//  InfoCard.swift
//  Croid-MRT
//
//  Created by Sae Pasomba on 20/07/23.
//

import SwiftUI

struct InfoCard: View {
    struct GateInformation {
        var tagLabel: String
        var tagIcon: String
        var tagColor: Color
        var tagLabelColor: Color
        var description: String
    }
    
    var gateNumber: String
    var crowdStatus: CrowdStatus
    var gateInformation: GateInformation {
        switch crowdStatus {
        case .kosong:
            return GateInformation(
                tagLabel: "Kosong",
                tagIcon: "door.french.open",
                tagColor: Constants.Colors.levelGreen,
                tagLabelColor: .white,
                description: "Hampir tidak ada penumpang, banyak tempat duduk yang tersedia."
            )
        case .santai:
            return GateInformation(
                tagLabel: "Santai",
                tagIcon: "door.french.open",
                tagColor: Constants.Colors.levelBlue,
                tagLabelColor: .white,
                description: "Beberapa penumpang, banyak tempat duduk kosong."
            )
        case .normal:
            return GateInformation(
                tagLabel: "Normal",
                tagIcon: "door.french.open",
                tagColor: Constants.Colors.levelYellow,
                tagLabelColor: .black,
                description: "Lebih banyak penumpang, masih ada ruang berdiri yang nyaman."
            )
        case .ramai:
            return GateInformation(
                tagLabel: "Ramai",
                tagIcon: "door.french.open",
                tagColor: Constants.Colors.levelOrange,
                tagLabelColor: .black,
                description: "Penumpang memenuhi gerbong, ruang berdiri sangat terbatas."
            )
        case .penuh:
            return GateInformation(
                tagLabel: "Penuh",
                tagIcon: "door.french.open",
                tagColor: Constants.Colors.levelRed,
                tagLabelColor: .white,
                description: "Gerbong penuh sesak, sulit untuk bergerak."
            )
        }
    }
    var isWomanGate = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(gateNumber)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                HStack(spacing: 4) {
                    Text("\(gateInformation.tagLabel)")
                    Image(systemName: "\(gateInformation.tagIcon)")
                }
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(gateInformation.tagColor)
                .cornerRadius(.infinity)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("\(gateInformation.description)")
                if isWomanGate {
                    Text("Dari jam 7.00 - 9:00, gerbong ini khusus untuk wanita")
                        .foregroundColor(.red)
                }
            }
            .font(.caption2)
        }
        .padding(8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}

struct InfoCard_Previews: PreviewProvider {
    static var previews: some View {
        InfoCard(gateNumber: "Gerbong 1", crowdStatus: .penuh)
    }
}
