//
//  Form.swift
//  SplitBill
//
//  Created by Jeremy Hsu on 5/14/21.
//

import SwiftUI

struct InputForm: View {
  @EnvironmentObject var amounts: Amounts
  
  var isDisabled: Bool {
    amounts.subtotal.isEmpty ||
    !amounts.subtotal.isFloat ||
    amounts.tipPercent.isEmpty ||
    !amounts.tipPercent.isInt
  }
  
  func calculate(subtotal: Float, tipPercent: Float) -> (tipAmount: Float, total: Float) {
    let tipAmount = tipPercent / 100 * subtotal
    let total = subtotal + tipAmount
    return (tipAmount, total)
  }
  
  var body: some View {
    Form {
      TextField("Amount", text: $amounts.subtotal)
        .keyboardType(.decimalPad)

      TextField("Tip Percent", text: $amounts.tipPercent)
        .keyboardType(.decimalPad)

      Button(action: {
        let result = calculate(
          subtotal: Float(amounts.subtotal)!,
          tipPercent: Float(amounts.tipPercent)!
        )
        amounts.tipAmount = result.tipAmount
        amounts.total = result.total
      }) {
        Text("Calculate")
      }
      .disabled(isDisabled)
    }
  }
}

struct InputForm_Previews: PreviewProvider {
  static var previews: some View {
    InputForm()
  }
}
