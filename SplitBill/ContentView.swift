//
//  ContentView.swift
//  SplitBill
//
//  Created by Jeremy Hsu on 5/12/21.
//

import SwiftUI

extension String {
  var isInt: Bool {
    return Int(self) != nil
  }
}

struct ContentView: View {
  @State var amount: String = ""
  
  var body: some View {
    NavigationView {
      VStack {
        Form {
          TextField("Amount", text: $amount)
          
          Button(action: {
            // Perform action here
            print("The user entered \(amount)")
          }) {
            Text("Submit Form")
          }
          .disabled(amount.isEmpty || !amount.isInt)
        }
        .navigationBarTitle("Form")
        
        Text(amount)
          .padding()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
