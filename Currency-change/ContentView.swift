//
//  ContentView.swift
//  Currency-change
//
//  Created by Артур Агеев on 02.06.2023.
//

import SwiftUI

struct ContentView: View {
    @State var input = "100"
    @State var base = "USD"
    @State var currencyList = [String]()
    @FocusState private var inputIsFocused: Bool
    
    func makeRequest(showAll:Bool, currencies: [String] = ["USD", "GBP", "EUR"]) {
        apiRequest(url: "https://api.exchangerate.host/lates?base=\(base)&amount=\(input)") { currency in
           var tempList = [String]()
            
            for currency in currency.rates {
                if showAll {
                    tempList.append("\(currency.key) \(String(format: "%.2f", currency.value))")
                } else if currencies.contains(currency.key){
                    tempList.append("\(currency.key) \(String(format: "%.2f", currency.value))")
                }
                tempList.sort()
            }
            currencyList.self = tempList
            print(tempList)
        }
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Currencies")
                    .font(.system(size: 30))
                    .bold()
                Image(systemName: "eurosing.circle.fill")
                    .foregroundColor(.blue)
        }
            List {
                ForEach(currencyList, id: \.self) { currency in
                    Text(currency)
                }
            }
            VStack {
                Rectangle()
                    .frame(height: 8.0)
                    .foregroundColor(.blue)
                    .opacity(0.90)
                TextField("Enter an currency", text: $input)
                    .padding()
                    .background(Color.gray.opacity(0.10))
                    .cornerRadius(20.0)
                    .padding()
                    .focused($inputIsFocused)
                TextField("Enter an currency", text: $base)
                    .padding()
                    .background(Color.gray.opacity(0.10))
                    .cornerRadius(20.0)
                    .padding()
                    .focused($inputIsFocused)
                Button("Convert!") {
                    makeRequest(showAll: false, currencies: ["DKK","SEK","NOK"])
                    inputIsFocused = false
                    
                }.padding()
            }
  
            
        }.onAppear {
            makeRequest(showAll: true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
