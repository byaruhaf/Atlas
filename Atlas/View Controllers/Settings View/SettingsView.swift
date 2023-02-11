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
    
    @State private var bgColor: Color = .white
    @State private var imageScheme: ImageScheme = .forest
    @StateObject var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
                Form {
                    Section("Themes") {
                        Picker("Image Themes", selection: $imageScheme) {
                            Text("🌴 Forest").tag(ImageScheme.forest)
                            Text("🌊 Sea").tag(ImageScheme.sea)
                        }
                    }
                    Section("App Icon") {
                        ForEach(AppIcon.allCases) { appIcon in
                            HStack(spacing: 16) {
                                Image(uiImage: appIcon.preview)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(12)
                                Text(appIcon.description)
                                Spacer()
                                CheckboxView(isSelected: viewModel.selectedAppIcon == appIcon)
                            }.onTapGesture {
                                withAnimation {
                                    viewModel.updateAppIcon(to: appIcon)
                                }
                            }
                        }
                    }
                }
                .background(Color(uiColor: ThemeManager.shared.currentBackgroundColor!.backgroundColor))
                .scrollContentBackground(.hidden)
                .navigationTitle("Settings")
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
