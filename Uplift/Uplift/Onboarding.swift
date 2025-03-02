//
//  Onboarding.swift
//  Uplift
//
//  Created by Shashwath Dinesh on 3/1/25.
//

import SwiftUI

struct Onboarding: View {
    @AppStorage("firstName") private var firstName: String = ""
    @AppStorage("lastName") private var lastName: String = ""
    @AppStorage("preferred") private var preferred: String = ""
    @AppStorage("age") private var age: String = ""
    @AppStorage("emergencyShelter") private var emergencyShelter: Bool = false
    @AppStorage("affordHouse") private var affordHouse: Bool = false
    @AppStorage("foodBanks") private var foodBanks: Bool = false
    @AppStorage("deals") private var deals: Bool = false
    @AppStorage("skillBuild") private var skillBuild: Bool = false
    @AppStorage("scholarship") private var scholarship: Bool = false
    @AppStorage("mentorMatch") private var mentorMatch: Bool = false
    
    let ageRanges = ["0-12", "13-18", "19-30", "31-50", "51-65", "65+"]
    
    @State public var sectionColor: Color = Color.defpurple
    
    var body: some View {
        NavigationView {
            VStack {
                
                Form {
                    Section("Info") {
                        TextField("First Name", text: $firstName)
                        TextField("Last Name", text: $lastName)
                        TextField("Preferred Name", text: $preferred)
                        Picker("Age Range", selection: $age) {
                            ForEach(ageRanges, id: \.self) {
                                Text($0)
                            }
                        }.pickerStyle(MenuPickerStyle())
                    }.listRowBackground(sectionColor)
                    Section("Housing Needs") {
                        Toggle("Emergency Shelter", isOn: $emergencyShelter)
                            .toggleStyle(iOSCheckboxToggleStyle())
                        Toggle("Affordable Housing", isOn: $affordHouse)
                            .toggleStyle(iOSCheckboxToggleStyle())
                    }.listRowBackground(sectionColor)
                    Section("Food Needs") {
                        Toggle("Food Banks, Soup Kitchens, etc.", isOn: $foodBanks)
                            .toggleStyle(iOSCheckboxToggleStyle())
                        Toggle("Food Deals", isOn: $deals)
                            .toggleStyle(iOSCheckboxToggleStyle())
                    }.listRowBackground(sectionColor)
                    Section("Educational Needs") {
                        Toggle("Skill Building", isOn: $skillBuild)
                            .toggleStyle(iOSCheckboxToggleStyle())
                        Toggle("Scholarship", isOn: $scholarship)
                            .toggleStyle(iOSCheckboxToggleStyle())
                        Toggle("Match with a Mentor", isOn: $mentorMatch)
                            .toggleStyle(iOSCheckboxToggleStyle())
                    }.listRowBackground(sectionColor)
                }
                
                NavigationLink(destination: HomePage(preferred: preferred, age: age).navigationBarBackButtonHidden(true)) {
                    Text("Submit")
                }.padding(10).background(sectionColor).cornerRadius(10)
            }.scrollContentBackground(.hidden).background(Color.lightPurple).navigationTitle("Uplift")
        }
        
    }
}

extension Color {
    static let defpurple = Color(red: 177 / 255, green: 156 / 255, blue: 217 / 255)
    static let lightPurple = Color(red: 203 / 255, green: 195 / 255, blue: 227/255)
}

extension View {
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
        return self
    }
}

struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()

        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                configuration.label
            }
        })
    }
}

#Preview {
    Onboarding()
}
