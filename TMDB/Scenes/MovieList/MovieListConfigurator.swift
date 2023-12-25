//
//  MovieListConfigurator.swift
//  TMDB
//
//  Created by Eslam Abo El Fetouh on 22/12/2023.
//

import UIKit
import NetworkKit

final class MovieListConfigurator {
    
    // MARK: Configuration
    class func viewController() -> MovieListViewController {
        let view = MovieListViewController()
        let loader = DiscoverMoviesLoader()
        let interactor = MovieListInteractor(loader: loader)
        let router = MovieListRouter(viewController: view)
        let presenter = MovieListPresenter(view: view,
                                           interactor: interactor,
                                           router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
// MARK: - Protocols
// Controller --> Presenter
protocol MovieListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func calculateCellSize(_ collectionViewWidth: CGFloat,
                            horizontalMargin: CGFloat) -> CGSize
    func navigateToMovieDetails(with index: Int)
    var moviesItemsCount: Int { get }
    func getItem(at index: Int) -> MovieListEntity?
    func userReachedEndOfScreen()
    func refreshMovies()
    func didTapFavButton()
}

// Presenter --> Controller
protocol MovieListControllerProtocol: AnyObject {
    func reloadCollectionView()
    func presentError(with message: String)
    func setLoadingIndicatorVisible(_ isVisible: Bool)
    func stopRefreshingIndicator()
    func showBottomSheetAlert(title: String, message: String, actions: [UIAlertAction])
}

// Presenter --> Interactor
protocol MovieListPresenterInteractorProtocol: AnyObject {
    func fetchMoviesList()
    func refreshMovies()
}

// Interactor --> Presenter
protocol MovieListInteractorOutput: AnyObject {
    func didFetchMovies(_ movies: [MovieListEntity], isFirstPage: Bool)
    func didFailToFetchMovies(with error: Error)
    func setLoadingIndicatorVisible(_ isVisible: Bool)
    func stopRefreshingIndicator()
}
// Presenter --> Router
protocol MovieListRouterProtocol: AnyObject {
    func navigateToMovieDetails(for movie: MovieDetailsBuilderInput)
    func navigateToFavoriteScreen(withStaticData isStatic: Bool)
}
