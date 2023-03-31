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
    ) private var incomeRecords: FetchedResults<MoneyRecord> // 0 = Income
    
    @FetchRequest(
        entity: MoneyRecord.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "recordType == %@", "1")
    ) private var expenditureRecords: FetchedResults<MoneyRecord> // 1 = Expenditure
    
    @ObservedObject private var vm = HistoryChartViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            NavigationStack {
                List {
                    Section("Revenue，Total revenue $\(vm.totalIncomePrice)") {
                        if vm.incomeData.count > 0 {
                            buildBarMark(data: vm.incomeData, proxy: proxy)
                        } else {
                            buildNoDataView(type: .income)
                        }
                    }
                    
                    Section("Expenditure，Total cost $\(vm.totalExpenditurePrice)") {
                        if vm.expenditureData.count > 0 {
                            buildBarMark(data: vm.expenditureData, proxy: proxy)
                        } else {
                            buildNoDataView(type: .expenditure)
                        }
                    }
                }
                .navigationTitle("Billing Charts")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    calcIncome()
                    calcExpenditure()
                }
            }
        }
    }
}

// MARK: - HistoryChartView @ViewBuilder

@available(iOS 16.0, *)
extension HistoryChartView {
    
    /// 建構無記帳資料時，Chart 要顯示的畫面
    /// - Parameters:
    ///   - type: AppDefine.RecordType，收入 or 支出
    @ViewBuilder private func buildNoDataView(type: AppDefine.RecordType) -> some View {
        VStack {
            Label("Currently there is no \(type.title) billing information!", sfSymbols: .xmark)
        }
    }
    
    /// 建構 `收入資料 or 支出資料` 的 BarMark 圖表
    /// - Parameters:
    ///   - data: 收入資料 or 支出資料
    ///   - proxy: 整個畫面的高度
    @ViewBuilder private func buildBarMark(data: [Record], proxy: GeometryProxy) -> some View {
        VStack {
            Chart {
                ForEach(data) { record in
                    BarMark(
                        x: .value("Type", record.name),
                        y: .value("Price", record.price)
                    )
                    .foregroundStyle(by: .value("Type", record.name))
                    .annotation {
                        Text("\(record.price)")
                    }
                }
            }
            .chartXAxisLabel("Type", alignment: .leading)
            .chartYAxisLabel("Price", alignment: .trailing)
            .frame(height: 300)
            .padding()
            
            List {
                ForEach(data) { record in
                    HStack {
                        Label("\(record.name)", sfSymbols: .menucard)
                        Spacer()
                        Text("$\(record.price)")
                    }
                }
            }
            .listStyle(.plain)
            .frame(minHeight: calcMinHeight(data: data, proxy: proxy))
        }
    }
}

// MARK: - HistoryChartView calc Function

@available(iOS 16.0, *)
extension HistoryChartView {
    
    /// 計算／彙整收入資料
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
        print("========Income=========")
        print(vm.incomeData)
        print("========Income=========\n")
        #endif
    }
    
    /// 計算／彙整支出資料
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
        print("========Expenditure=========")
        print(vm.expenditureData)
        print("========Expenditure=========\n")
        #endif
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
        } else if data.count == 4 {
            // 4
            print(proxy.size.height / 4)
            return proxy.size.height / 4
        } else if data.count == 3 {
            // 3
            print(proxy.size.height / 5)
            return proxy.size.height / 5
        } else if data.count == 2 {
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
