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

class Amounts: ObservableObject {
  @Published var subtotal: String
  @Published var tipPercent: String
  @Published var tipAmount: Float
  @Published var total: Float
  
  init() {
    self.subtotal = ""
    self.tipPercent = ""
    self.tipAmount = 0
    self.total = -1
  }
}

struct ContentView: View {
  @StateObject var amounts = Amounts()

  func calculate(subtotal: Float, tipPercent: Float) -> (tipAmount: Float, total: Float) {
    let tipAmount = tipPercent / 100 * subtotal
    let total = subtotal + tipAmount
    return (tipAmount, total)
  }
  
  var body: some View {
    NavigationView {
      VStack {
        InputForm()
          .navigationTitle("Tip and Total")
        
        if amounts.total > -1 {
          Results(
            formattedTip: String(format: "%.2f", amounts.tipAmount),
            formattedTotal: String(format: "%.2f", amounts.total)
          )
        }
      }
    }
    .environmentObject(amounts)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
