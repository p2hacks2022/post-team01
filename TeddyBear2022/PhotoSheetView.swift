//
//  PhotoSheetView.swift
//  TeddyBear2022
//  
//  Created by テディベア on 2022/12/14
//  
//

import SwiftUI
import PhotosUI
//import ImagePicker

struct SheetView: View {
    @ObservedObject var photoModel : PhotoModel
    @Environment(\.managedObjectContext)private var context
//カメラロールを開閉スイッチにするBool値
    @State private var isPicking: Bool = false
//選択した写真を入れる配列
    @State private var images: [Data] = []
//PHPickerの設定
    var pickerConfig: PHPickerConfiguration {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images // 静止画写真のみ選択
        config.preferredAssetRepresentationMode = .current
        config.selectionLimit = 0 // 選択する枚数の上限
        return config
    }
//
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Button("Cansel", action:{
                    photoModel.isNewData = false
                }).foregroundColor(.blue)
                Spacer()
                Button("Save", action:
                        {
                            photoModel.writeData(context: context)
                            
                        }
                ).foregroundColor(.blue)
                
            }
            .padding(.bottom, 20.0)
            
            HStack {
                DatePicker("", selection: $photoModel.date, displayedComponents: .date)
                    .labelsHidden()
                Button(action: {photoModel.bool.toggle()}){
                    Image(systemName: photoModel.bool ? "star.fill":"star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30.0, height: 30.0)
                }.padding()
//isPickingをtoggleしてモダールでカメラロールを開く
                Button(action: {self.isPicking.toggle()}){
                    Image(systemName: "camera.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30.0, height: 30.0)
                    .foregroundColor(.blue)
                }
                .padding()
                .fullScreenCover(isPresented: $isPicking){ImagePicker(
                          configuration: pickerConfig,
                          completion: {result in },
                          isPicking: $isPicking,
                          images: $images)
                }
//
            }
            
//            TextField("入力できます", text: $sampleModel.text).textFieldStyle(RoundedBorderTextFieldStyle())
            //カメラロールから選択されたimages配列の中の写真を表示する
            //images配列の写真データの枚数によって表示を切り替えます
            // 別記事を見て一覧で並べる
            
                switch images.count {
                //1枚の場合
                    case 1:
                        HStack {
                            Image(uiImage: UIImage(data: images[0]) ?? UIImage(systemName: "photo")!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height:150, alignment: .center)
                                .border(Color.gray)
                                .clipped()
                            
                            Spacer()
                        }
            //選択した画像が表示された時点でCoreDataモデルに代入する
                        .onAppear(){
                            photoModel.image1 = images[0]
                            photoModel.image2 = Data.init()
                        }
                //2枚の場合
                    case 2:
                        HStack{
                            Image(uiImage: UIImage(data: images[0]) ?? UIImage(systemName: "photo")!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150, alignment: .center)
                                .border(Color.gray)
                                .clipped()
                            Image(uiImage: UIImage(data: images[1]) ?? UIImage(systemName: "photo")!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150, alignment: .center)
                                .border(Color.gray)
                                .clipped()
                            Spacer()
                        }.onAppear(){
                            photoModel.image1 = images[0]
                            photoModel.image2 = images[1]
                        }
                //0枚の場合か,編集で開いたシートの場合
                    default:
                        HStack{
                            Image(uiImage: UIImage(data: photoModel.image1) ?? UIImage(systemName: "person.crop.square")!)
                               .resizable()
                               .scaledToFill()
                               .frame(width: 150, height: 150, alignment: .center)
                               .clipped()
                               .opacity(0.5)
                            Image(uiImage: UIImage(data: photoModel.image2) ?? UIImage(systemName: "person.crop.square")!)
                               .resizable()
                               .scaledToFill()
                               .frame(width: 150, height: 150, alignment: .center)
                               .clipped()
                               .opacity(0.5)
                            Spacer()
                        }
            //
                }
        Spacer()
        }.padding()
    }
}
//プレビュー用コード
struct PhotoSheetView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoSheetView(sampleModel: SampleModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
