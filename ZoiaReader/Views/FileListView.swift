//
//  FileListView.swift
//  ZoiaReader
//
//  Created by Seth Howard on 12/7/23.
//

import SwiftUI

struct FileListView: View {
    @State private var files: [String] = []
    var subDirectory: String
    @Binding var patchSelection: String?
    
    // TODO: might be interesting to read just the headers of these files and get a bit more info. eg. multipage patches could use image: doc.on.doc
    @ViewBuilder
    private func row(text: String) -> some View {
        HStack {
            Image(systemName: "doc.text")
            Text("\(text)")
            
#if os(iOS)
            if UIDevice.current.userInterfaceIdiom == .phone {
                Spacer()
                Image(systemName: "chevron.right")
            }
#endif
        }
    }
    
    private func loadFileList(subDirectory: String) -> [String]? {
        guard let urls = Bundle.main.urls(forResourcesWithExtension: "bin", subdirectory: subDirectory) else { return nil }
        return urls.map { $0.lastPathComponent }.sorted { $0 < $1 }
    }
    
    var body: some View {
        List(selection: $patchSelection) {
            Section(header: Text("Euroburo")) {
                ForEach(files, id: \.self){ file in
                    row(text: file)
                }
            }
        }
        .onAppear() {
            files = loadFileList(subDirectory: subDirectory) ?? []
        }
    }
}

#Preview {
    FileListView(subDirectory: "Euroburo", patchSelection: .constant(nil))
}
