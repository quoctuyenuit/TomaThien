//
//  ShowListProtocols.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 10/30/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation

protocol ShowListViewProtocol {
    var presenter: ShowListPresenterProtocol? { get set }
}

protocol ShowListPresenterProtocol {
    var view: ShowListViewProtocol? { get set }
    var interactor: ShowListInteractorProtocol? { get set }
    var router: ShowListRouterProtocol? { get set }
}

protocol ShowListInteractorProtocol {
    
}

protocol ShowListRouterProtocol {
    
}
