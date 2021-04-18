//
//  ViewController.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 16/04/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let useCase = GetMovieDetailsUseCase(api: MovieRoutes())
        useCase.execute(id: 550, success: { [weak self] movie in
            print(movie)
            }, failure: { [weak self] (error) in
                print(error)
        })
    }


}

