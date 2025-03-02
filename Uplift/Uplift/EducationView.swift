//
//  EducationView.swift
//  Uplift
//
//  Created by Shashwath Dinesh on 3/1/25.
//

import SwiftUI
import CoreML

struct EducationView: View {
    @State private var recommendedScholarship: String = "N/A"
    @State private var skillResources: [String] = [
        "Coursera - Free Online Courses",
        "edX - University-level Courses",
        "Khan Academy - Skill Development"
    ]
    @State private var mentors: [String] = [
        "Jane Doe - Career Mentor",
        "John Smith - Tech Mentor",
        "Emily Johnson - Academic Advisor"
    ]
    
    // User inputs
    @State private var classYear: String = ""
    @State private var fieldOfStudy: String = ""
    @State private var gpaRange: String = ""
    @State private var incomeLevel: String = ""
    @State private var extracurricular: String = ""
    @State private var communityService: String = ""
    @State private var underrepresentedGroup: String = ""
    @State private var firstGenStudent: String = ""

    // Load ML model
    let model = try! Scholarship_Recommender_2(configuration: MLModelConfiguration())
    
    let gpaRanges = [
        "0.0-1.0", "1.0-2.0", "2.0-2.5", "2.5-3.0",
        "3.0-3.5", "3.5-4.0"
    ]

    let classYears = [
        "Freshman", "Sophomore", "Junior", "Senior"
    ]
    
    let incomeLevels = [
        "<$20,000", "$20,000-$40,000", "$40,000-$60,000",
        "$60,000-$80,000", "$80,000-$100,000", "$100,000+"
    ]
    
    let extracurriculars = [
        "None", "Sports", "Music/Arts", "Volunteering",
        "STEM Clubs", "Student Government"
    ]
    
    let communityServiceHours = [
        "<10 hours", "10-50 hours", "51-100 hours",
        "101-200 hours", "200+ hours"
    ]
    
    let yesNoOptions = ["Yes", "No"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Education Resources")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 10)
                
                // Scholarship Recommendation
                GroupBox(label: Text("Scholarship Recommendation").font(.headline)) {
                    VStack {
                        Text("Based on your profile, we recommend:")
                        
                        Text(recommendedScholarship)
                            .font(.title2)
                            .foregroundColor(.purple)
                            .padding(.top, 5)
                        
                        Button(action: getScholarshipRecommendation) {
                            Text("Get Recommendation")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.defpurple)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.top, 10)
                    }
                    .padding()
                }
                
                // User Input Form
                GroupBox(label: Text("Your Information").font(.headline)) {
                    VStack(alignment: .leading, spacing: 15) {
                        
                        TextField("Field of Study", text: $fieldOfStudy)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Text("GPA Range")
                        
                        Picker("GPA Range", selection: $gpaRange) {
                            ForEach(gpaRanges, id: \.self) { gpa in
                                Text(gpa)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        Text("Class Year")
                        
                        Picker("Class Year", selection: $classYear) {
                            ForEach(classYears, id: \.self) { year in
                                Text(year)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        Text("Income Level")
                        
                        Picker("Income Level", selection: $incomeLevel) {
                            ForEach(incomeLevels, id: \.self) { level in
                                Text(level)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        Text("Extracurricular Activities")
                        
                        Picker("Extracurricular Activities", selection: $extracurricular) {
                            ForEach(extracurriculars, id: \.self) { activity in
                                Text(activity)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        Text("Community Service Hours")
                        
                        Picker("Community Service Hours", selection: $communityService) {
                            ForEach(communityServiceHours, id: \.self) { hours in
                                Text(hours)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        Text("Underrepresented Group")
                        
                        Picker("Underrepresented Group", selection: $underrepresentedGroup) {
                            ForEach(yesNoOptions, id: \.self) { option in
                                Text(option)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        Text("First-Generation College Student")
                        
                        Picker("First-Generation College Student", selection: $firstGenStudent) {
                            ForEach(yesNoOptions, id: \.self) { option in
                                Text(option)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    .padding()
                }
                
                GroupBox(label: Text("Skill-Building Resources").font(.headline)) {
                    ForEach(skillResources, id: \.self) { resource in
                        Link(resource, destination: URL(string: "https://www.google.com/search?q=\(resource.replacingOccurrences(of: " ", with: "+"))")!)
                            .padding(.vertical, 5)
                    }
                }
                
                GroupBox(label: Text("Find a Mentor").font(.headline)) {
                    ForEach(mentors, id: \.self) { mentor in
                        Text(mentor)
                            .padding(.vertical, 5)
                    }
                }
            }
            .padding()
        }
    }

    // Scholarship recommendation function
    func getScholarshipRecommendation() {
        do {
            let prediction = try model.prediction(
                Class_Year: classYear,
                Field_of_Study: fieldOfStudy,
                GPA_Range: gpaRange,
                Income_Level: incomeLevel,
                Extracurricular_Activities: extracurricular,
                Community_Service_Hours: communityService,
                Underrepresented_Group: underrepresentedGroup,
                First_Generation_College_Student: firstGenStudent
            )
            recommendedScholarship = prediction.Recommended_Scholarships
            print("Recommended Scholarship: \(recommendedScholarship)")
        } catch {
            print("Prediction error: \(error)")
        }
    }
}

#Preview {
    EducationView()
}
