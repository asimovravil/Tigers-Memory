//
//  ProgressViewController.swift
//  Tigers Memory
//
//  Created by Ravil on 26.10.2023.
//

import UIKit
import SnapKit

final class ProgressViewController: UIViewController {
    
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.backgroundProgress.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [backgroundView].forEach() {
            view.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints

    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

