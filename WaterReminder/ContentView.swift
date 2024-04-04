//
//  ContentView.swift
//  WaterReminder
//
//  Created by Wiktoria Jasińska on 03/04/2024.
//

import SwiftUI

struct ContentView: View {

    @StateObject var waterGoalManager = WaterGoalManager()
    @State private var recommendedWaterAmount: Double = 0.0 // Przeniesiona definicja recommendedWaterAmount
    @State private var isNavigating = false
    
    // Tworzymy stanowe zmienne przechowujące dane użytkownika
       @State private var weight: Double = 0
       @State private var gender: Gender = .male
       @State private var activityLevel: ActivityLevel = .sedentary
       
    var body: some View {
        VStack {
            Text("Content View")
                .padding()
            
            Button("Zapisz") {
                // Ustawianie recommendedWaterAmount
                let recommendedWaterAmount = self.waterGoalManager.personalizedWaterGoal.targetAmount
                self.isNavigating = true
            }
            .sheet(isPresented: $isNavigating) {
                RecommendedWaterView(recommendedWaterAmount: recommendedWaterAmount)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {  // Definiuje podgląd (Preview) ContentView, który pozwala na podgląd widoku w Xcode.
    static var previews: some View {  // Definiuje podgląd ContentView.
        
        ContentView()  // Tworzy instancję ContentView, którą można podglądać w Xcode.
    }
}
