//
//  MainTableViewController.swift
//  SDKTest2
//
//  Created by 古賀貴伍 on 2021/05/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


final class MainTableViewController: UIViewController {
    
    var viewModel:MainTableViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationMenuButton: UIButton!
    private let startAllTest = PublishRelay<Void>()
    var delegate:FlowDelegate!
    
    private var dataSource: RxTableViewSectionedReloadDataSource<MainTableSectionModel>!
    private var bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()
        self.bind()
        self.bindViewModel()
    }
    
    private func bind() {
        tableView.rx.itemSelected
            .map { index -> testSectionItem in
                return (self.dataSource[index])
            }
            .subscribe(onNext: { [weak self] item in
                switch item {
                case .header(title: let title, testCaseV4s: let testCases):
                    let controller = R.storyboard.testCaseList.testCaseListViewController()!
                    controller.viewModel = TestCaseListViewModel(testCaseGroupTitle: title, testCases: testCases)
                    self?.navigationController?.pushViewController(controller, animated: true)
                case .allTest(title: _):
                    self?.view.makeToastActivity(.center)
                    self?.view.makeToast("テスト実行開始")

                    self?.startAllTest.accept(())
                default:break
                }
            })
            .disposed(by: bag)
        
        navigationMenuButton.rx.tap
            .subscribe(onNext: { [weak self] in
                let controller = R.storyboard.sideMemuViewController.sideMamuViewController()!
                controller.delegate = self
                self?.navigationController?.present(controller, animated: true)
            })
            .disposed(by: bag)
        
    }
    
    private func initView(){
        self.registerCell()
        self.setTitle("TestCase一覧",andImage: R.image.menu())
        // テーブルビューの件数が少ないときの余白対応
        self.tableView.tableFooterView = UIView()
    }
    
    private func registerCell(){
        self.registerCell(self.tableView)
        self.dataSource = self.setDataSource()
    }
    
    private func bindViewModel() {
        let input = MainTableViewModel.Input(
            trigger: self.viewWillAppearTrigger,
            startAllTest: self.startAllTest.asObservable()
        )
        
        let output = self.viewModel.transform(input: input)
        output.testJson
            .drive(self.tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: bag)
        
        
        output.test
            .drive( onNext: {
                self.view.hideToastActivity()
                self.delegate.move(moveMassage: .history)
            })
            .disposed(by: bag)
        
    }
    
}
extension MainTableViewController: UITableViewDelegate {}

extension MainTableViewController {
    
    func setDataSource() -> RxTableViewSectionedReloadDataSource<MainTableSectionModel> {
        return RxTableViewSectionedReloadDataSource<MainTableSectionModel> (
            configureCell: { [weak self] (_, table, indexPath, item) in
                guard let controller = self else {
                    return UITableViewCell()
                }
                switch item {
                case .header(title: let title, testCaseV4s: _):
                    return controller.createCell(table, for:indexPath, title: title)
                case .allTest(title: _):
                    return controller.createCell(table, for:indexPath, title: "一括テスト")
                }
            }
        )
    }
    
}

extension MainTableViewController {
    private func createCell(_ tableView: UITableView,
                                 for indexPath: IndexPath,
                                 title: String) -> HeaderCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.headerCell.identifier, for: indexPath) as! HeaderCell
        cell.set(index: indexPath, title: title)
        cell.selectionStyle = .none
        return cell
    }
}


extension MainTableViewController:SideMamuVDelegate {
    func moveToSetting() {
        self.dismiss(animated: true)
        self.delegate.move(moveMassage: .Setting)
    }
    func moveToTestTable() {
        self.dismiss(animated: true)
    }
    func moveToHistory() {
        self.dismiss(animated: true)
        self.delegate.move(moveMassage: .history)
    }
}
