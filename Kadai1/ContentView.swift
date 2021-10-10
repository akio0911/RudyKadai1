//
//  ContentView.swift
//  Kadai1
//
//  Created by AkiraTANIDA on 2021/10/09.
//

import SwiftUI

struct ContentView: View {
    @State private var inputNumberTextList: [String] = Array(repeating: "", count: Self.numberOfForms)
    @State private var answerText: String = "Label"

    private static let numberOfForms: Int = 5

    var body: some View {
        ZStack {
            // 画面をタップするとキーボードを閉じる & 入力が確定する
            Color.white.opacity(0.01)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    UIApplication.shared.closeKeyboard()
                    print("tapped")
                }
            // TextField, Button, Labelを配置
            VStack(alignment: .leading, spacing: 10) {
                ForEach(0..<Self.numberOfForms) { index in
                    TextField("", text: $inputNumberTextList[index])
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                Button(action: {
                    UIApplication.shared.closeKeyboard()
                    answerText = String(inputNumberTextList.compactMap { Int($0) }.reduce(0, +))
                }, label: {
                    Text("Button")
                })
                Text(answerText)
            }.padding()
        }
    }
}
// 画面をタップするとキーボードを閉じる & 入力が確定する
extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
