//
//  ContentView.swift
//  SwiftTax
//
//  Created by David Rocharz on 9/21/24.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView: View {
    
    private enum Field: Int, CaseIterable {
        case preTaxPrice
        case taxRate
    }
    
    @State var preTaxPrice: String = ""
    @State var taxRate: String = ""
    @State var finalPrice: String = ""
    
    @FocusState private var focusedField: Field?
    
    func calculateTax() {
        let preTaxPrice = Double(self.preTaxPrice) ?? 0
        let taxRate = Double(self.taxRate) ?? 0
        let tax = preTaxPrice * taxRate / 100
        let finalPrice = preTaxPrice + tax
        
        self.finalPrice = String(format: "$%.2f", finalPrice)
    }
    
    func reset() {
        self.preTaxPrice = ""
        self.taxRate = ""
        self.finalPrice = ""
    }
    
    var body: some View {
        VStack {
            Text("Sales Tax Calculator")
                .font(.largeTitle)
                .foregroundColor(Color.blue)
                .padding(.top, 40)
            Form {
                HStack {
                    Text("Pre-Tax Price")
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .padding()
                    TextField("$0.00", text: $preTaxPrice)
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .preTaxPrice)
                }
                HStack {
                    Text("Sales Tax Rate")
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .padding()
                    TextField("0%", text: $taxRate)
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .taxRate)
                }
            }.toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                        focusedField = nil
                    }
                }
            }
            HStack {
                Text("Total")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .padding()
                TextField("$0.00", text: $finalPrice)
                    .disabled(true)
            }.padding(.leading, 20)
            HStack {
                Button("Reset") {
                    reset()
                }
                    .padding()
                    .foregroundColor(.red)
                    .font(.headline)
                Button("Calculate") {
                    calculateTax()
                }
                    .disabled(preTaxPrice.isEmpty)
                    .padding()
                    .font(.headline)
            }
            Spacer()
        }
    }
}

#Preview {
    ContentView()
}
