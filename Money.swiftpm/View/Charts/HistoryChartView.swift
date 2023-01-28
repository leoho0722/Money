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
        GeometryReader { proxy in
            NavigationStack {
                List {
                    Section("收入，總收入 $\(vm.totalIncomePrice)") {
                        if vm.incomeData.count > 0 {
                            VStack {
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
                                
                                List {
                                    ForEach(vm.incomeData) { incomeRecord in
                                        HStack {
                                            Label("\(incomeRecord.name)", sfSymbols: .filter)
                                            Spacer()
                                            Text("$\(incomeRecord.price)")
                                        }
                                    }
                                }
                                .listStyle(.plain)
                                .frame(minHeight: calcMinHeight(data: vm.incomeData, proxy: proxy))
                            }
                        } else {
                            buildNoDataView(type: .income)
                        }
                    }
                    
                    Section("支出，總花費 $\(vm.totalExpenditurePrice)") {
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
                            
                            List {
                                ForEach(vm.expenditureData) { expenditureRecord in
                                    HStack {
                                        Label("\(expenditureRecord.name)", sfSymbols: .filter)
                                        Spacer()
                                        Text("$\(expenditureRecord.price)")
                                    }
                                }
                            }
                            .listStyle(.plain)
                            .frame(minHeight: calcMinHeight(data: vm.expenditureData, proxy: proxy))
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
    }
    
    /// 建構無記帳資料時，Chart 要顯示的畫面
    /// - Parameters:
    ///   - type: AppDefine.RecordType，收入 or 支出
    @ViewBuilder private func buildNoDataView(type: AppDefine.RecordType) -> some View {
        VStack {
            Label("目前尚無\(type.title)記帳資料！", sfSymbols: .xmark)
        }
    }
    
    
    /// 計算不同類型數量 List 所需的最小顯示高度
    /// - Parameters:
    ///   - data: 收入資料 or 支出資料
    ///   - proxy: 畫面高度
    /// - Returns: 計算完的高度
    private func calcMinHeight(data: [Record], proxy: GeometryProxy) -> CGFloat  {
        if data.count > 6 {
            // 6 以上
            print(proxy.size.height / 2)
            return proxy.size.height / 2
        } else if data.count == 6 {
            // 6
            print(proxy.size.height / 2.5)
            return proxy.size.height / 2.5
        } else if data.count == 5 {
            // 5
            print(proxy.size.height / 3)
            return proxy.size.height / 3
        } else if data.count == 5 {
            // 4
            print(proxy.size.height / 4)
            return proxy.size.height / 4
        } else if data.count == 5 {
            // 3
            print(proxy.size.height / 5)
            return proxy.size.height / 5
        } else if data.count == 5 {
            // 2
            print(proxy.size.height / 8)
            return proxy.size.height / 8
        } else {
            // 1
            print(proxy.size.height / 14)
            return proxy.size.height / 14
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
        vm.totalIncomePrice = 0
        
        prices.forEach { key, value in
            vm.totalIncomePrice += value
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
        vm.totalExpenditurePrice = 0
        
        prices.forEach { key, value in
            vm.totalExpenditurePrice += value
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
    
    @Published var totalIncomePrice: Int = 0
    
    @Published var totalExpenditurePrice: Int = 0
    
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
