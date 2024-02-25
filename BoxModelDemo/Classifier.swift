//
//  Classifier.swift
//  BoxModelDemo
//
//  Created by Maks Winters on 01.11.2023.
//

import CoreML
import Vision
import CoreImage

struct Classifier {
    
    private(set) var results: String?
    
    mutating func detect(ciImage: CIImage) {
        print("Starting classification process")
        
        guard let model = try? VNCoreMLModel(for: BoxesImageClassifier(configuration: MLModelConfiguration()).model)
        else {
            print("Model loading failed")
            return
        }
        
        let request = VNCoreMLRequest(model: model)
        
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        
        do {
            try handler.perform([request])
            if let results = request.results as? [VNClassificationObservation], let firstResult = results.first {
                self.results = firstResult.identifier
                print("Image classified as: \(firstResult.identifier)")
            } else {
                print("No classification results found")
            }
        } catch {
            print("Error in classification request: \(error)")
        }
        
    }
    
}

