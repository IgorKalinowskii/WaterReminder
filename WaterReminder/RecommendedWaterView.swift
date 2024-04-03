//
//  RecommendedWaterView.swift
//  WaterReminder
//
//  Created by Wiktoria Jasińska on 03/04/2024.
//

import Foundation
import SwiftUI

struct RecommendedWaterView: View {
    // Dane wejściowe
    let recommendedWaterAmount: Double // Rekomendowane dziennie spożycie wody
    
    var body: some View {
        VStack {
            Text("Rekomendowane dzienne spożycie wody:")
                .font(.title)
                .padding()
            
            Text("\(Int(recommendedWaterAmount)) ml")
                .font(.headline)
            
            Spacer()
        }
    }
}

struct RecommendedWaterView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedWaterView(recommendedWaterAmount: 2000.0) // Przykładowa wartość dla podglądu
    }
}
