//
//  PersonalizationView.swift
//  WaterReminder
//
//  Created by Wiktoria Jasińska on 03/04/2024.
//

import Foundation

struct PersonalizationView: View {
    @State private var weight: String = ""
    @State private var selectedGender: Gender = .male
    @State private var selectedActivityLevel: ActivityLevel = .sedentary
    @State private var isGoalSet: Bool = false
    
    var body: some View {
        VStack {
            TextField("Waga (kg)", text: $weight)
                .padding()
            
            Picker("Płeć", selection: $selectedGender) {
                Text("Mężczyzna").tag(Gender.male)
                Text("Kobieta").tag(Gender.female)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Picker("Poziom aktywności", selection: $selectedActivityLevel) {
                Text("Siedzący").tag(ActivityLevel.sedentary)
                Text("Średni").tag(ActivityLevel.moderate)
                Text("Aktywny").tag(ActivityLevel.active)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Button("Zapisz") {
                savePersonalData()
            }
            .padding()
            
            if isGoalSet {
                Text("Spersonalizowany cel został ustawiony!")
            }
        }
        .padding()
    }
    
    func savePersonalData() {
        guard let weight = Double(weight) else {
            return // obsługa błędu
        }
        
        // Przekazujemy dane do WaterGoalManager i ustawiamy spersonalizowany cel
        let waterGoalManager = WaterGoalManager()
        let personalizedGoal = waterGoalManager.setPersonalizedWaterGoal(weight: weight, gender: selectedGender, activityLevel: selectedActivityLevel)
        
        // Zapisujemy cel do pamięci urządzenia, aby był dostępny w aplikacji
        UserDefaults.standard.set(personalizedGoal.targetAmount, forKey: "PersonalizedWaterGoal")
        
        // Oznaczamy, że cel został ustawiony
        isGoalSet = true
    }
}
