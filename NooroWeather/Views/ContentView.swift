//
//  ContentView.swift
//  NooroWeather
//
//  Created by Charles Prutting on 12/14/24.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        GeometryReader { _ in
            VStack {
                SearchBar(viewModel: viewModel)
                
                if viewModel.searchField.isEmpty {
                    MainView(viewModel: viewModel)
                } else {
                    SearchView(viewModel: viewModel)
                }
            }
            .padding(25)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .onAppear(perform: viewModel.loadUserDefaults)
        }
        .ignoresSafeArea(.keyboard)
    }
}


// MARK: - Subviews

struct SearchBar: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        HStack {
            TextField("", text: $viewModel.searchField, prompt:
                        Text("Search Location")
                .foregroundColor(ColorConstants.placeholderTextColor)
                .font(.poppinsRegular(size: 15))
            )
            .font(.poppinsRegular(size: 15))
            .foregroundColor(ColorConstants.mainTextColor)
            .onChange(of: viewModel.searchField) { city in
                viewModel.fetchWeatherForCity(city: city)
            }

            Image(systemName: "magnifyingglass")
                .foregroundColor(ColorConstants.placeholderTextColor)
        }
        .padding()
        .background(ColorConstants.backgroundColor)
        .cornerRadius(16.0)

    }
}

struct MainView: View {
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        VStack {
            if viewModel.selectedCity.isEmpty {
                Text("No City Selected")
                    .font(.poppinsBold(size: 30))
                    .foregroundColor(ColorConstants.mainTextColor)
                    .padding(.bottom, 5)
                Text("Please Search For A City")
                    .font(.poppinsBold(size: 15))
                    .foregroundColor(ColorConstants.mainTextColor)
            } else {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    if let data = viewModel.weatherData {
                        CurrentWeatherView(weatherData: data)
                        Spacer()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding(.top, 50)
        .onTapGesture(perform: endEditing)
        
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}


// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
