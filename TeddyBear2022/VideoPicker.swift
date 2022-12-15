//
//  VideoPicker.swift
//  TeddyBear2022
//  
//  Created by テディベア on 2022/12/15
//  
//

import SwiftUI
import PhotosUI

struct PhotoLibraryMoviePickerView: UIViewControllerRepresentable {

    @Environment(\.dismiss) private var dismiss
    @Binding var movieUrl: URL?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .videos
        configuration.preferredAssetRepresentationMode = .current
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {

        let parent: PhotoLibraryMoviePickerView

        init(_ parent: PhotoLibraryMoviePickerView) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

            parent.dismiss()

            guard let provider = results.first?.itemProvider else {
                return
            }

            let typeIdentifier = UTType.movie.identifier

            if provider.hasItemConformingToTypeIdentifier(typeIdentifier) {

                provider.loadFileRepresentation(forTypeIdentifier: typeIdentifier) { url, error in
                    if let error = error {
                        print("error: \(error)")
                        return
                    }
                    if let url = url {
                        let fileName = "\(Int(Date().timeIntervalSince1970)).\(url.pathExtension)"
                        let newUrl = URL(fileURLWithPath: NSTemporaryDirectory() + fileName)
                        try? FileManager.default.copyItem(at: url, to: newUrl)
                        self.parent.movieUrl = newUrl
                    }
                }
            }
        }
    }
}
