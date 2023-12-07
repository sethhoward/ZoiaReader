//
//  PatchView.swift
//  ZoiaReader
//
//  Created by Seth Howard on 12/6/23.
//

import SwiftUI
import ZoiaPatchReader

struct PatchView: View {
    @ObservedObject var patchModel: PatchViewModel
    
    private var patchName: String {
        patchModel.patch.patchName
    }
    
    private var pages: [Page] {
        patchModel.patch.pages
    }
    
    var body: some View {
        Text(patchName)
            .font(.largeTitle)
        
        List {
            ForEach(pages, id: \.hashValue)  { page in
                if page.number != IO_PAGE  {
                    if let name = page.name {
                        HStack {
                            Image(systemName: "doc")
                            Text(name)
                                .fontWeight(.semibold)
                                .font(.title)
                        }
                    }
                    
                    ZoiaButtonGrid(page: page)
                }
            }
        }
    }
}

#Preview {
    PatchView(patchModel: PatchViewModel(fileName: "000_zoia_slightlyrandom.bin"))
}
