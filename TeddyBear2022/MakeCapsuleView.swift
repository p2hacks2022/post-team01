//
//  MakeCapsuleView.swift
//  TeddyBear2022
//
//  Created by 姜南圭 on 2022/12/13.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct MakeCapsuleView: View {
    @State private var isShowingIView: Bool = false // 画面遷移用
    @State private var isShowingVView: Bool = false
    @State private var isShowingTView: Bool = false
    
    var body: some View {
        
        // 全体
        VStack(spacing: 40){
            
            ZStack{
                // メニュー
                HStack{
                    // 戻るボタン（トップ画面へ）
                    Button(action: {}, label: {
                        Image(systemName: "arrow.left")
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
                }
                Text("思い出を詰めよう")
                    .fontWeight(.bold)
                    .foregroundColor(Color("Color2"))
            }
            
            // ボタン1段目
            HStack(spacing: 50){
                // 写真ボタン（写真セレクト画面へ）
                Button(action: {isShowingIView.toggle()}, label: {
                    Image(systemName: "camera.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40.0, height: 40.0)
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(Color("Color2"))
                        .padding(.all, 30)
                        .background(Color("Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                    
                })
                .sheet(isPresented: $isShowingIView) {
                    ImageView()
                }
                // 動画ボタン（動画セレクト画面へ）
                Button(action: {isShowingVView.toggle()}, label: {
                    Image(systemName: "video.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40.0, height: 40.0)
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(Color("Color2"))
                        .padding(.all, 30)
                        .background(Color("Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                    
                })
                .sheet(isPresented: $isShowingVView) {
                    VideoView()
                }
            }
            
            // ボタン2段目
            HStack(spacing: 50){
                // 音楽ボタン（音楽セレクト画面へ）
                Button(action: {}, label: {
                    Image(systemName: "headphones")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40.0, height: 40.0)
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(Color("Color2"))
                        .padding(.all, 30)
                        .background(Color("Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                    
                })
                // 連絡先ボタン（連絡先セレクト画面へ）
                Button(action: {}, label: {
                    Image(systemName: "person.2.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40.0, height: 40.0)
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(Color("Color2"))
                        .padding(.all, 30)
                        .background(Color("Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                    
                })
            }
            
            // ボタン3段目
            HStack(spacing: 50){
                // テキストボタン（テキスト入力画面へ）
                Button(action: {isShowingTView.toggle()}, label: {
                    Image(systemName: "envelope")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40.0, height: 40.0)
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(Color("Color2"))
                        .padding(.all, 30)
                        .background(Color("Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                    
                })
                .sheet(isPresented: $isShowingTView) {
                    LetterView()
                }
                // 連絡先ボタン（連絡先セレクト画面へ）
                Button(action: {}, label: {
                    Image(systemName: "doc.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40.0, height: 40.0)
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(Color("Color2"))
                        .padding(.all, 30)
                        .background(Color("Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                    
                })
            }
            Spacer()
            
            Button(action: {}, label: {
                Text("いれる")
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
        .padding(.all)
        .background(Color("Color").edgesIgnoringSafeArea(.all))
    }
    
    struct MakeCapsuleView_Previews: PreviewProvider {
        static var previews: some View {
            MakeCapsuleView()
        }
    }
}
