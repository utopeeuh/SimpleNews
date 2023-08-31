//
//  NetworkService.swift
//  SimpleNews
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/08/23.
//

import Foundation

public final class NetworkService {
  public static let shared = NetworkService()
  private let baseURL = "https://api.nytimes.com/svc/"
  
  private var apiKey: String {
    if let infoDict = Bundle.main.infoDictionary,
       let apiKey = infoDict["API_KEY"] as? String {
        return apiKey
    } else {
      print("API Key is missing!")
      return ""
    }
  }
  
  public func connect<T: Codable>(api: Api, codableType: T.Type, completion: @escaping (T?) -> Void) {
    
    let session = URLSession.shared
    // Create a data task to fetch data from the API
    guard let url = URL(string: "\(baseURL)\(api.path)&api-key=\(apiKey)") else {
      completion(nil) // Notify the caller that there was an error with the URL
      return
    }
    
    let task = session.dataTask(with: url) { (data, response, error) in
      // Check for errors
      if let error = error {
        print("Error fetching data: \(error.localizedDescription)")
        completion(nil) // Notify the caller that there was an error
        return
      }
      
      // Check if we received a successful response
      guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 else {
        print("Error: Invalid HTTP response")
        completion(nil) // Notify the caller that there was an error with the response
        return
      }
      
      // Check if data is available
      guard let data = data else {
        print("Error: No data received")
        completion(nil) // Notify the caller that there was no data
        return
      }
      
      do {
        // Parse the JSON data into a Codable object
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(T.self, from: data)
        print(decodedData)
        completion(decodedData) // Return the decoded data to the caller
      } catch let parsingError {
        print("Error decoding JSON: \(parsingError.localizedDescription)")
        completion(nil) // Notify the caller that there was an error with JSON decoding
      }
    }
    
    // Start the data task
    task.resume()
  }
}
