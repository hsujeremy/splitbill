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
  @State private var tipPercent: String = ""
  @State private var tipAmount: Float = 0
  @State private var total: Float = -1
  
  var disableForm: Bool {
    subtotal.isEmpty || !subtotal.isFloat || tipPercent.isEmpty || !tipPercent.isInt
  }
  
  var body: some View {
    NavigationView {
      VStack {
        Form {
          TextField("Amount", text: $subtotal)
          
          TextField("Tip Percent", text: $tipPercent)
          
          Button(action: {
            // Perform action here
            print("The user entered \(subtotal)")
            tipAmount = Float(tipPercent)! / 100 * Float(subtotal)!
            total = Float(subtotal)! + tipAmount
          }) {
            Text("Calculate")
          }
          .disabled(disableForm)
        }
        .navigationBarTitle("Tip and Total")
        
        if total > -1 {
          let formattedTip: String = String(format: "%.2f", tipAmount)
          let formattedTotal: String = String(format: "%.2f", total)
          Text("You will tip $\(formattedTip)")
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
