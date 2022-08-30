//
//  LottoAPIManager.swift
//  Week9
//
//  Created by SC on 2022/08/30.
//

import Foundation

// shared - 단순한 통신. 커스텀 X. 응답 클로저. 백그라운드 전송 불가
// default configuartion - shared 설정과 유사. 커스텀 가능(셀룰러 연결 여부, 타임아웃 간격 등). 응답은 클로저로도 가능하고 델리게이트로도 가능
// (타임아웃: 3초 지나도 응답이 안 오면 사용자한테 다시 시도해 달라고 하는 것 등)

enum APIError: Error {  // 애플에서 만들어 놓은 코드 활용
    case invalidResponse
    case noData
    case failedRequest
    case invalidData
}

class LottoAPIManager {
    static func requestLotto(drwNo: Int, completion: @escaping (Lotto?, APIError?) -> Void) {
        // URLSession은 Foundation안에 들어 있음
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)")! // ☘️
        
  
        // 헤더 넣는 방법
//        let a = URLRequest(url: <#T##URL#>)
//        a.setValue(<#T##value: String?##String?#>, forHTTPHeaderField: <#T##String#>)
//        URLSession.shared.dataTask(with: a)
        
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
                
                guard let response = response as? HTTPURLResponse else {  // ☘️
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
                    let result = try JSONDecoder().decode(Lotto.self, from: data)
//                    print(result)
//                    print(result.drwNoDate)
                    completion(result, nil)
                } catch {
                    print(error)
                }
            }
            
            
//            print(data)
//            print(String(data: data!, encoding: .utf8))
//            print(response)
//            print(error)
            
            
            
            
            

        }.resume()  // .resume() 을 안 하면 실행이 안 된다!
        // 이 중괄호 안은 메인쓰레드가 아니라 글로벌이다
    }
}
