//
//  TeamCache.swift
//  TomaThien
//
//  Created by Nguyễn Quốc Tuyến on 11/12/18.
//  Copyright © 2018 Nguyễn Quốc Tuyến. All rights reserved.
//

import Foundation
import SQLite
import RxSwift

class TeamDataCache: SqliteDatabase {
    private var table: Table!
    private let id = Expression<Int>("id")
    private let name = Expression<String>("name")
    private let disposeBag = DisposeBag()
    
    public static let sharedInstance = TeamDataCache()
    
    override init() {
        super.init()
        self.setup()
    }
    
    override func setup() {
        super.setup()
        self.table = Table("\(TeamDataCache.self)")
        do
        {
            try database.run(table.create { t in
                t.column(id, primaryKey: true)
                t.column(name)
            })
            print("Create Team Table successful")
        } catch (let ex) {
            print(ex.localizedDescription)
        }
    }
    
    public func insert(value: Team) throws {
        let insert = self.table.insert(id <- value.id, name <- value.name)
        try self.database.run(insert)
        print("insert successful value = \(value)")
        ServerServices.sharedInstance.pushData(key: "\(value.id)",
                                               from: ServerReferncePath.teamList,
                                               value: value.toObject()) { _,_  in }
    }
    
    public func update(id: Int, value: User) throws {
        let team = self.table.filter(self.id == id)
        try self.database.run(team.update(name <- value.name))
        print("update user successful")
    }
    
    public func select(id: Int) -> Team? {
        let element = self.table.filter(self.id == id)
        var team: Team?
        
        try? self.database.prepare(element).forEach({ (row) in
            team = Team(id: row[self.id] ,name: row[self.name])
        })
        return team
    }
    
    public func selectAll(completion: @escaping ([Team]) -> ()) {
        var teams = [Team]()
        try? self.database.prepare(self.table).forEach({ (row) in
            teams.append(Team(id: row[self.id], name: row[name]))
        })
        
        //If cache have data
        if teams.count  > 0 {
            completion(teams)
        } else {
            //if cache is empty -> pull from server
            self.updateData(completion: completion)
        }
        
        
    }
    
    public func count() throws -> Int {
        return try self.database.scalar(self.table.count)
    }
}

extension TeamDataCache {
    public func updateData(completion: (([Team]) -> ())?) {
        var teams = [Team]()
        ServerServices
            .sharedInstance.pullData(path: ServerReferncePath.teamList) { listSnapshot in
                listSnapshot.forEach({ (snapshot) in
                    guard let team = Team(snapshot: snapshot),
                        ((try? self.insert(value: team)) != nil)
                        else {
                            print("get teams from server failt")
                            return
                    }
                    teams.append(team)
                })
                completion?(teams)
        }
    }
}
