//
//  PatchViewModel.swift
//  ZoiaReader
//
//  Created by Seth Howard on 12/7/23.
//

import Foundation
import ZoiaPatchReader

enum ZoiaReaderError: Error {
    case fileURLNotFound
}

@MainActor
class PatchViewModel: ObservableObject {
    @Published var patch: ZoiaPatch = ZoiaPatch.emptyPatch()
    var fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
        Task.detached {
            try? await self.load(name:fileName, subdirectory: "Euroburo")
        }
    }
    
    private func load(name: String, subdirectory: String? = nil) async throws {
        do {
            guard let url = Bundle.main.url(forResource: name, withExtension: nil, subdirectory: subdirectory) else {
                throw ZoiaReaderError.fileURLNotFound
            }
            let reader = try ZoiaFileReader(fileURL: url)
            patch = try await reader.read()
        } catch {
            throw error
        }
    }
}
