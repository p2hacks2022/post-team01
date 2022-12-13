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
                Text("中身を選ぼう")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            }
            
            // ボタン1段目
            HStack(spacing: 50){
                // 写真ボタン（写真セレクト画面へ）
                Button(action: {}, label: {
                    Image(systemName: "camera.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40.0, height: 40.0)
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.gray)
                        .padding(.all, 30)
                        .background(Color("Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                    
                })
                // 動画ボタン（動画セレクト画面へ）
                Button(action: {}, label: {
                    Image(systemName: "video.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40.0, height: 40.0)
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.gray)
                        .padding(.all, 30)
                        .background(Color("Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                    
                })
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
                        .foregroundColor(.gray)
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
                        .foregroundColor(.gray)
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
                Button(action: {}, label: {
                    Image(systemName: "envelope")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40.0, height: 40.0)
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.gray)
                        .padding(.all, 30)
                        .background(Color("Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color("Color1").opacity(0.6), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.white, radius: 5, x: -5, y: -5)
                    
                })
                // 連絡先ボタン（連絡先セレクト画面へ）
                Button(action: {}, label: {
                    Image(systemName: "doc.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40.0, height: 40.0)
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(.gray)
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
                    .frame(height: 10.0)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.gray)
                    .padding(.all, 50)
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
