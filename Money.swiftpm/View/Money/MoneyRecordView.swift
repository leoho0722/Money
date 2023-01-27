import SwiftUI

@available(iOS 16.0, *)
struct MoneyRecordView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: MoneyRecord.entity(),
        sortDescriptors: []
    ) private var moneyRecords: FetchedResults<MoneyRecord>
    
    /// 判斷是否顯示 BottomSheet
    @State private var isPresentBottomSheet: Bool = false
    
    /// DatePicker 選到的日期，預設為當前日期
    @State private var selectedDate: Date = .now
    
    /// 根據 DatePicker 選到的日期，去改變要進行 Filter 的值
    @State private var dateFilter: String = Date.now.toString()
    
    var body: some View {
        NavigationStack {
            VStack {
                if moneyRecords.count > 0 {
                    DatePicker(selection: $selectedDate,
                               in: ...Date(),
                               displayedComponents: .date) {}
                        .frame(maxHeight: 350)
                        .datePickerStyle(.graphical)
                        .environment(\.locale, Locale.preferredLocale)
                        .onChange(of: selectedDate) { newValue in
                            print("現在選擇到的日期為：", newValue.toString())
                            dateFilter = newValue.toString()
                        }
                    
                    FilteredList(filterKey: "createdAt",
                                 filterValue: dateFilter,
                                 delete: deleteRecord(indexSet:)) { (record: MoneyRecord) in
                        NavigationLink {
                            DetailMoneyRecordView(moneyRecord: record)
                        } label: {
                            MoneyRecordCellView(record: record)
                        }
                    }.padding(.bottom)
                } else {
                    buildNoRecordView()
                }
            }
            .navigationTitle("記帳一下")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        // 點了要跳出 bottomSheet
                        isPresentBottomSheet.toggle()
                    } label: {
                        Image(sfSymbols: .plus)
                            .resizable(resizingMode: .tile)
                    }
                }
            }
            .sheet(isPresented: $isPresentBottomSheet) {
                NewMoneyRecordView(isPresentBottomSheet: $isPresentBottomSheet)
                    .presentationDetents([.large])
            }
        }
    }
    
    /// 建構無記帳資料的畫面
    @ViewBuilder private func buildNoRecordView() -> some View {
        VStack {
            Label("目前尚無記帳資料！", sfSymbols: .money)
                .padding()
        }
    }
    
    private func deleteRecord(indexSet: IndexSet) {
        for index in indexSet {
            let record = moneyRecords[index]
            viewContext.delete(record)
        }
        
        do {
            try viewContext.save()
            print("刪除記帳成功！")
        } catch {
            print("刪除記帳失敗，Error：\(error.localizedDescription)")
        }
    }
}
