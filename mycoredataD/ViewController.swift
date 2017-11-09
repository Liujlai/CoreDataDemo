//
//  ViewController.swift
//  mycoredataD
//
//  Created by idea on 2017/11/8.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit
import CoreData
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!    
    @IBAction func btnT(_ sender: Any) {
        let url = URL(string:"http://blog.csdn.net/xyxjn/article/details/50662559")
        let request = URLRequest(url:url!)
        
        self.webView.loadRequest(request)
    }
    @IBAction func btn(_ sender: Any) {
        let url = URL(string:"http://www.hangge.com/blog/cache/detail_767.html")
        let request = URLRequest(url:url!)
        self.webView.loadRequest(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取管理的数据上下文 对象
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        //创建User对象
        let user = NSEntityDescription.insertNewObject(forEntityName: "User",
                                                       into: context) as! User
        
        //对象赋值
        user.id = 1
        user.username = "张三"
        user.password = "123456"
       
        
        //保存
        do {
            try context.save()
            print("保存成功！")
        } catch {
            fatalError("不能保存：\(error)")
        }
        
//        声明数据的请求
        let fetchRequest =  NSFetchRequest<User>(entityName: "User")
//        设置查询条件
        let predicate = NSPredicate(format: "username = 'hangge' ", "")
        fetchRequest.predicate = predicate
        

        do{
            let fetchObjects = try context.fetch(fetchRequest)
            //        查询操作
            for info in fetchObjects{
                print("id = \(info.id)")
                print("用户名 ： \(info.username ?? "" )")
                print("密码： \(info.password  ?? "" )")
            }
            /*
//            修改操作
//                    便利查询结果
            for info in fetchObjects {
                info.password = "asdfgh"
                try context.save()
            }
            
            */
             //            删除操作
            for info in fetchObjects{
                context.delete(info)
            }
            try context.save()
 
        }catch{
            fatalError("不能保存：\(error)")
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

