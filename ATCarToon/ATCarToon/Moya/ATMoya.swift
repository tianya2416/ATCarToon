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
    case apiComicList(argCon: Int, argName: String, argValue: Int, page: Int)
    case apiDetail(comicid:String)
    case apiDetailReal(comicid:String)
    case apiComment(comicId: String, thread_id: String,page: Int)
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
        case .apiComicList:
            return "list/commonComicList";
        case .apiDetail:
            return "comic/detail_static_new"
        case .apiDetailReal:
            return "comic/detail_realtime"
        case .apiComment:
            return "comment/list"
        }
    }
    public var task: Task {
        switch self {
        case let .apiHot(sexType:sexType):
            return .requestParameters(parameters:["sexType":sexType], encoding: URLEncoding.default);
        case let .apiComicList(argCon: argCon, argName: argName, argValue: argValue, page: page):
            return .requestParameters(parameters:["argCon":argCon,"argName":argName ,"argValue":argValue,"page":page], encoding: URLEncoding.default);
        case let .apiDetail(comicid: comicid):
            return .requestParameters(parameters:["comicid":comicid], encoding: URLEncoding.default);
        case let .apiDetailReal(comicid: comicid):
            return .requestParameters(parameters:["comicid":comicid], encoding: URLEncoding.default);
        case let .apiComment(comicId: comicId, thread_id: thread_id,page: page):
            return .requestParameters(parameters:["object_id":comicId,"thread_id":thread_id,"page":page], encoding: URLEncoding.default);
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
