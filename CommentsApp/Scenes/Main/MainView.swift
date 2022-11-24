//
//  MainView.swift
//  CommentsApp
//
//  Created by Vladyslav Liubov on 23.11.2022.
//

import SwiftUI
import Combine

extension MainViewController {
    
    struct ContainerView: View {
        
        @ObservedObject var viewModel: ViewModel
        
        init(_ viewModel: ViewModel) {
            self._viewModel = .init(initialValue: viewModel)
        }
        
        public var body: some View {
            
            let alertBinding = Binding<Bool>(
              get: { viewModel.state.showAlert },
              set: { viewModel.action(.updateShowAlert($0)) }
            )
            
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                if !viewModel.state.indicatorShow {
                    titleView
                    firstTextView
                    secondTextView
                    button
                    } else {
                    ActivityIndicator()
                            .padding(.top, 100)
                    cancelButtonView
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(
                LinearGradient(colors: [.blue, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .hueRotation(.degrees(0))
                    .edgesIgnoringSafeArea(.all)
            )
            .alert(isPresented: alertBinding) {
                Alert(
                    title: Text("Download Comments"),
                    message: Text(viewModel.state.alertText),
                    dismissButton: .cancel(Text("OK"), action: {
                        alertBinding.wrappedValue = false
                    })
                )
            }
        }
        
        //Title
        private var titleView: some View {
            Text("Main")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.orange)
                .padding(.top, 50)
                .padding(.bottom, 50)
        }
        
        //Cancel Button
        private var cancelButtonView: some View {
            Button {
                viewModel.action(.cancelDownloadComments)
            } label: {
                Text("Cancel download")
                    .bold()
                    .foregroundColor(.white)
            }
            .padding(.top, 10)
        }
        
        //First TextField
        private var firstTextView: some View {
            
            let firstNumberBinding = Binding<String>(
              get: { viewModel.state.firstNumber },
              set: { viewModel.action(.updateFirstNumber($0)) }
            )
            
            return VStack {
                HStack (alignment: .center) {
                    TextField("First number", text: firstNumberBinding)
                        .keyboardType(.numberPad)
                        .colorScheme(.light)
                        .padding(.leading, 70)
                    
                }
                .padding(.top, 10)
                .frame(height: 40)
                .overlay (
                    HStack{
                        Text("L")
                            .foregroundColor(.orange)
                        Spacer()
                    }
                        .padding(.top, 10)
                        .padding(.leading, 18)
                )
            }
            .padding(.bottom, 10)
            .cornerRadius(15)
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 20)
            )
        }
        
        //Second TextField
        private var secondTextView: some View {
            
            let secondNumberBinding = Binding<String>(
              get: { viewModel.state.secondNumber },
              set: { viewModel.action(.updateSecondNumber($0)) }
            )
            
            return VStack {
                HStack (alignment: .center) {
                    TextField("Second number", text: secondNumberBinding)
                        .keyboardType(.numberPad)
                        .colorScheme(.light)
                        .padding(.leading, 70)
                    
                }
                .padding(.top, 10)
                .frame(height: 40)
                .overlay (
                    HStack{
                        Text("U")
                            .foregroundColor(.orange)
                        Spacer()
                    }
                        .padding(.top, 10)
                        .padding(.leading, 18)
                )
            }
            .padding(.bottom, 10)
            .cornerRadius(15)
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 20)
            )
        }
        
        //Button
        private var button: some View {
            
            let validNumbersBinding = Binding<Bool>(
              get: { viewModel.state.validNumbers },
              set: { _ in }
            )
            
           return VStack {
                Button {
                    validNumbersBinding.wrappedValue ? viewModel.getComments() : nil
                } label: {
                    Text("Show comments")
                        .padding()
                        .font(.body.weight(.semibold))
                        .foregroundColor(validNumbersBinding.wrappedValue ? Color.white : Color.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(validNumbersBinding.wrappedValue ? Color.orange : Color.gray)
                        .cornerRadius(12)
                        .frame(height: 70)
                }
            }
            .padding(.horizontal, 30)
            .padding(.top, 20)
        }
    }
}

