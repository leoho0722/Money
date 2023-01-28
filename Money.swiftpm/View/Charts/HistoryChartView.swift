//
//  HistoryChartView.swift
//  
//
//  Created by Leo Ho on 2023/1/28.
//

import SwiftUI
import Charts

@available(iOS 16.0, *)
struct HistoryChartView: View {
    
    @FetchRequest(
        entity: MoneyRecord.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "recordType == %@", "0")
    ) private var incomeRecords: FetchedResults<MoneyRecord> // 0 = 收入
    
    @FetchRequest(
        entity: MoneyRecord.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "recordType == %@", "1")
    ) private var expenditureRecords: FetchedResults<MoneyRecord> // 1 = 支出
        
    @ObservedObject var vm = HistoryChartViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Section("收入") {
//                    Chart {
//                        ForEach(incomeRecords) { record in
//                            BarMark(
//                                x: .value("類型", AppDefine.Category.allCases[Int(record.itemName) ?? 0].title),
//                                y: .value("金額", record.itemPrice),
//                                stacking: .center
//                            ).foregroundStyle(by: .value("類型", AppDefine.Category.allCases[Int(record.itemName) ?? 0].title))
//                        }
//                    }
//                    .chartXAxisLabel("類型", alignment: .leading)
//                    .chartYAxisLabel("金額", alignment: .trailing)
//                    .frame(height: 300)
//                    .padding()
                    if vm.incomeData.count > 0 {
                        Chart {
                            ForEach(vm.incomeData) { record in
                                BarMark(
                                    x: .value("類型", record.name),
                                    y: .value("金額", record.price)
                                )
                                .foregroundStyle(by: .value("類型", record.name))
                                .annotation {
                                    Text("\(record.price)")
                                }
                            }
                        }
                        .chartXAxisLabel("類型", alignment: .leading)
                        .chartYAxisLabel("金額", alignment: .trailing)
                        .frame(height: 300)
                        .padding()
                    } else {
                        buildNoDataView(type: .income)
                    }
                }
                
                Section("支出") {
//                    Chart {
//                        ForEach(expenditureRecords) { record in
//                            BarMark(
//                                x: .value("類型", AppDefine.Category.allCases[Int(record.itemName) ?? 0].title),
//                                y: .value("金額", record.itemPrice),
//                                stacking: .center
//                            ).foregroundStyle(by: .value("類型", AppDefine.Category.allCases[Int(record.itemName) ?? 0].title))
//                        }
//                    }
//                    .chartXAxisLabel("類型", alignment: .leading)
//                    .chartYAxisLabel("金額", alignment: .trailing)
//                    .frame(height: 300)
//                    .padding()
                    if vm.expenditureData.count > 0 {
                        Chart {
                            ForEach(vm.expenditureData) { record in
                                BarMark(
                                    x: .value("類型", record.name),
                                    y: .value("金額", record.price)
                                )
                                .foregroundStyle(by: .value("類型", record.name))
                                .annotation {
                                    Text("\(record.price)")
                                }
                            }
                        }
                        .chartXAxisLabel("類型", alignment: .leading)
                        .chartYAxisLabel("金額", alignment: .trailing)
                        .frame(height: 300)
                        .padding()
                    } else {
                        buildNoDataView(type: .expenditure)
                    }
                }
            }
            .navigationTitle("記帳圖表")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                calcIncome()
                calcExpenditure()
            }
        }
    }
    
    /// 建構無記帳資料時，Chart 要顯示的畫面
    /// - Parameters:
    ///   - type: AppDefine.RecordType，收入 or 支出
    @ViewBuilder private func buildNoDataView(type: AppDefine.RecordType) -> some View {
        VStack {
            Label("目前尚無\(type.title)記帳資料！", sfSymbols: .xmark)
        }
    }
}

@available(iOS 16.0, *)
extension HistoryChartView {
   
    func calcIncome() {
        var prices: [String : Int] = [
            "0" : 0, "1" : 0, "2" : 0, "3" : 0, "4" : 0, "5" : 0,
        ]
        
        incomeRecords.forEach { record in
            prices[record.itemName]! += Int(record.itemPrice) ?? 0
        }
        
        vm.incomeData = []
        
        prices.forEach { key, value in
            if value > 0 {
                vm.incomeData.append(Record(name: AppDefine.Category.allCases[Int(key)!].title,
                                            price: value))
            }
        }
        
        #if DEBUG
        print("========收入=========")
        print(vm.incomeData)
        print("========收入=========\n")
        #endif
    }
    
    func calcExpenditure() {
        var prices: [String : Int] = [
            "0" : 0, "1" : 0, "2" : 0, "3" : 0, "4" : 0, "5" : 0,
        ]
        
        expenditureRecords.forEach { record in
            prices[record.itemName]! += Int(record.itemPrice) ?? 0
        }
        
        vm.expenditureData = []
        
        prices.forEach { key, value in
            if value > 0 {
                vm.expenditureData.append(Record(name: AppDefine.Category.allCases[Int(key)!].title,
                                                 price: value))
            }
        }
        
        #if DEBUG
        print("========支出=========")
        print(vm.expenditureData)
        print("========支出=========\n")
        #endif
    }
}

class HistoryChartViewModel: ObservableObject {
    
    /// 存放 `收入` 的資料
    @Published var incomeData: [Record] = []
    
    /// 存放 `支出` 的資料
    @Published var expenditureData: [Record] = []
}

struct Record: Identifiable {
    
    let id = UUID()
    
    let name: String
    
    let price: Int
}
