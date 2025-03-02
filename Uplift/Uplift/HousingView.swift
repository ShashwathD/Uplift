//
//  HousingView.swift
//  Uplift
//
//  Created by Shashwath Dinesh on 3/1/25.
//

import SwiftUI

struct HousingView: View {
    struct HousingResource: Identifiable {
        let id = UUID()
        let name: String
        let type: String
        let description: String
        let capacity: String
    }
    
    let housingResources = [
        HousingResource(name: "Hope Haven Shelter", type: "Emergency Housing", description: "Provides short-term housing and meals for individuals and families facing homelessness.", capacity: "Capacity: 50 beds"),
        HousingResource(name: "Bright Futures Transitional Housing", type: "Transitional Housing", description: "Supports individuals moving from homelessness to permanent housing, offering counseling and job training.", capacity: "Capacity: 30 units"),
        HousingResource(name: "Affordable Living Community", type: "Affordable Housing", description: "Offers low-income housing options with rent assistance programs.", capacity: "Capacity: 100 apartments"),
        HousingResource(name: "Safe Haven Women's Shelter", type: "Emergency Housing", description: "A safe space for women and children escaping domestic violence, with support services included.", capacity: "Capacity: 25 beds")
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Housing Resources")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.purple)
                
                ForEach(housingResources) { resource in
                    GroupBox(label: Text(resource.name).font(.headline).foregroundColor(.purple)) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(resource.type)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(resource.description)
                                .font(.body)
                            Text(resource.capacity)
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
    HousingView()
}
