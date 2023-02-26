//
//  ContentView.swift
//  myOkashi
//
//  Created by 赤荻大輝 on 2023/02/14.
//

import SwiftUI

struct ContentView: View {
    @StateObject var movieDataList = MovieData()
    @State var inputText = ""
    @State var showSafari = false
    
    var body: some View {
        VStack {
            TextField("キ-ワード", text:$inputText, prompt: Text("キーワードを入力してください"))
                .onSubmit {
                    movieDataList.searchMovie(keyword: inputText)
                }
                .submitLabel(.search)
                .padding()
            
            List(movieDataList.okashiList) { okashi in
                Button {
                    movieDataList.okashiLink = okashi.link
                    showSafari.toggle()
                } label: {
                    HStack {
                        AsyncImage(url: okashi.image) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(okashi.name)
                    }
                }
            }
            .sheet(isPresented: $showSafari, content: {
                SafariView(url: movieDataList.okashiLink!)
                    .ignoresSafeArea(edges:[.bottom])
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
