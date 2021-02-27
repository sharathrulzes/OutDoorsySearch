//
//  APIHandler.swift
//  OutdoorsySearch
//
//  Created by Sharat on 2/26/21.
//

import Foundation
import Alamofire

struct ConnectivityManager {
    static func isConnectivityAvailable() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

class APIHandler {
    static func getOutDoorsyDetails(_ params: [String: Any], completionHandler: @escaping(OutdoorsyResponse?, AFError?) -> Void) {
        if !ConnectivityManager.isConnectivityAvailable() {
            APIHandler.showAlert("Please check your network")
            return
        }
        var urlString = "https://search.outdoorsy.co/rentals"
        if !params.isEmpty {
            urlString.append("?")
            urlString.append("filter[keywords]=\(params["keywords"] ?? "")")
        }
        guard let url = URL(string: urlString) else {
            return completionHandler(nil, nil)
        }
        var request = URLRequest(url: url,timeoutInterval: 60)
        request.httpMethod = "GET"
        AF.request(request).response { data in
            guard let responseData = data.data else {
                APIHandler.showAlert(data.error?.localizedDescription ?? "Something went wrong")
                return completionHandler(nil, data.error)
            }
            let response = try? JSONDecoder().decode(OutdoorsyResponse.self, from: responseData)
            completionHandler(response, nil)
        }
    }
    static func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true)
    }
}

