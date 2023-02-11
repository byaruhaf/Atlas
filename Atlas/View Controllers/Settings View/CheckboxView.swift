//
//  CheckboxView.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 11/02/2023.
//

import SwiftUI

struct CheckboxView: View {
    let isSelected: Bool
    
    private var image: String {
        let imageName = isSelected ? "checkmark.square" : "square"
        return imageName
    }
    
    var body: some View {
        Image(systemName: image)
    }
}

struct CheckboxView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CheckboxView(isSelected: false)
            CheckboxView(isSelected: true)
        }.previewLayout(.sizeThatFits)
    }
}
