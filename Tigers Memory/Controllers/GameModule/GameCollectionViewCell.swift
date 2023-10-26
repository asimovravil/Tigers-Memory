//
//  GameCollectionViewCell.swift
//  Tigers Memory
//
//  Created by Ravil on 26.10.2023.
//

import UIKit
import SnapKit

final class GameCollectionViewCell: UICollectionViewCell {
    
    var isCellOpen: Bool = false
    var isFlipped: Bool = false
    static let reuseID = String(describing: GameCollectionViewCell.self)
    
    // MARK: - UI
    
    public lazy var cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.cell.uiImage
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
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
        [cellImage].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - setupConstraints
    
    private func setupConstraints() {
        cellImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func flip() {
        isFlipped = !isFlipped
        if isFlipped {
            UIView.transition(with: cellImage, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
        } else {
            UIView.transition(with: cellImage, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
    }
}
