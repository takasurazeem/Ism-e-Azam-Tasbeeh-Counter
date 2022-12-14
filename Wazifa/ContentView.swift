//
//  ContentView.swift
//  Wazifa
//
//  Created by Takasur Azeem on 12/12/2022.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("fontSize") private var fontSize = 16.0
    @AppStorage("count") private var count = 0
    @AppStorage("counterSize") private var counterSize = 15
    @AppStorage("darkMode") private var darkMode = true
    @State private var showingConfirmation = false
    @State private var showingConfirmMinus = false
    
    var body: some View {
        NavigationView {
            VStack {
                configurationVStack
                Spacer()
                tasbeeh
                Spacer()
                tasbeehCounter
                HStack {
                    Button(role: .destructive) {
                        showingConfirmMinus.toggle()
                    } label: {
                        Image(systemName: "minus.square")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                    Text("\(counterSize)")
                    Spacer()
                    Button {
                        count += counterSize
                    } label: {
                        Image(systemName: "plus.square")
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.top, 2)
                .font(.system(size: 30))
            }
            .navigationBarItems(
                leading: Button(action: {
                    darkMode.toggle()
                }, label: {
                    Image(systemName: darkMode ? "moon.circle.fill" : "moon.circle")
                }),
                trailing:
                    Button {
                        showingConfirmation = true
                    } label: {
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .foregroundColor(.red)
                    }
            )
            .padding(.horizontal)
            .navigationTitle("Wazifa")
            .alert("Are you sure you want to reset the counter?", isPresented: $showingConfirmation) {
                Button("Yes", role: .destructive) {
                    count = 0
                }
                Button("No", role: .cancel) { }
            }
            .alert("Are you sure you want to minus \(counterSize)", isPresented: $showingConfirmMinus, actions: {
                Button("Yes", role: .destructive) {
                    count -= counterSize
                }
                Button("No", role: .cancel) { }
            })
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
    }
    
    var tasbeehCounter: some View {
        Text("\(count)")
            .bold()
            .foregroundColor(.gray)
            .font(.system(size: 32 * 2))
    }
    
    var tasbeeh: some View {
        Text(
            """
بسم الله الرحمن الرحيم
ألم الله لا اله إلا هو الحي القيوم يا واحد يا ذَا الْجَلَالِ وَالْاِکْرَام
"""
        )
        .font(.system(size: fontSize))
        .environment(\.layoutDirection, .rightToLeft)
        
    }
    
    var configurationVStack: some View {
        VStack(spacing: 20) {
            Stepper("Font size: \(Int(fontSize))", value: $fontSize)
            HStack {
                Menu ("Counter Size") {
                    Picker("Counter size", selection: $counterSize) {
                        ForEach([1, 3, 15], id: \.self) { counter in
                            Text("\(counter)")
                        }
                    }
                }
                Spacer()
                Text("\(counterSize)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func buttonModifier() -> some View {
        self
            .foregroundColor(.white)
            .bold()
            .font(.system(size: 20))
            .padding(.horizontal)
            .frame(height: 50)
            .background(.green)
            .cornerRadius(12)
    }
}
