//
//  IdeaViewModel.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 07/07/21.
//

import Foundation
import SwiftUI

class IdeaViewModel: ObservableObject {
    @Published private(set) var states = States()
    var board: Board
    
    init(board: Board) {
        self.board = board
    }
    
    struct States {
        var pastes = [Paste]()
        var ideas = [Idea]()
        var pastesUidsDict: [String:Paste] = [:]
        var filteredIdeas = [Idea]()
    }
    
    func filterIdeas(by query: String) {
        states.filteredIdeas = states.ideas.filter({$0.title == query})
    }
    
    func resetFilter() {
        states.filteredIdeas = states.ideas
    }
    
    func getPasteBy(uid: String) -> Paste? {
        self.states.pastesUidsDict[uid]
    }
    
    func getPastes() {
        BoardsRepository.current.getAllItens(of: board, on: .pastes, ofItemType: Paste.self) {[weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let pastes):
                if let self = self {
                    self.states.pastes = pastes
                }
            }
        }
    }
   
    func getIdeas() {
        BoardsRepository.current.getAllItens(of: board, on: .ideas, ofItemType: Idea.self) {[weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let ideas):
                if let self = self {
                    self.states.ideas = ideas
                }
            }
        }
    }
    
    func loadData() {
        BoardsRepository.current.getAllItens(of: board, on: .pastes, ofItemType: Paste.self) {[weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let pastes):
                if let self = self {
                    BoardsRepository.current.getAllItens(of: self.board, on: .ideas, ofItemType: Idea.self) {[weak self] result in
                        switch result {
                        case .failure(let error):
                            print(error.localizedDescription)
                        case .success(let ideas):
                            if let self = self {
                                self.states.pastes = pastes
                                self.states.ideas = ideas
                            }
                        }
                    }
                }
            }
        }
    }
    
    func setListeners() {
        BoardsRepository.current.setListener(on: .pastes, of: board, ofItemType: Paste.self) {[weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let pastes):
                if let self = self {
                    self.states.pastes = pastes
                    var newDict: [String:Paste] = [:]
                    for paste in pastes {
                        newDict[paste.uid] = paste
                    }
                    self.states.pastesUidsDict = newDict
                }
            }
        }
        
        BoardsRepository.current.setListener(on: .ideas, of: self.board, ofItemType: Idea.self) {[weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let ideas):
                if let self = self {
                    self.states.ideas = ideas
                    self.states.filteredIdeas = ideas
                }
            }
        }
    }
    
    func getIdeasOfSelectedPaste(paste: Paste) -> [Idea] {
        let ideas = states.ideas.filter { idea in
            idea.pasteUid == paste.uid
        }
        return ideas
    }
}
