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
    @AppStorage("darkMode") private var darkMode = true
    @State private var showingConfirmation = false

    var body: some View {
        NavigationView {
            VStack {
                Stepper("Font size", value: $fontSize)
                Spacer()
                Text(
                    """
بسم الله الرحمن الرحيم
 ألم الله لا اله إلا هو الحي القيوم يا واحد يا ذَا الْجَلَالِ وَالْاِکْرَام
"""
                )
                .font(.system(size: fontSize))
                .environment(\.layoutDirection, .rightToLeft)
                
                Spacer()
                Text("\(count)")
                    .bold()
                    .foregroundColor(.gray)
                    .font(.system(size: 32 * 2))
                HStack {
                    Button("Increment") {
                        count += 1
                    }
                    .buttonModifier()
                    Spacer()
                    Button("Decrement", role: .destructive) {
                        count -= 1
                    }
                    .buttonStyle(.borderedProminent)
                    Spacer()
                    
                    Button("Plus 15") {
                        count += 15
                    }
                    .buttonModifier()
                }
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
                            .foregroundColor(.blue)
                    }
            )
            .padding(.horizontal)
            .navigationTitle("Wazifa")
            .confirmationDialog("Reset Counter", isPresented: $showingConfirmation) {
                Button("Yes", role: .destructive) {
                    count = 0
                }
                Button("No", role: .cancel) { }
            } message: {
                Text("Are you sure you want to reset the counter?")
            }
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
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
