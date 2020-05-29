//
//  ATMoya.swift
//  ATCarToon
//
//  Created by wangws1990 on 2020/5/29.
//  Copyright © 2020 wangws1990. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON

public enum ATMoya{
    case apiHot(sexType : Int)
    case apiVip
    case apiSub
    case apiRank
}
extension ATMoya : TargetType{
    public static func apiMoya(target: ATMoya,sucesss:@escaping ((_ object : JSON) ->()),failure:@escaping ((_ error : String) ->())){
        let moya = MoyaProvider<ATMoya>();
        moya.request(target, callbackQueue: DispatchQueue.main, progress: { (progress) in
            
        }) { (result) in
            switch result{
            case let .success(respond):
                let json = JSON(respond.data)
                let jsonData = json["data"];
                if jsonData["stateCode"] == 1 {
                    sucesss(jsonData["returnData"]);
                }else{
                    failure("code != 1")
                }
                break;
            case let .failure(error):
                failure(error.errorDescription!)
                break;
            }
        }
    }
    public var path: String {
        switch self {
        case .apiHot:
            return "comic/boutiqueListNew";
        case .apiVip:
            return "list/vipList";
        case .apiSub:
            return "list/newSubscribeList";
        case .apiRank:
            return "rank/list";
        }
    }
    public var task: Task {
        switch self {
        case let .apiHot(sexType:sexType):
            return .requestParameters(parameters:["sexType":sexType], encoding: URLEncoding.default);
        default:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default);
        }
    }
    public var sampleData: Data {
        return Data(base64Encoded: "just for test")!
    }
    public var headers: [String : String]? {
        return [:];
    }
    public var baseURL : URL{
        return URL(string:ATBaseMoya.baseHost())!;
    }
    public var method: Moya.Method {
        return .get;
    }
}
