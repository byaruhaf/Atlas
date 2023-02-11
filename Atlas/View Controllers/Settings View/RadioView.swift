//
//  RadioView.swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 11/02/2023.
//

import SwiftUI

struct RadioView: View {
    let isSelected: Bool
    
    private var image: String {
        let imageName = isSelected ? "dot.circle" : "circle"
        return imageName
    }
    
    var body: some View {
        Image(systemName: image)
            .foregroundColor(Color.blue)
            .fontWeight(.bold)
    }
}

struct RadioView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RadioView(isSelected: false)
            RadioView(isSelected: true)
        }.previewLayout(.sizeThatFits)
    }
}
