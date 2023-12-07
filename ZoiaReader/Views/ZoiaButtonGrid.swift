//
//  ButtonGrid.swift
//  ZoiaLibrarian
//
//  Created by Seth Howard on 7/4/23.
//

import SwiftUI
import ZoiaPatchReader

struct ZoiaButtonGrid: View {
    // When user selects a module display some information about it.
    @State private var selectedModule: Module?
    @State var page: Page
    
    private let rows = 0..<5
    private let columns = 0..<8
    private let buttonCount = 8
    
    var body: some View {
        VStack {
            Grid {
                ForEach(rows, id: \.self) { y in
                    GridRow {
                        ForEach(columns, id: \.self) { x in
                            let position = (y * buttonCount) + x
                            
                            if let module = page.module(gridPosition: position)?.first {
                                // Only show label if it's the first block in the grid position
                                ZoiaButton(module: module, showLabel: module.gridPosition == position)
                                    .onTapGesture {
                                        selectedModule = module
                                    }
                            } else {
                                // Show default gray button
                                ZoiaButton()
                            }
                        }
                    }
                }
            }
            
            if let module = selectedModule {
                Text("\(module.detailDescription)")
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    struct AsyncView: View {
        @ObservedObject var modelData: PatchViewModel
        @State private var page: Page? = nil

        var body: some View {
            Group {
                if let page {
                    ZoiaButtonGrid(page: page)
                    .previewLayout(.sizeThatFits)
                } else {
                    Text("Preview")
                }
            }
        }
    }
    
    return AsyncView(modelData: PatchViewModel(fileName: "000_zoia_slightlyrandom"))
}
