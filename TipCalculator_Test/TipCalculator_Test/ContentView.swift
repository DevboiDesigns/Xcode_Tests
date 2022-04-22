//
//  ContentView.swift
//  TipCalculator_Test
//
//  Created by Christopher Hicks on 4/21/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var total: String = ""
    @State private var tipPercentage: Double = 0.2
    @State private var tip: String?
    @State private var message: String = ""
    
    let tipCalcultor = TipCalculator()
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                TextField("Enter total", text: $total)
                    .textFieldStyle(.roundedBorder)
                    .accessibilityLabel("totalTextField")
                
                Picker(selection: $tipPercentage) {
                    Text("10%").tag(0.1)
                    Text("20%").tag(0.2)
                    Text("30%").tag(0.3)
                } label: {
                    EmptyView()
                }
                .pickerStyle(.segmented)
                .accessibilityLabel("tipPercentagePicker")
                
                
                Button {
                    
                    message = ""
                    tip = ""
                    
                    guard let total = Double(self.total) else {
                        message = "Invalid Input"
                        return
                    }
                    
                    do {
                        let result = try tipCalcultor.calculate(total: total, tipPercentage: self.tipPercentage)
                        
                        //MARK: Format Currency to local
                        let formatter = NumberFormatter()
                        formatter.numberStyle = .currency
                        tip = formatter.string(from: NSNumber(value: result))
                        
                        
                        
                    } catch TipCalculatorError.invalidInput {
                        message = "Invalid Input"
                    } catch {
                        message = error.localizedDescription
                    }
                    
                    
                } label: {
                    Text("Calculate Tip")
                        .accessibilityLabel("calculateTipButton")
                }
                .padding(.top, 20)
                
                
                Text(message)
                    .padding(.top, 50)
                    .accessibilityLabel("messageText")
                
                Spacer()
                
                Text(tip ?? "")
                    .font(.system(size: 54))
                    .accessibilityLabel("tipText")
                
                Spacer()
                    .navigationTitle("Tip Calculator")
            }.padding()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
