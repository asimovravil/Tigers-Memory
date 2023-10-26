//
//  AppImage.swift
//  Tigers Memory
//
//  Created by Ravil on 26.10.2023.
//

import UIKit

protocol AppImageProtocol {
    var rawValue: String { get }
}

extension AppImageProtocol {

    var uiImage: UIImage? {
        guard let image = UIImage(named: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return image
    }
    
    var systemImage: UIImage? {
        guard let image = UIImage(systemName: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return image
    }
    
}

enum AppImage: String, AppImageProtocol {
    
    // MARK: - AppImage
    
    case splashLoading
    case playButton
    case shopButton
    case rulesButton
    case progressButton
    case privacyPolicy
    case cardRules
    case backNavigationButton
    case cardShop
    case selectButton
    case cardSelectShop
    case buyButton
    case coinWalletImage
    case coinSolo
    case rewardChair
    case rewardCat
    case rewardFrog
    case fortuna
    
    // MARK: - Background
    
    case backgroundMenu
    case backgroundLoader
    case background
    case backgroundProgress
    case backgroundWin
    case backgroundNewProgress
    case backgroundWheel
    case backgroundGame
    
    // MARK: - Levels
    
    case closeLevel
    case level1
    case level2
    case level3
    case level4
    case level5
    case level6
    case level7
    case level8
    
    // MARK: - Game
    
    case chairCell
    case coinCell
    case boxCell
    case frogCell
    case inyanCell
    case cloudCell
    case petrCell
    case flagCell
    case megaballsCell
    case orangeCell
    case fishCell
    case crazyCell
    case houseCell
    case cell
}
