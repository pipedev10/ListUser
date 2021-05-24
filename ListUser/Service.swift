//
//  Service.swift
//  ListUser
//
//  Created by Pipe Carrasco on 22-05-21.
//

import Foundation
import Alamofire

class Service {
    //https://jsonplaceholder.typicode.com
    fileprivate var baseUrl = ""
    typealias usersCallBack = (_ users:[User]?, _ status: Bool, _ message:String) -> Void
    
    var callBack:usersCallBack?
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    //MARK:- getAllUserFrom
    func getAllUserFrom(endPoint:String) {
        AF.request(self.baseUrl + endPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (responseData) in
            guard let data = responseData.data else {
                self.callBack?(nil, false, "")

                return}
            do {
            let users = try JSONDecoder().decode([User].self, from: data)
                self.callBack?(users, true,"")
            } catch {
                self.callBack?(nil, false, error.localizedDescription)
            }
            
        }
    }
    
    func completionHandler(callBack: @escaping usersCallBack) {
        self.callBack = callBack
    }
    
    func getAllUsers(completion: @escaping (Result<[User], Error>) -> Void) {
      AF.request("https://jsonplaceholder.typicode.com/users").validate().responseDecodable(of: [User].self) { response in
        switch response.result {
        case .success(let users):
          completion(.success(users))
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
}
