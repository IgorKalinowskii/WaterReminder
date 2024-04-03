//
//  ContentView.swift
//  WaterReminder
//
//  Created by Wiktoria Jasińska on 03/04/2024.
//

import SwiftUI

struct ContentView: View {
//    var body: some View {
//        NavigationView {
//            VStack {
//                Text("Główny widok")
//                    .padding()
//                
//                NavigationLink(destination: PersonalizationView()) {
//                    Text("Spersonalizuj cel spożycia wody")
//                }
//                .padding()
//            }
//            .navigationTitle("WaterMind")
//        }
//    }
    let waterGoalManager = WaterGoalManager()
    // Tworzymy stanowe zmienne przechowujące dane użytkownika
       @State private var weight: Double = 0
       @State private var gender: Gender = .male
       @State private var activityLevel: ActivityLevel = .sedentary
       
       var body: some View {
           NavigationView {
               VStack {
                   // Tutaj dodaj pola do wprowadzenia danych użytkownika (waga, płeć, poziom aktywności)
                   
                   Button("Zapisz") {
                       // Tutaj możemy przekazać dane użytkownika do następnego widoku
                       let recommendedWaterAmount = self.waterGoalManager.setPersonalizedWaterGoal(weight: weight, gender: gender, activityLevel: activityLevel)
                       
                       // Przechodzimy do ekranu RecommendedWaterView, przekazując rekomendowane spożycie wody
                       NavigationLink(destination: RecommendedWaterView(recommendedWaterAmount: recommendedWaterAmount)) {
                           Text("Zapisz")
                       }
                   }
               }
               .navigationTitle("Wprowadź dane")
           }
       }
}


struct ContentView_Previews: PreviewProvider {  // Definiuje podgląd (Preview) ContentView, który pozwala na podgląd widoku w Xcode.
    static var previews: some View {  // Definiuje podgląd ContentView.
        
        ContentView()  // Tworzy instancję ContentView, którą można podglądać w Xcode.
    }
}
