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
  
  var isDisabled: Bool {
    subtotal.isEmpty || !subtotal.isFloat || tipPercent.isEmpty || !tipPercent.isInt
  }
  
  func doSomething(subtotal: Float, tipPercent: Float) -> (tipAmount: Float, total: Float) {
    let tipAmount = tipPercent / 100 * subtotal
    let total = subtotal + tipAmount
    return (tipAmount, total)
  }
  
  var body: some View {
    NavigationView {
      VStack {
        Form {
          TextField("Amount", text: $subtotal)
            .keyboardType(.decimalPad)
          
          TextField("Tip Percent", text: $tipPercent)
            .keyboardType(.decimalPad)
          
          Button(action: {
            let result = doSomething(subtotal: Float(subtotal)!, tipPercent: Float(tipPercent)!)
            tipAmount = result.tipAmount
            total = result.total
          }) {
            Text("Calculate")
          }
          .disabled(isDisabled)
        }
        .navigationBarTitle("Tip and Total")
        
        if total > -1 {
          Results(
            formattedTip: String(format: "%.2f", tipAmount),
            formattedTotal: String(format: "%.2f", total)
          )
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
