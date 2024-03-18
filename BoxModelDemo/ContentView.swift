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
        GeometryReader { proxy in
            VStack {
                Spacer()
                if uiImage != nil {
                    Image(uiImage: uiImage!)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: proxy.size.width * 0.8)
                } else {
                    Text("Pick an image")
                }
                Spacer()
                Toggle("Use new model?", isOn: $classifier.useNewModel)
                    .onChange(of: classifier.useNewModel) {
                        if uiImage != nil {
                            classifier.detect(uiImage: uiImage!)
                        }
                    }
                HStack {
                    Image(systemName: "wand.and.stars.inverse")
                    Text("Suggested")
                }
                .font(.subheadline)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(classifier.otherResults, id: \.self) { result in
                            Text(result)
                                .foregroundStyle(.white)
                                .padding(10)
                                .background(
                                    Capsule()
                                        .fill(LinearGradient(colors: [.blue, .red], startPoint: .leading, endPoint: .trailing))
                                )
                        }
                    }
                    .padding()
                }
                Button("Show sheet") {
                    isPresenting = true
                }
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
}

#Preview {
    ContentView(classifier: ImageClassifier())
}
