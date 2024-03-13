//
//  ImageClassifier.swift
//  BoxModelDemo
//
//  Created by Maks Winters on 01.11.2023.
//

import SwiftUI

class ImageClassifier: ObservableObject {
    
    @Published private var classifier = Classifier()
    
    var useNewModel = true { didSet {
        classifier.modelSwitch = useNewModel
    }}
    
    var imageClass: String? {
        classifier.results
    }
    var otherResults: [String] {
        print("Called with count of: \(classifier.validResultsArray)")
        return classifier.validResultsArray
    }
    
    // MARK: Intent(s)
    func detect(uiImage: UIImage) {
        guard let ciImage = CIImage(image: uiImage) else {
            print("Failed to convert UIImage to CIImage")
            return
        }
        print("CIImage created, initiating classification process")
        classifier.detect(ciImage: ciImage)
        
    }
    
}
