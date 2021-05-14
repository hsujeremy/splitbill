//
//  Results.swift
//  SplitBill
//
//  Created by Jeremy Hsu on 5/13/21.
//

import SwiftUI

struct Results: View {
  var formattedTip: String
  var formattedTotal: String
  
  var body: some View {
    Text("You will tip $\(formattedTip)")
    Text("Your total is $\(formattedTotal)")
  }
}

