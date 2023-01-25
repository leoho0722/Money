import SwiftUI

@available(iOS 16.0, *)
struct MoneyRecordView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: MoneyRecord.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \MoneyRecord.createTimestamp, ascending: true)
        ]
    ) private var moneyRecords: FetchedResults<MoneyRecord>
    
    /// 判斷是否顯示 BottomSheet
    @State private var isPresentBottomSheet: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(moneyRecords) { record in
                        NavigationLink {
                            DetailMoneyRecordView(moneyRecord: record)
                        } label: {
                            VStack(alignment: .leading) {
                                Text("記帳類型：\(AppDefine.RecordType.allCases[Int(record.recordType)!].title)")
                                Text("記帳日期：\(Date(timestamp: record.createTimestamp))")
                                Text("記帳分類：\(AppDefine.Category.allCases[Int(record.itemName)!].title)")
                                Text("記帳金額：\(record.itemPrice)")
                                Text("記帳備註：\(record.notes)")
                            }
                        }
                    }.onDelete(perform: deleteRecord(indexSet:))
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
                    .presentationDetents([.medium, .large])
            }
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
