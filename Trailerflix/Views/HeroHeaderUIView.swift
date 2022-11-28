//
//  HeroHeaderUIView.swift
//  Netflix Clone
//
//  Created by Daniel Vassalo on 14/11/22.
//

import UIKit

protocol HeroHeaderViewDelegate: AnyObject {
    func didTapPlayButton(title: Title?) -> Void
}

class HeroHeaderUIView: UIView {
    
    private var title: Title?
    weak var delegate: HeroHeaderViewDelegate?
    
    private let gradientLayer = CAGradientLayer()
    
    private let playButton: UIButton = {
        let playButton = UIButton()
        playButton.setTitle("Play", for: .normal)
        playButton.layer.borderWidth = 1
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.layer.cornerRadius = 5
        playButton.addTarget(self, action: #selector(playTitle), for: .touchUpInside)
        return playButton
    }()
    
    private let downloadButton: UIButton = {
       let downloadButton = UIButton()
        downloadButton.setTitle("Download", for: .normal)
        downloadButton.layer.borderWidth = 1
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        downloadButton.layer.cornerRadius = 5
        downloadButton.addTarget(self, action: #selector(downloadTitle), for: .touchUpInside)
        return downloadButton
    }()
    
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage()
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    func configureGradient() {
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
    }
    
    func applyConstraints() {
        let playButtonConstraints = [
            playButton.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -8),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 8),
            downloadButton.bottomAnchor.constraint(equalTo: playButton.bottomAnchor),
            downloadButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }

    public func configure(with title: Title?) {
        guard let title = title else {
            return
        }
        let viewModel = TitleViewModel(titleName: title.original_title ?? "", posterURL: title.poster_path ?? "")
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(viewModel.posterURL)") else {
            return
        }
        heroImageView.sd_setImage(with: url, completed: nil)
        self.title = title
    }
    
    @objc func playTitle() {
        delegate?.didTapPlayButton(title: title)
    }
    
    @objc func downloadTitle() {
        guard let title = title else {
            return
        }
        DataPersistenceManager.shared.downloadTitle(with: title) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        playButton.setTitleColor(.label, for: .normal)
        playButton.layer.borderColor = UIColor.label.cgColor
        downloadButton.setTitleColor(.label, for: .normal)
        downloadButton.layer.borderColor = UIColor.label.cgColor
        configureGradient()
    }
}
