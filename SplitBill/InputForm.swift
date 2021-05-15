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
    !amounts.tipPercent.isInt ||
    amounts.salesTax.isEmpty ||
    !amounts.salesTax.isInt
  }
  
  func calculate(
    subtotal: Float,
    salesTax: Float,
    tipPercent: Float
  ) -> (tipAmount: Float, total: Float) {
    let subtotalWithTax = subtotal * (1.0 + salesTax / 100)
    let tipAmount = tipPercent / 100 * subtotalWithTax
    let total = subtotalWithTax + tipAmount
    return (tipAmount, total)
  }
  
  var body: some View {
    Form {
      TextField("Amount", text: $amounts.subtotal)
        .keyboardType(.decimalPad)
      
      TextField("Sales Tax", text: $amounts.salesTax)
        .keyboardType(.decimalPad)

      TextField("Tip Percent", text: $amounts.tipPercent)
        .keyboardType(.decimalPad)

      Button(action: {
        let result = calculate(
          subtotal: Float(amounts.subtotal)!,
          salesTax: Float(amounts.salesTax)!,
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
