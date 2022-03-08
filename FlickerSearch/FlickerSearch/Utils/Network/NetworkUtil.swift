//
//  NetworkUtil.swift
//  FlickerSearch
//
//  Created by kdodla on 3/7/22.
//

import Foundation

class NetworkUtil {
    func fetchImages(for searchString: String, completionHandler: @escaping (ImageSearchModel) -> Void) {
        let searchText = (searchString.filter { !$0.isWhitespace }).replacingOccurrences(of: ",", with: "%2C")
        if let url = URL(string: ConstantStrings.baseUrl + searchText) {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let error = error {
                    print("Error with fetching films: \(error)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                          print("Error with the response, unexpected status code: \(String(describing: response))")
                          return
                      }
                
                if let data = data,
                   let searchImages = try? JSONDecoder().decode(ImageSearchModel.self, from: data) {
                    completionHandler(searchImages)
                }
            })
            task.resume()
        }
    }
}
