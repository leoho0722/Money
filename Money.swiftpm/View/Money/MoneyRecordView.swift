import SwiftUI

@available(iOS 16.0, *)
struct MoneyRecordView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: MoneyRecord.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \MoneyRecord.createdAt, ascending: true)
        ]
    ) private var moneyRecords: FetchedResults<MoneyRecord>
    
    /// 判斷是否顯示 BottomSheet
    @State private var isPresentBottomSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if moneyRecords.count > 0 {
                    List {
                        ForEach(moneyRecords) { record in
                            NavigationLink {
                                DetailMoneyRecordView(moneyRecord: record)
                            } label: {
                                MoneyRecordCellView(record: record)
                            }
                        }.onDelete(perform: deleteRecord(indexSet:))
                    }
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
