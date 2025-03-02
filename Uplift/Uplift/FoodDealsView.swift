//
//  FoodDealsView.swift
//  Uplift
//
//  Created by Shashwath Dinesh on 3/1/25.
//

import SwiftUI

struct FoodDealsView: View {
    struct FoodResource: Identifiable {
        let id = UUID()
        let name: String
        let type: String
        let description: String
        let availability: String
    }
    
    let foodResources = [
        FoodResource(name: "Community Food Bank", type: "Food Bank", description: "Offers free groceries and pantry items every Wednesday and Saturday for low-income families.", availability: "Open: 9 AM - 3 PM"),
        FoodResource(name: "Hope Soup Kitchen", type: "Soup Kitchen", description: "Provides hot meals daily, including breakfast and dinner, with vegetarian options available.", availability: "Daily: 7 AM - 7 PM"),
        FoodResource(name: "Fresh Market Discounts", type: "Grocery Store", description: "10% off fresh produce for families receiving SNAP benefits every Friday.", availability: "Fridays: 8 AM - 8 PM"),
        FoodResource(name: "Local Farmer's Market", type: "Community Event", description: "Distributes surplus produce from local farms at discounted prices every Sunday.", availability: "Sundays: 10 AM - 2 PM")
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Food Deals & Resources")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.purple)
                
                ForEach(foodResources) { resource in
                    GroupBox(label: Text(resource.name).font(.headline).foregroundColor(.purple)) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(resource.type)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(resource.description)
                                .font(.body)
                            Text(resource.availability)
                                .font(.footnote)
                                .foregroundColor(.purple)
                        }
                        .padding()
                    }
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .padding(.bottom, 10)
                }
            }
            .padding()
        }
    }
}

#Preview {
    FoodDealsView()
}
