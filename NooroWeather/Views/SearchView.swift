//
//  SearchView.swift
//  NooroWeather
//
//  Created by Charles Prutting on 12/14/24.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        HStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                if let data = viewModel.weatherData {
                    NameAndTempView(weatherData: data)
                    Spacer()
                    SearchLoadImageView(weatherData: data)
                } else {
                    Text("Missing city data")
                        .font(.poppinsMedium(size: 20))
                        .foregroundColor(ColorConstants.mainTextColor)
                }
            }
        }
        .padding(20.0)
        .background(ColorConstants.backgroundColor)
        .cornerRadius(16.0)
        .onTapGesture(perform: {
            viewModel.saveCity(city: viewModel.weatherData?.location.name ?? "")
            viewModel.searchField = ""
            endEditing()
        })
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

// MARK: - Subviews

struct SearchLoadImageView: View {
    let weatherData: Weather
    var body: some View {
        AsyncImage(url: URL(string: "https:\(weatherData.current.condition.icon)")) { image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Text("Loading...")
        }
        .frame(height: 85, alignment: .center)
    }
}

struct NameAndTempView: View {
    let weatherData: Weather
    var body: some View {
        VStack {
            Text(weatherData.location.name)
                .font(.poppinsMedium(size: 20))
                .foregroundColor(ColorConstants.mainTextColor)
            
            HStack {
                Text("\(String(format:"%.0f", weatherData.current.temp_f))")
                    .font(.poppinsMedium(size: 60))
                    .foregroundColor(ColorConstants.mainTextColor)
                VStack {
                    Text("°")
                        .font(.poppinsMedium(size: 20))
                        .foregroundColor(ColorConstants.mainTextColor)
                }
                .frame(height:65, alignment: .top)
            }
        }
    }
}

// MARK: - Preview

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: WeatherViewModel())
    }
}
