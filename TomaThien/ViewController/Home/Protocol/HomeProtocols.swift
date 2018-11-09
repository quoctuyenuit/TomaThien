//
//  HomeProtocols.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/3/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewProtocol {
    
    var presenter: HomePresenterProtocol? { get set }
}
protocol HomePresenterProtocol {
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    //View -> Presenter
    func showQRScanner()
    
}
protocol HomeInteractorProtocol {
    
}
protocol HomeRouterProtocol {
    static func mainStoryboard() -> UIStoryboard
    static func createHomeViewController() -> UIViewController
    func showQRScanner()
}
