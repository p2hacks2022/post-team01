//
//  ImageView.swift
//  TeddyBear2022
//  
//  Created by テディベア on 2022/12/14
//  
//  写真を選択するView

import SwiftUI
import PhotosUI
import os
import SwiftUIPHPicker

struct ImageView: View {
    @State var images: [UIImage] = [] // 写真を入れる配列
    @State private var showPHPicker:Bool = false
    @Environment(\.dismiss) var dismiss
    
    static var config: PHPickerConfiguration {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 0
        return config
    }
    let logger = Logger(subsystem: "com.smalldesksoftware.PHPickerSample", category: "PHPickerSample")
    var columns: [GridItem] = Array(repeating: .init(.fixed(100), spacing: 15), count: 3) // 3列表示
    
    var body: some View {
        VStack {
            
            ZStack{
                // メニュー
                HStack {
                    // リセットボタン
                    Button(action: {
                        images = []
                    }, label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.gray)
                            .padding(.all, 20)
                            .background(Color("Color"))
                            .clipShape(Circle())
                        // ニューモーフィズムエフェクト
                            .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                            .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                    })
                    Spacer()
                    
                    // 写真追加ボタン
                    Button(action: {
                        showPHPicker.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.gray)
                            .padding(.all, 20)
                            .background(Color("Color"))
                            .clipShape(Circle())
                        // ニューモーフィズムエフェクト
                            .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                            .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                        
                    })
                }
                Text("思い出の写真")
                    .fontWeight(.bold)
                    .foregroundColor(Color("Color2"))
            }
            .padding()
            Divider()
            
            // 選択された写真一覧
            ScrollView{
                LazyVGrid(columns: columns) {
                    ForEach(images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 95, height: 95)
                            .clipShape(Circle())
                            .padding(.all, 5)
                            .background(Color("Color").opacity(0.6))
                            .clipShape(Circle())
                            .shadow(color: Color("Color1").opacity(0.3), radius: 5, x: 5, y: 5)
                            .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                    }
                }
            }
            Divider()
            //.padding()
            Spacer()
            Spacer()
            
            // 決定ボタン（カプセル画面へ）
            Button(action: {dismiss()}, label: {
                Text("決定")
                    .frame(width: 200)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color("Color2"))
                    .padding(.all, 25)
                    .background(Color("Color"))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.white, radius: 5, x: -5, y: -5)
            })
        }
        .sheet(isPresented: $showPHPicker) {
            SwiftUIPHPicker(configuration: ImageView.config) { results in
                for result in results {
                    let itemProvider = result.itemProvider
                    if itemProvider.canLoadObject(ofClass: UIImage.self) {
                        itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                            if let image = image as? UIImage {
                                DispatchQueue.main.async {
                                    self.images.append(image)
                                }
                            }
                            if let error = error {
                                logger.error("\(error.localizedDescription)")
                            }
                        }
                    }
                }
            }
        }
        .padding(.all)
        .background(Color("Color").edgesIgnoringSafeArea(.all))
    }
    
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
