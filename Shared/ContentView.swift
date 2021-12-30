//
//  ContentView.swift
//  Shared
//
//  Created by Jinwook Kim on 2021/12/28.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople: Int = 2
    @State private var tipPercentage: Int = 20
    let tipPercentages: [Int] = [10, 15, 20, 25, 0]
    let currencyFormatter: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyFormatter)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(tipPercentages, id: \.self) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    Text(total, format: currencyFormatter)
                } header: {
                    Text("Total amount of the check")
                }
                Section {
                    Text(totalPerPerson, format: currencyFormatter)
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
    var totalPerPerson: Double {
        let peopleCount: Double = Double(numberOfPeople)
        let tipSelection: Double = Double(tipPercentage)
        let tipValue: Double = checkAmount / 100 * tipSelection
        let grandTotal: Double = checkAmount + tipValue
        let amountPerPerson: Double = grandTotal / peopleCount
        return amountPerPerson
    }
    var total: Double {
        let tipSelection: Double = Double(tipPercentage)
        let tipValue: Double = checkAmount / 100 * tipSelection
        let grandTotal: Double = checkAmount + tipValue
        return grandTotal
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
