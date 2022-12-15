//
//  VideoView.swift
//  TeddyBear2022
//
//  Created by テディベア on 2022/12/15
//
//
//
import SwiftUI
import AVFoundation

struct VideoView: View {
    @State private var movieUrl: URL?
    //    @State var videos: [URL] = []
    @State var image: UIImage = UIImage(imageLiteralResourceName: "background")
    @State private var showPhotoLibraryMoviePickerView = false
    @State private var showMoviePlayerView = false
    @Environment(\.dismiss) var dismiss
    
    private var canPlayVideo: Bool {
        movieUrl != nil
    }
    var columns: [GridItem] = Array(repeating: .init(.fixed(100), spacing: 15), count: 3) // 3列表示
    
    var body: some View {
        VStack{
            ZStack{
                // メニュー
                HStack {
                    // リセットボタン
                    Button(action: {
                        image = UIImage(imageLiteralResourceName: "background")
                        image = thumnailImageForFileUrl(fileUrl: movieUrl!)!
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
                    
                    // 動画追加ボタン
                    Button(action: {
                        showPhotoLibraryMoviePickerView = true
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
                Text("思い出の動画")
                    .fontWeight(.bold)
                    .foregroundColor(Color("Color2"))
            }
            .padding()
            
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 300)
                .clipShape(Circle())
                .padding(.all, 10)
                .background(Color("Color").opacity(0.6))
                .clipShape(Circle())
            // ニューモーフィズムエフェクト
                .shadow(color: Color("Color1").opacity(0.3), radius: 8, x: 8, y: 8)
                .shadow(color: Color.white, radius: 10, x: -10, y: -10)
            
            // 選択された写真一覧
            //            ScrollView{
            //                LazyVGrid(columns: columns) {
            //                    ForEach(videos, id: \.self) { image in
            //                        Image(uiImage: image)
            //                            .resizable()
            //                            .scaledToFill()
            //                            .frame(width: 95, height: 95)
            //                            .clipShape(Circle())
            //                            .padding(.all, 5)
            //                            .background(Color("Color").opacity(0.6))
            //                            .clipShape(Circle())
            //                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
            //                            .shadow(color: Color.white, radius: 5, x: -5, y: -5)
            //                    }
            //                }
            //            }
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
        .sheet(isPresented: $showPhotoLibraryMoviePickerView) {
            PhotoLibraryMoviePickerView(movieUrl: $movieUrl)
        }
        .padding(.all)
        .background(Color("Color").edgesIgnoringSafeArea(.all))
    }
}

func thumnailImageForFileUrl(fileUrl: URL) -> UIImage? {
    let asset = AVAsset(url: fileUrl)
    
    let imageGenerator = AVAssetImageGenerator(asset: asset)
    
    do {
        let thumnailCGImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1,timescale: 60), actualTime: nil)
        print("サムネイルの切り取り成功！")
        return UIImage(cgImage: thumnailCGImage, scale: 0, orientation: .right)
    }catch let err{
        print("エラー\(err)")
    }
    return nil
}

struct ViedoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}

