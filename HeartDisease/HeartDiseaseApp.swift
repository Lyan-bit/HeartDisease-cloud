//
//  HeartDiseaseApp.swift
//  HeartDisease
//
//  Created by Lyan Alwakeel on 08/11/2022.
//

import SwiftUI
import Firebase

@main
struct HeartDiseaseApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(model: HeartDiseaseViewModel.getInstance(), classification: ClassificationViewModel.getInstance())
        }
    }
}
