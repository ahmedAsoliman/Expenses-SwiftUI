//
//  ExpenseItemRow.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 18/08/2025.
//
import SwiftUI
struct ExpenseItemRow: View {
var record: Expense
    var body: some View {
        HStack {
            Image(systemName: record.category?.iconName ?? "")
                .frame(width: 40, height: 40)
                .background(Color(hex: record.category?.colorHex ?? "f1faee"))
                .cornerRadius(20)
                .foregroundColor(.blue)

            VStack(alignment: .leading, spacing: 4) {
                Text(record.category?.name ?? "")
                    .font(.subheadline.bold())
                Text("Manually")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text("-$"+record.convertedAmount.toRoundedString())
                    .bold()
                Text(record.date?.formatted() ?? "")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.03), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
}
