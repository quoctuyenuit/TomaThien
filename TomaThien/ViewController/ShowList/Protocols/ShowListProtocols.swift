//
//  ShowListProtocols.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/30/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

enum TypeList {
    case allMember
    case allTeamLeader
    case registedMember
    case allSublead
    case admin
    var description: String {
        switch self {
        case .allMember:
            return "Danh sách thành viên"
        case .allTeamLeader:
            return "Danh sách nhóm trưởng"
        case .registedMember:
            return "Danh sách điểm danh"
        case .allSublead:
            return "Danh sách phó ban"
        case .admin:
            return "Xem thông tin trưởng ban"
        }
    }
    
    static var allCases: [TypeList] {
        return [
            .allMember,
            .allTeamLeader,
            .registedMember,
            .allSublead,
            .admin
        ]
    }
    
    var isMatch: [UserType] {
        switch self {
        case .allMember:
            return UserType.allCases
        case .allTeamLeader:
            return [UserType.teamLeader]
        case .registedMember:
            return []
        case .allSublead:
            return [UserType.sublead]
        case .admin:
            return [UserType.admin]
        }
    }
}

protocol ShowListViewProtocol {
    var presenter: ShowListPresenterProtocol? { get set }
}

protocol ShowListPresenterProtocol {
    var view: ShowListViewProtocol? { get set }
    var interactor: ShowListInteractorProtocol? { get set }
    var router: ShowListRouterProtocol? { get set }
    
    
    func showListOfDetail(from viewController: UIViewController, for typeList: TypeList)
    
    //MARK: - List Of Detail
    func showUserInformationDetail(from viewController: UIViewController, for user: User)
    func getListMemberInformation(for typeList: TypeList, callBack: @escaping (User) -> ())
    
    func getListRegistedMember(for date: String, callBack: @escaping (User) -> ())
    func getListAllMemberByTeam(teamId: Int, callBack: @escaping (User) -> ())
}

protocol ShowListInteractorProtocol {
    func getListMemberInformation(for typeList: TypeList) -> Observable<User>
    func getListRegistedMemberInformation(for date: String) -> Observable<User>
    func getListAllMemberByTeam(teamId: Int) -> Observable<User>
}

protocol ShowListRouterProtocol {
    static func createShowListViewController() -> UIViewController
    func createShowListDetailViewController(for typeList: TypeList) -> UIViewController
    func createShowRegistedListViewController() -> UIViewController
    func createShowAllMemberListViewController() -> UIViewController
    
    func showUserInformationDetail(from viewController: UIViewController?, for user: User)
    
    func showListRegistedList(from viewController: UIViewController?)
    func showListAllMember(from viewController: UIViewController?)
    func showListOfDetail(from viewController: UIViewController?, for typeList: TypeList)
}
