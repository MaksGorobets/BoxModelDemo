//
//  ImageClassifier.swift
//  BoxModelDemo
//
//  Created by Maks Winters on 01.11.2023.
//

import SwiftUI

class ImageClassifier: ObservableObject {
    
    @Published private var classifier = Classifier()
    
    var imageClass: String? {
        classifier.results
    }
        
    // MARK: Intent(s)
    func detect(uiImage: UIImage) {
        guard let ciImage = CIImage (image: uiImage) else {
            print("Failed to convert UIImage to CIImage")
            return
        }
        print("CIImage created, initiating classification process")
        classifier.detect(ciImage: ciImage)
        
    }
        
}
