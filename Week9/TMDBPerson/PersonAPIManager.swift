//
//  PersonAPIManager.swift
//  Week9
//
//  Created by SC on 2022/08/30.
//

import Foundation

class PersonAPIManager {
    static func requestPerson(query: String, completion: @escaping (Person?, APIError?) -> Void) {
//        query.addingPercentEncoding(withAllowedCharacters: .whitespaces)
        let url = URL(string: "https://api.themoviedb.org/3/search/person?api_key=6dc511ab65726972f528258b96fa8567&language=en-US&query=\(query)&page=1&include_adult=false&region=ko-KR")!
        
        let scheme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/person"
        
        let key = "6dc511ab65726972f528258b96fa8567"
        let language = "ko-KR"
        let query = query.addingPercentEncoding(withAllowedCharacters: .whitespaces)
        let region = "ko-KR"
        
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "language", value: language),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "region", value: region),
        ]
        
//        URLSession+Extension  // 내일(08.31)할 것
//        URLSession.request(endpoint: <#T##URLRequest#>, completion: <#T##((Decodable & Encodable)?, APIError?) -> Void#>)
        
        URLSession.shared.dataTask(with: url) { data, response, error in  // 실질적인 순서는 거꾸로 error 먼저 확인하고 response가 잘 왔는지 확인 후 data 확인
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed Request")
                    completion(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("No Data Returned")
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completion(nil, .invalidResponse)
                    return
                }

                guard response.statusCode == 200 else {
                    print("Failed Response")
                    completion(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Person.self, from: data)
                    completion(result, nil)
                } catch {
                    print(error)
                }
            }
        }.resume()  // .resume() 을 안 하면 실행이 안 된다!
        // 이 중괄호 안은 메인쓰레드가 아니라 글로벌이다
    }
}
