//
//  CurrentWeatherView.swift
//  NooroWeather
//
//  Created by Charles Prutting on 12/14/24.
//

import SwiftUI

struct CurrentWeatherView: View {
    let weatherData: Weather
    
    var body: some View {
        VStack {
            ImageLoaderView(weatherData: weatherData)
            
            HStack{
                Text(weatherData.location.name)
                    .font(.poppinsMedium(size: 30))
                    .foregroundColor(ColorConstants.mainTextColor)
                Label("", systemImage: "location.fill")
                    .font(.poppinsMedium(size: 25))
                    .foregroundColor(ColorConstants.mainTextColor)
            }
            
            HStack {
                Text("\(String(format:"%.0f", weatherData.current.temp_f))")
                    .font(.poppinsMedium(size: 70))
                    .foregroundColor(ColorConstants.mainTextColor)
                VStack {
                    Text("°")
                        .font(.poppinsMedium(size: 20))
                        .foregroundColor(ColorConstants.mainTextColor)
                }
                .frame(height:75, alignment: .top)
            }
            
            Spacer()
                .frame(height: 24)
            
            PropertiesView(weatherData: weatherData)
        }
    }
}

// MARK: - Subviews


struct ImageLoaderView: View {
    let weatherData: Weather
    
    var body: some View {
        AsyncImage(url: URL(string: "https:\(weatherData.current.condition.icon)")) { image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Text("Loading...")
        }
        .frame(height: 123, alignment: .bottom)
    }
}

struct PropertiesView: View {
    let weatherData: Weather
    
    var body: some View {
        HStack(spacing: 56.0) {
            PropertyView(title: "Humidity", value: "\(weatherData.current.humidity)%")
            PropertyView(title: "UV", value: "\(weatherData.current.uv)")
            PropertyView(title: "Feels Like", value: "\(String(format:"%.0f", weatherData.current.feelslike_f))°")
        }
        .padding(25)
        .background(ColorConstants.backgroundColor)
        .cornerRadius(16.0)
    }
}

struct PropertyView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.poppinsMedium(size: 12))
                .foregroundColor(ColorConstants.placeholderTextColor)
            
            Text(value)
                .font(.poppinsMedium(size: 15))
                .foregroundColor(ColorConstants.secondaryTextColor)
        }
    }
}

// MARK: - Preview

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(weatherData: Weather(location: Location(name: "Los Angeles"), current: Current(temp_c: 16.7, temp_f: 62.1, condition: Condition(text: "Overcast", icon: "//cdn.weatherapi.com/weather/64x64/day/122.png", code: 5), humidity: 58, uv: 0.4, feelslike_c: 16.7, feelslike_f: 62.1)))
    }
}
