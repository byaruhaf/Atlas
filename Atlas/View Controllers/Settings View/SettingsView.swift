//
//  SettingsView.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 03/02/2023.
//

import SwiftUI

struct SettingsView: View {
    
    enum ImageScheme: String {
        case forest, sea
    }
    
    @State private var imageScheme: ImageScheme = .forest
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Themes") {
                    Picker("Image Themes", selection: $imageScheme) {
                        Text("Forest").tag(ImageScheme.forest)
                        Text("Sea").tag(ImageScheme.sea)
                    }
                }
            }.navigationTitle("Settings")
                .onChange(of: imageScheme) { newValue in
                    switch newValue {
                    case .forest:
                        // Default ColorTheme
                        ThemeManager.shared.set(imageTheme: ForestImageTheme())
                    case .sea:
                        // Default ColorTheme
                        ThemeManager.shared.set(imageTheme: SeaImageTheme())
                    }
                }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
