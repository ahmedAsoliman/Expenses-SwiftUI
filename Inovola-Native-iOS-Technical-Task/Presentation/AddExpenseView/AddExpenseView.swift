//
//  AddExpenseView.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 18/08/2025.
//

import SwiftUI
import UIKit

struct AddExpenseView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var receiptImage: UIImage? = nil
    @State private var showImagePicker = false
    @State private var showDatePicker = false
    @StateObject var viewModel: AddExpenseViewModel = AddExpenseViewModel()
     @State private var showToast = false
    @State private var toastMessage = ""
    @State private var toastType: ToastType = .success

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                 Text("Category")
                    .font(.system(size: 16, weight: .semibold))

                Menu {
                    ForEach(viewModel.categories) { category in
                        Button(category.name ?? "Category") {
                            viewModel.selectedCategory = category
                        }
                    }
                } label: {
                    HStack {
                        Text(viewModel.selectedCategory?.name ?? "Select a category")
                            .foregroundColor(.gray)
                        Spacer()
                        Image(systemName: viewModel.selectedCategory?.iconName ?? "chevron.down")
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                }
                 Text("Amount")
                    .font(.system(size: 16, weight: .semibold))

                TextField("EGP 50", text: $viewModel.amount)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)

                 Text("Date")
                    .font(.system(size: 16, weight: .semibold))

                Button(action: { showDatePicker.toggle() }) {
                    HStack {
                        Text(dateFormatted)
                            .foregroundColor(.gray)
                        Spacer()
                        Image(systemName: "calendar")
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                }

                if showDatePicker {
                    DatePicker("", selection: $viewModel.date, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding(.bottom)
                }

                 Text("Attach Receipt")
                    .font(.system(size: 16, weight: .semibold))

                Button(action: { showImagePicker = true }) {
                    HStack {
                        Text(receiptImage == nil ? "Upload image" : "Image Attached")
                            .foregroundColor(.gray)
                        Spacer()
                        Image(systemName: "camera")
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                }

                 Text("Categories")
                    .font(.system(size: 16, weight: .semibold))

                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 4), spacing: 20) {
                    ForEach(viewModel.categories, id: \.objectID) { item in
                        VStack {
                            ZStack {
                                Circle()
                                    .fill(viewModel.selectedCategory?.objectID == item.objectID ? Color.blue : Color(hex: item.colorHex ?? "#F5F5F5"))
                                    .frame(width: 60, height: 60)
                                Image(systemName: item.iconName ?? "questionmark")
                                    .foregroundColor(viewModel.selectedCategory?.objectID == item.objectID ? .white : .gray)
                            }
                            Text(item.name ?? "")
                                .font(.system(size: 12))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                        }
                        .onTapGesture { viewModel.selectedCategory = item }
                    }
                }

                 Button(action: {
                     Task{
                         await viewModel.saveExpense()
                     }
                }) {
                    HStack {
                        if viewModel.isSaving { ProgressView().tint(.white) }
                        Text(viewModel.isSaving ? "Saving..." : "Save")
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isSaving ? Color.blue.opacity(0.6) : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .disabled(viewModel.isSaving)
                .padding(.top, 30)
            }
            .padding()
        }
        .onAppear {
            Task{
                await viewModel.loadCategories()
            }
        }

        .toast(isPresented: $viewModel.showMessage, message: toastMessage, type: toastType)

         .onChange(of: viewModel.errorMessage) { msg in
            guard let msg, !msg.isEmpty else { return }
            toastType = .error
            toastMessage = msg
             DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                 viewModel.showMessage = false
                 viewModel.errorMessage  = ""
                 
             }
        }
        .onChange(of: viewModel.didSave) { saved in
            guard saved else { return }
            toastType = .success
            toastMessage = "Expense saved successfully."
              DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                dismiss()
            }
        }

        .navigationBarTitle("Add Expense", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: { dismiss() }) {
            Image(systemName: "chevron.left").foregroundColor(.black)
        })
        .sheet(isPresented: $showImagePicker) {
            ImagePickerView(image: $receiptImage)
        }
    }

    var dateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: viewModel.date)
    }
}
