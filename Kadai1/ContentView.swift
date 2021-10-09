//
//  ContentView.swift
//  Kadai1
//
//  Created by AkiraTANIDA on 2021/10/09.
//

import SwiftUI
let numOfForms: Int = 5

struct ContentView: View {
    @State private var inputNums: [Int] = Array(repeating: 0, count: numOfForms)
    @State private var ans: String = "Label"
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
                ForEach(0..<5) {index in
                    TextField("input num",
                              value: $inputNums[index],
                              formatter: NumberFormatter())
                        .onReceive(
                                NotificationCenter.default.publisher(for: UITextField.textDidEndEditingNotification),
                                perform: textDidEndEditing)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                Button(action: {
                    UIApplication.shared.closeKeyboard()
                    self.ans = String(inputNums.reduce(0, +))
                }, label: {
                    Text("Button")
                })
                Text(self.ans)
            }.padding()
        }
    }
    // returnを押さなくても値を反映させる
    // Ref https://zenn.dev/konomae/articles/2f9182561b1372
    func textDidEndEditing(_ notification: Notification) {
        guard let textField = notification.object as? UITextField else {
            return
        }
        textField.sendActions(for: .editingDidEndOnExit)
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
