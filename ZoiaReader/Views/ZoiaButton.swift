//
//  ButtonItem.swift
//  ZoiaLibrarian
//
//  Created by Seth Howard on 7/4/23.
//

import SwiftUI
import ZoiaPatchReader

struct ZoiaButton: View {
    var module: Module? = nil
    var showLabel: Bool = true
    
    private var name: String? {
        guard let module else { return nil }
        
        return module.customName ?? module.name
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
            .stroke(.gray, lineWidth: 5)
            .fill(Color(module?.color.value ?? .gray))
            .scaledToFit()

            if let name, showLabel {
                Text(name)
                .foregroundColor(.black)
                .padding(3)
                .background(
                    Rectangle()
                        .foregroundColor(Color(.white).opacity(0.5))
                        .cornerRadius(5)
                )
            }
        }
    }
}

#Preview {
    ZoiaButton(module: ZoiaPatch.mockModule())
}
