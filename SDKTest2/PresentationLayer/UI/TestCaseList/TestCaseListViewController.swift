//
//  TestCaseListViewController.swift
//  SDKTest2
//
//  Created by Keiji Miyabe on 2021/06/18.
//  Copyright © 2021年 brainpad. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

/// テストケースリスト画面ViewController
final class TestCaseListViewController: UIViewController {

    /// テストケースリスト画面用ViewModel
    var viewModel: TestCaseListViewModel!
    
    // ----------------------------------------
    /// テストケースリスト表示用TableView
    @IBOutlet weak var tableView: UITableView!
    // ----------------------------------------
    /// テストケースリスト用DataSource
    private var dataSource: RxTableViewSectionedReloadDataSource<TestCaseSectionModel>!

    private var bag = DisposeBag()

    // ----------------------------------------
    /// viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initView()
        self.bind()
        self.bindViewModel()
    }


    // ----------------------------------------
    /// 画面の初期化
    private func initView() {
        // テストケース表示セル登録
        self.registerCell(self.tableView)
        // データソース設定
        self.dataSource = self.setDataSource()
        // テーブルビューデリゲート設定(セクションスクロール、セクションセンタリング)
        self.tableView.delegate = self
        // テーブルビューの行サイズの可変化
        tableView.rowHeight = UITableView.automaticDimension
        // テーブルビューの件数が少ないときの余白対応
        tableView.tableFooterView = UIView()
//        // タイトルとメニューボタンを設定
//        menuButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(menuButtonPressed(_:)))
        
//        // タイトルバー設定
//        self.setTitle(TESTHISTORY_VIEW_TITLE, menuButton: menuButton)
    }

//    // ----------------------------------------
//    /// 画面遷移用ボタン押下時処理
//    /// - Parameter sender: 押下されたUIBarButtonItem
//    @objc func menuButtonPressed(_ sender: UIBarButtonItem) {
//
//        let controller = R.storyboard.sideMemuViewController.sideMamuViewController()!
//        controller.delegate = self
//        self.navigationController?.present(controller, animated: true)
//    }
    
    // ----------------------------------------
    /// テーブルビューのコントロールイベントへのバインド
    private func bind() {
        tableView.rx.itemSelected
            .map { index -> TestCaseV4? in
                return (self.dataSource[index])
            }
            .subscribe(onNext: { [weak self] item in
                guard let testCaseV4 = item else {
                    return
                }
                let controller = R.storyboard.parameterEditor.parameterEditorViewController()!
                controller.viewModel = ParameterEditorViewModel(testCaseV4)
                self?.navigationController?.pushViewController(controller, animated: true)
            })
            .disposed(by: bag)
    }
    
    // ----------------------------------------
    /// データのバインド
    private func bindViewModel() {
        let input = TestCaseListViewModel.Input(
            trigger: self.viewWillAppearTrigger
        )
        
        let output = self.viewModel.transform(input: input)
        output.testJson
            .drive(self.tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: bag)
    }
}

extension TestCaseListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textAlignment = .center
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= tableView.sectionHeaderHeight && scrollView.contentOffset.y >= 0 {
            scrollView.contentInset = UIEdgeInsets(top: -scrollView.contentOffset.y, left: 0, bottom: 0, right: 0)
        }
        else if scrollView.contentOffset.y >= tableView.sectionHeaderHeight {
            scrollView.contentInset = UIEdgeInsets(top: -tableView.sectionHeaderHeight, left: 0, bottom: 0, right: 0)
        }
    }
}

extension TestCaseListViewController {
    
    func setDataSource() -> RxTableViewSectionedReloadDataSource<TestCaseSectionModel> {
        return RxTableViewSectionedReloadDataSource<TestCaseSectionModel> (
            configureCell: { [weak self] (_, table, indexPath, item) in
                guard let controller = self else {
                    return UITableViewCell()
                }
                return controller.createCell(table, for:indexPath, item: item)
            },
            titleForHeaderInSection: { [weak self] (dataSource, indexPath) in
                return dataSource.sectionModels[indexPath].header
            }
        )
    }
}

extension TestCaseListViewController {
    private func createCell(_ tableView: UITableView,
                                 for indexPath: IndexPath,
                                 item: TestCaseV4) -> TextViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.textViewCell.identifier, for: indexPath) as! TextViewCell
        cell.set(index: indexPath, testCaseV4: item)
        return cell
    }
}
