//
//  HomePage.swift
//  Project
//
//  Created by Shashwath Dinesh on 3/1/25.
//

import CoreML
import MapKit
import SwiftUI

struct Resource: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    let type: String
    let description: String
    let address: String
    let phone: String
}

let resources: [Resource] = [
    // Food Banks
    Resource(name: "SF-Marin Food Bank", latitude: 37.773972, longitude: -122.431297, type: "Food Bank", description: "Provides groceries and meals to individuals and families in need.", address: "900 Pennsylvania Ave, San Francisco, CA", phone: "(415) 282-1900"),
    Resource(name: "Alameda County Community Food Bank", latitude: 37.7833, longitude: -122.2818, type: "Food Bank", description: "Distributes food to local families and community members.", address: "7900 Edgewater Dr, Oakland, CA", phone: "(510) 635-3663"),
    Resource(name: "Los Angeles Regional Food Bank", latitude: 34.0209, longitude: -118.4112, type: "Food Bank", description: "Offers free food and groceries for low-income families.", address: "1734 E 41st St, Los Angeles, CA", phone: "(323) 234-3030"),
    
    // Housing Shelters
    Resource(name: "Hope Haven Shelter", latitude: 37.7749, longitude: -122.4194, type: "Housing Shelter", description: "Emergency housing for individuals and families facing homelessness.", address: "123 Main St, San Francisco, CA", phone: "(415) 555-1234"),
    Resource(name: "Bright Futures Transitional Housing", latitude: 34.0522, longitude: -118.2437, type: "Housing Shelter", description: "Supports individuals transitioning from homelessness to permanent housing.", address: "456 Hope Rd, Los Angeles, CA", phone: "(323) 555-5678"),
    Resource(name: "Safe Haven Women's Shelter", latitude: 37.3382, longitude: -121.8863, type: "Housing Shelter", description: "A safe space for women and children escaping domestic violence.", address: "789 Safe St, San Jose, CA", phone: "(408) 555-9101")
]

struct HomePage: View {
    
    @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)))
    
    @State private var showHousing = true
    @State private var showFood = true
    @State private var isFullScreen = false
    @State private var selectedResource: Resource?
    
    @State var preferred: String
    @State var age: String
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // User Profile
                    NavigationLink(destination: Profile(preferred: preferred)) {
                        HStack {
                            Image(systemName: "person")
                                .resizable()
                                .frame(width: 50.0, height: 50.0)
                                .padding(10)
                            Text(preferred)
                                .font(.system(size: 30))
                                .padding(15)
                        }
                        .padding(5)
                    }
                    .background(Color.defpurple)
                    .cornerRadius(15)
                    .padding(5)
                    
                    // Map View
                    if isFullScreen {
                        fullScreenMap
                    } else {
                        mapView
                    }
                    
                    // Filters
                    HStack {
                        Toggle("Housing", isOn: $showHousing)
                            .padding()
                        Toggle("Food Banks", isOn: $showFood)
                    }
                    .padding()
                    
                    // Navigation Buttons
                    VStack(spacing: 10) {
                        NavigationLink(destination: HousingView()) {
                            TabButton(icon: "house.fill", text: "Affordable Housing")
                        }
                        
                        NavigationLink(destination: FoodDealsView()) {
                            TabButton(icon: "cart.fill", text: "Food Deals")
                        }
                        
                        NavigationLink(destination: EducationView()) {
                            TabButton(icon: "book.fill", text: "Education")
                        }
                    }
                    .padding(.top, 10)
                    
                }
                .background(Color.lightPurple)
                .scrollContentBackground(.hidden)
                .navigationTitle("Uplift")
                .foregroundColor(.white)
            }
        }
        .background(Color.lightPurple)
        .sheet(item: $selectedResource) { resource in
            ResourceDetailView(resource: resource)
        }
    }
    
    // MARK: - Map View
    var mapView: some View {
        Map(position: $cameraPosition) {
            if showFood {
                ForEach(resources.filter { $0.type == "Food Bank" }) { resource in
                    Annotation(resource.name, coordinate: CLLocationCoordinate2D(latitude: resource.latitude, longitude: resource.longitude)) {
                        mapPin(for: resource, color: .red)
                    }
                }
            }
            
            if showHousing {
                ForEach(resources.filter { $0.type == "Housing Shelter" }) { resource in
                    Annotation(resource.name, coordinate: CLLocationCoordinate2D(latitude: resource.latitude, longitude: resource.longitude)) {
                        mapPin(for: resource, color: .blue)
                    }
                }
            }
        }
        .frame(height: 300)
        .cornerRadius(15)
        .padding()
        .onTapGesture {
            isFullScreen.toggle()
        }
    }
    
    // MARK: - Full Screen Map
    var fullScreenMap: some View {
        mapView
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                isFullScreen.toggle()
            }
    }
    
    // MARK: - Map Pin
    func mapPin(for resource: Resource, color: Color) -> some View {
        VStack {
            Image(systemName: resource.type == "Food Bank" ? "fork.knife.circle.fill" : "house.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(color)
            Text(resource.name)
                .font(.caption)
                .fixedSize(horizontal: true, vertical: false)
        }
        .onTapGesture {
            selectedResource = resource
        }
    }
}

// MARK: - TabButton
struct TabButton: View {
    var icon: String
    var text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
            Text(text)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(width: 250, height: 50)
        .background(Color.defpurple)
        .cornerRadius(15)
    }
}

// MARK: - Resource Detail View
struct ResourceDetailView: View {
    let resource: Resource
    
    var body: some View {
        VStack(spacing: 20) {
            Text(resource.name)
                .font(.largeTitle)
                .bold()
            Text("Type: \(resource.type)")
            Text("Address: \(resource.address)")
            Text("Phone: \(resource.phone)")
            Text("Description: \(resource.description)")
        }
        .padding()
    }
}

#Preview {
    HomePage(preferred: "Preview", age: "0-12")
}
