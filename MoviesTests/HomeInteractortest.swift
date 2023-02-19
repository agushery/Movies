//
//  HomeInteractortest.swift
//  MoviesTests
//
//  Created by Agus Hery on 19/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import XCTest
import RxSwift
@testable import Movies

// Mock repository object that conforms to MovieRepositoryProtocol for testing purposes
class MovieRepositoryMock: MovieRepositoryProtocol {
    
    
    var getPopularMoviesReturnValue: Observable<[MovieModel]>?
    var getPopularMoviesCalled = false
    
    func getPopularMovies() -> Observable<[MovieModel]> {
        getPopularMoviesCalled = true
        return getPopularMoviesReturnValue ?? Observable.empty()
    }
    
    var getUpcomingMoviesCompletionReturnValue: Result<[MovieModel], Error>?
    var getUpcomingMoviesCompletionCalled = false
    
    func getUpcomingMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void) {
        getUpcomingMoviesCompletionCalled = true
        if let returnValue = getUpcomingMoviesCompletionReturnValue {
            completion(returnValue)
        }
    }
    
    var searchMoviesCompletionReturnValue: Result<[MovieModel], Error>?
    var searchMoviesCompletionCalled = false
    
    func searchMovies(completion: @escaping (Result<[MovieModel], Error>) -> Void, query: String) {
        searchMoviesCompletionCalled = true
        if let returnValue = searchMoviesCompletionReturnValue {
            completion(returnValue)
        }
    }
    
    var getDetailMovieCompletionReturnValue: Result<DetailMovieModel, Error>?
    var getDetailMovieCompletionCalled = false
    
    func getDetailMovie(completion: @escaping (Result<DetailMovieModel, Error>) -> Void, idMovie: String) {
        getDetailMovieCompletionCalled = true
        if let returnValue = getDetailMovieCompletionReturnValue {
            completion(returnValue)
        }
    }
    
    var getVideosMovieCompletionReturnValue: Result<[VideoModel], Error>?
    var getVideosMovieCompletionCalled = false
    
    func getVideosMovie(completion: @escaping (Result<[VideoModel], Error>) -> Void, idMovie: String) {
        getVideosMovieCompletionCalled = true
        if let returnValue = getVideosMovieCompletionReturnValue {
            completion(returnValue)
        }
    }
}

// Unit tests for HomeInteractor
final class HomeInteractorTests: XCTestCase {
    var interactor: HomeInteractor!
    var repositoryMock: MovieRepositoryMock!
    
    override func setUp() {
        super.setUp()
        repositoryMock = MovieRepositoryMock()
        interactor = HomeInteractor(repository: repositoryMock)
    }
    
    func testGetPopularMovies() {
        let expectation = XCTestExpectation(description: "Get popular movies")
        let expectedMovies = [MovieModel.dummyData]
        repositoryMock.getPopularMoviesReturnValue = Observable.just(expectedMovies)
        
        var movies: [MovieModel] = []
        let disposable = interactor.getPopularMovies().subscribe(onNext: { (results) in
            movies = results
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 1.0)
        disposable.dispose()
        
        XCTAssertTrue(repositoryMock.getPopularMoviesCalled)
        XCTAssertEqual(movies, expectedMovies)
    }

    
    func testGetUpcomingMovies() {
        let expectedMovies = [MovieModel.dummyData]
        repositoryMock.getUpcomingMoviesCompletionReturnValue = .success(expectedMovies)
        
        let expectation = self.expectation(description: "Completion block called")
        var result: [MovieModel]?
        interactor.getUpcomingMovies { response in
            switch response {
            case .success(let movies):
                result = movies
            case .failure(_):
                result = nil
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(repositoryMock.getUpcomingMoviesCompletionCalled)
        XCTAssertEqual(result, expectedMovies)
    }
    
    func testSearchMovies() {
        let expectedMovies = [MovieModel.dummyData]
        repositoryMock.searchMoviesCompletionReturnValue = .success(expectedMovies)
        
        let expectation = self.expectation(description: "Completion block called")
        var result: [MovieModel]? = [MovieModel.dummyData]
        interactor.searchMovies(completion: { response in
            switch response {
            case .success(let movies):
                result = movies
            case .failure(_):
                result = nil
            }
            expectation.fulfill()
        }, query: "searchQuery")
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(repositoryMock.searchMoviesCompletionCalled)
        XCTAssertEqual(result, expectedMovies)
    }
}

