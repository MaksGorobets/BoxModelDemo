//
//  ContentView.swift
//  BoxModelDemo
//
//  Created by Maks Winters on 27.10.2023.
//

import SwiftUI
import CoreML
import Vision

struct ContentView: View {
    
    @State var message = Set<String>()
    @State private var isPresenting: Bool = false
    @State private var uiImage: UIImage?
    @ObservedObject var classifier: ImageClassifier
    
    var body: some View {
        VStack {
            Spacer()
            Text("Pick an image")
                .overlay {
                    if uiImage != nil {
                        Image(uiImage: uiImage!)
                            .resizable()
                            .frame(width: 300, height: 300)
                    }
                }
            
            Spacer()
            Button("Show sheet") {
                isPresenting = true
            }
            Group {
                               if let imageClass = classifier.imageClass {
                                   HStack{
                                       Text("Image categories:")
                                           .font(.caption)
                                       Text(imageClass)
                                           .bold()
                                   }
                               } else {
                                   HStack{
                                       Text("Image categories: NA")
                                           .font(.caption)
                                   }
                               }
                           }
                           .font(.subheadline)
                           .padding()
        }
        .sheet(isPresented: $isPresenting) {
            ImagePicker(uiImage: $uiImage, isPresenting: $isPresenting)
                .onDisappear{
                    print("Image picked, initiating classification process")
                    if uiImage != nil {
                        classifier.detect(uiImage: uiImage!)
                    } else {
                        print("No image selected")
                    }
                }
        }
        .padding()
    }
}

#Preview {
    ContentView(classifier: ImageClassifier())
}
