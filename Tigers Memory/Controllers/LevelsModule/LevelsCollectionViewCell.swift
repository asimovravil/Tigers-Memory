//
//  LevelsCollectionViewCell.swift
//  Tigers Memory
//
//  Created by Ravil on 26.10.2023.
//

import UIKit
import SnapKit

final class LevelCollectionViewCell: UICollectionViewCell {
    
    var levelCloseButtonTappedHandler: (() -> Void)?
    var levelButtonTappedHandler: (() -> Void)?
    static let reuseID = String(describing: LevelCollectionViewCell.self)
    
    // MARK: - UI
    
    public lazy var levelButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(levelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    public lazy var levelCloseButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(levelCloseButtonTapped), for: .touchUpInside)
        return button
    }()
        
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupViews
    
    private func setupViews() {
        [levelButton, levelCloseButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        levelButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        levelCloseButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    
    @objc private func levelButtonTapped() {
        levelButtonTappedHandler?()
    }
    
    @objc private func levelCloseButtonTapped() {
        levelCloseButtonTappedHandler?()
    }
}
