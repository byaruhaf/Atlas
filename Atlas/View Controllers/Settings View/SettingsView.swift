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
    @AppStorage("temperatureNotation") var temperatureNotation: TemperatureNotation = .celsius
    
    var body: some View {
        NavigationStack {
                Form {
                    Section {
                        Picker("Image", selection: $imageScheme) {
                            Text("🌴 Forest").tag(ImageScheme.forest)
                            Text("🌊 Sea").tag(ImageScheme.sea)
                        }
                    } header: {
                        Text("Themes")
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                    Section {
                        Picker("Unit", selection: $temperatureNotation) {
                            Text("°C").tag(TemperatureNotation.celsius)
                            Text("°F").tag(TemperatureNotation.fahrenheit)
                        }
                    } header: {
                        Text("Temperature")
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                    Section {
                        ForEach(AppIcon.allCases) { appIcon in
                            HStack(spacing: 16) {
                                Image(uiImage: appIcon.preview)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(12)
                                Text(appIcon.description)
                                Spacer()
                                RadioView(isSelected: viewModel.selectedAppIcon == appIcon)
                            }.onTapGesture {
                                withAnimation {
                                    viewModel.updateAppIcon(to: appIcon)
                                }
                            }
                        }
                    } header: {
                        Text("App Icon")
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                }
                .background(Color(uiColor: ThemeManager.shared.currentBackgroundColor!.backgroundColor))
                .scrollContentBackground(.hidden)
                .navigationTitle("Settings")
                .preferredColorScheme(.dark)
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
