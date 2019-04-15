//
//  ItemListViewController.swift
//  SalesTaxCalc
//
//  Created by Matthew Wilkinson on 15/4/19.
//  Copyright © 2019 Some Robots. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    
    private(set) var viewModel: ItemListViewModel
    @IBOutlet weak var statePicker: UIPickerView!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 60
            tableView.rowHeight = UITableView.automaticDimension
            tableView.register(UINib(nibName: "ItemTableViewCell", bundle: .main),
                               forCellReuseIdentifier: "cell")
        }
    }
    
    init(viewModel: ItemListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ItemListViewController", bundle: .main)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didRequestNewProduct))
    }
    
    @objc func didRequestNewProduct() {
        viewModel.didRequestNewProduct?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindToViewModel() {
        viewModel.reloadBlock = { [weak self] in
            self?.tableView.reloadData()
        }
        if let index = viewModel.stateCodes.firstIndex(of: viewModel.selectedState) {
            statePicker.selectRow(index, inComponent: 0, animated: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
    }

}

extension ItemListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? viewModel.list.count: 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemTableViewCell
        if indexPath.section == 0 {
            let cellViewModel = viewModel.list[indexPath.row]
            cell.display(cellViewModel)
        } else {
            cell.display(ItemViewModel(title: viewModel.totalBill))
        }
        return cell
    }
}

extension ItemListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Items" : "Total Price"
    }
}

extension ItemListViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.stateCodes.count
    }
}

extension ItemListViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let code = viewModel.stateCodes[row]
        return viewModel.stateNameFor(code: code)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let code = viewModel.stateCodes[row]
        viewModel.selectedState = code
    }
}
