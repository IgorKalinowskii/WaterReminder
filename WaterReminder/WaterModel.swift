//
//  WaterModel.swift
//  WaterReminder
//
//  Created by Wiktoria Jasińska on 03/04/2024.
//

import Foundation
import SwiftUI

// Model reprezentujący cel spożycia wody
struct WaterGoal {
    var targetAmount: Int // Celowa ilość wypitej wody w ml
}

// Klasa zarządzająca ustawianiem celu spożycia wody
class WaterGoalManager: ObservableObject{
        
        // Metoda do ustawiania celu spożycia wody
        func setWaterGoal(amount: Int) {
            // Zapisz cel spożycia wody do UserDefaults
            UserDefaults.standard.set(amount, forKey: "WaterGoalAmount")
        }
        
        // Metoda do pobierania zapisanego celu spożycia wody
        func getWaterGoal() -> Int {
            // Pobierz cel spożycia wody z UserDefaults lub zwróć domyślną wartość (2000 ml)
            return UserDefaults.standard.integer(forKey: "WaterGoalAmount")
        }
    
        // Zdefiniuj instancję PersonalizedWaterGoal, aby była dostępna w innych częściach kodu
        var personalizedWaterGoal = PersonalizedWaterGoal(targetAmount: 0.0)
    
        struct PersonalizedWaterGoal {
        var targetAmount: Double
        }
    
        func setPersonalizedWaterGoal(weight: Double, gender: Gender, activityLevel: ActivityLevel) -> PersonalizedWaterGoal {
           // Obliczanie spersonalizowanego celu spożycia wody na podstawie danych użytkownika
           var baseWaterIntake: Double
           
           // Obliczanie podstawowego spożycia wody na podstawie wagi
           if weight >= 45 && weight <= 59 {
               baseWaterIntake = 1500 // ml/dzień
           } else if weight >= 60 && weight <= 74 {
               baseWaterIntake = 2000
           } else if weight >= 75 && weight <= 89 {
               baseWaterIntake = 2500
           } else if weight >= 90 && weight <= 104 {
               baseWaterIntake = 3000
           } else if weight >= 105 && weight <= 119 {
               baseWaterIntake = 3500
           } else if weight >= 120 && weight <= 134 {
               baseWaterIntake = 4000
           } else if weight >= 135 && weight <= 150 {
               baseWaterIntake = 4500
           } else {
               baseWaterIntake = 0
           }
           
           // Mnożenie podstawowej wartości spożycia wody przez współczynniki związane z płcią i poziomem aktywności
           var personalizedGoal: Double
           switch gender {
           case .male:
               personalizedGoal = baseWaterIntake * Double(activityLevel.rawValue)
           case .female:
               personalizedGoal = (baseWaterIntake - 200) * Double(activityLevel.rawValue)
           }
           
           // Tworzenie i zwracanie struktury PersonalizedWaterGoal z obliczonym celem spożycia wody
           return PersonalizedWaterGoal(targetAmount: personalizedGoal)
       }
       
       // Oblicz bazową ilość wypitej wody na podstawie wagi
       private func calculateBaseWaterAmount(weight: Double) -> Int {
           // Oblicz bazową ilość wypitej wody, np. 30 ml na kg masy ciała
           return Int(weight * 30)
       }
       
       // Dostosuj bazową ilość wypitej wody na podstawie płci
       private func adjustForGender(baseAmount: Int, gender: Gender) -> Int {
           // Jeśli płeć to kobieta, zmniejsz bazową ilość o określoną wartość
           if gender == .female {
               return Int(Double(baseAmount) * 0.9)
           } else {
               return baseAmount
           }
       }
       
       // Dostosuj ilość wypitej wody na podstawie aktywności fizycznej
       private func adjustForActivityLevel(baseAmount: Int, activityLevel: ActivityLevel) -> Int {
           // W zależności od poziomu aktywności, dostosuj ilość wypitej wody
           switch activityLevel {
           case .sedentary:
               return baseAmount
           case .moderate:
               return Int(Double(baseAmount) * 1.1)
           case .active:
               return Int(Double(baseAmount) * 1.3)
           }
       }
   }

   // Enum do reprezentowania płci użytkownika
   enum Gender {
       case male
       case female
   }

   // Enum do reprezentowania poziomu aktywności fizycznej użytkownika
    enum ActivityLevel: Int {
       case sedentary = 1
       case moderate = 2
       case active = 3
    }

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
