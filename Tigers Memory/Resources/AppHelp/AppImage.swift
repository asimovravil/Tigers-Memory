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
    
    // MARK: - Background
    
    case backgroundMenu
    case backgroundLoader
}
