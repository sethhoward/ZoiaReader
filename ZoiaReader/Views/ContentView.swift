//
//  ContentView.swift
//  ZoiaReader
//
//  Created by Seth Howard on 12/5/23.
//

import SwiftUI
import ZoiaPatchReader

struct ContentView: View {
    @State private var patchSelection: String? = nil
    @State private var columnVisibility =
    NavigationSplitViewVisibility.all
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            FileListView(subDirectory: "Euroburo", patchSelection: $patchSelection)
        } detail: {
            if let patchSelection {
                VStack {
                    PatchView(patchModel: PatchViewModel(fileName: patchSelection))
                }
            } else {
                HStack {
                    Image(systemName: "arrowshape.left")
                    Text("Select a Patch")
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
