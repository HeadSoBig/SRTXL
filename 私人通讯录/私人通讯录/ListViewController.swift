//
//  ListViewController.swift
//  私人通讯录
//
//  Created by 王军波 on 16/6/29.
//  Copyright © 2016年 王军波. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    var personList = [Person]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData { (list) in
            print(list)
            
            self.personList += list
            
            self.tableView.reloadData()
        }
    }

    // 模拟异步加载数据  使用闭包  要传一个数据数组回去 所以闭包参数为一个数组
    private func loadData(completion:(list:[Person])->()) {
        
        // 异步
        DispatchQueue.global().async { 
            print("正在努力加载")
            Thread.sleep(forTimeInterval: 1)
            
            var arrayM = [Person]()
            for i in 0..<20 {
                // 创建模型
                let p = Person()
                // 设置模型属性
                p.name = "person - \(i)"
                p.phone = "1836613" + String(format: "%04d", arc4random_uniform(10000))
                p.title = "boss - \(i)"
                
                arrayM.append(p)
            }
            
           // 主线程回调  执行闭包
            DispatchQueue.main.async(execute: { 
                completion(list: arrayM)
            })
        }
    }
    
    
    // MARK: - 数据源方法
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return personList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        cell.textLabel?.text = personList[indexPath.row].name
        cell.detailTextLabel?.text = personList[indexPath.row].phone
        return cell
    }
    
    
    // MARK: - 代理方法
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 执行 segue
        performSegue(withIdentifier: "list2detail", sender: indexPath)
    }
    
    // MARK: - 控制器跳转方法
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // as! / as? 直接根据前面的返回值是否有?
        let vc = segue.destinationViewController as! DetailViewController
        
        // 给要跳转的控制器 vc 设置选中的 person 根据 indexPath
        // 只要是 if let / guard let 判空语句  一律使用 as?
        if let indexPath = sender as? IndexPath {
            
            vc.person = personList[indexPath.row]
        }
    }
}
