//
//  CommentsView.swift
//  CommentsApp
//
//  Created by Vladyslav Liubov on 23.11.2022.
//

import SwiftUI
import Combine

extension CommentsViewController {
    
    struct ContainerView: View {
        
        @ObservedObject var viewModel: ViewModel
        
        init(_ viewModel: ViewModel) {
            self._viewModel = .init(initialValue: viewModel)
        }
        
        public var body: some View {
            
            VStack {
                navBar
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 12) {
                        listComments
                        loadingView
                    }
                }
                .padding(.horizontal, 30)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(
                LinearGradient(colors: [.blue, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .hueRotation(.degrees(0))
                    .edgesIgnoringSafeArea(.all)
            )
        }
        
        //NavBar
        private var navBar: some View {
            CustomNavBar {
                Button {
                    viewModel.action(.back)
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.orange)
                }
            } center: {
                Text("Comments")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.orange)
                
            } right: {
                
            }
            .padding(.horizontal, 20)
            .padding(.top, 15)
        }
        
        //List Comments
        private var listComments: some View {
            ForEach(viewModel.state.comments, id: \.id) { comment in
                VStack {
                    Text(comment.id!.description)
                    Text(comment.email!)
                    Divider()
                        .frame(height: 1)
                        .overlay(Color.orange)
                    Text(comment.body!)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color.white)
                )
            }
            .multilineTextAlignment(.leading)
        }
        
        //Loading
        private var loadingView: some View {
            
            let loadingBinding = Binding<Bool>(
                get: { viewModel.state.showLoading },
                set: { _ in }
            )
            
            return VStack {
                if loadingBinding.wrappedValue {
                    Text("Loading...")
                        .onAppear(
                            perform: {
                                Task {
                                    try? await Task.sleep(nanoseconds: 0_500_000_000)
                                    viewModel.getComments()
                                }
                            }
                        )
                }
            }
        }
    }
}
