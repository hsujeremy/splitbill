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
  
  var isFloat: Bool {
    return Float(self) != nil
  }
}

struct ContentView: View {
  @State private var subtotal: String = ""
  @State private var tip: String = ""
  @State private var total: Float = -1
  
  var disableForm: Bool {
    subtotal.isEmpty || !subtotal.isFloat || tip.isEmpty || !tip.isInt
  }
  
  var body: some View {
    NavigationView {
      VStack {
        Form {
          TextField("Amount", text: $subtotal)
          
          TextField("Tip Percent", text: $tip)
          
          Button(action: {
            // Perform action here
            print("The user entered \(subtotal)")
            total = Float(subtotal)! * (1.0 + Float(tip)! / 100)
          }) {
            Text("Submit Form")
          }
          .disabled(disableForm)
        }
        .navigationBarTitle("Form")
        
        if total > -1 {
          let formattedTotal: String = String(format: "%.2f", total)
          Text("Your total is $\(formattedTotal)")
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
