//
//  HomeViewController.swift
//  alohomora
//
//  Created by Janine Leal on 14/07/26.
//

import UIKit

final class HomeViewController: BaseViewController {
    let mainView: HomeView
    private let viewModel: HomeViewModel

    override func loadView() {
        super.loadView()
        view = mainView
    }

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        self.mainView = HomeView()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.charactersView.mainCarroussel.dataSource = self
        mainView.charactersView.mainCarroussel.delegate = self

        viewModel.onStateChange = { [weak self] state in
            DispatchQueue.main.async {
                self?.handle(state)
            }
        }

        viewModel.loadCharacters()
    }

    private func handle(_ state: ViewState<[Character]>) {
        switch state {
        case .idle:
            break
        case .loading:
            mainView.charactersView.startLoading()
        case .loaded(let characters):
            mainView.charactersView.stopLoading()
            mainView.charactersView.mainCarroussel.reloadData()
        case .error(let error):
            mainView.charactersView.stopLoading()
//            contentView.showError(error.localizedDescription)
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        if let character = viewModel.character(at: indexPath.item) {
            cell.setUp(with: character)
        }
        return cell
    }
}
