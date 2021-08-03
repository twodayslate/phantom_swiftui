//
//  ContentView.swift
//  Shared
//
//  Created by Zachary Gorak on 7/29/21.
//

import SwiftUI
import CoreData

//extension Color {
//    static var phantomPurple: Color {
//        return Color(UIColor(red: 0x94/0xff, green: 0, blue: 0xff, alpha: 1.0))
//    }
//}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State var scrollOffset: CGFloat = 0
    @State var headerSize: CGSize = .zero
    @State var priceSize: CGSize = .zero
    @State var topSafeArea: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .top){
            GeometryReader { proxy -> Color in
                print("safe area", proxy.safeAreaInsets)
                DispatchQueue.main.async {
                    
                    topSafeArea = proxy.safeAreaInsets.top
                    
                }
                return .clear
            }
            ScrollView {
                // Fake Navigation Header
                VStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        ZStack {
                            HStack(alignment: .center) {
                                //GeometryReader { proxy in
                                Spacer()
                                
                                Text("Wallet 1").font(.headline).bold().foregroundColor(.accentColor).padding(.horizontal).background(GeometryReader { proxy -> Color in
                                    
                                    DispatchQueue.main.async {
                                        withAnimation {
                                            headerSize = proxy.size
                                        }
                                    }
                                    
                                    return .clear
                                })
                                .offset(x: self.scrollOffset >= 0 ? 0 : -(UIScreen.main.bounds.midX - self.headerSize.width/2) * self.headerPercentage)
                                .offset(y: headerSize.height/3 * self.headerPercentage)
                                
                                Spacer()
                            }
                            HStack(alignment: .center) {
                                //GeometryReader { proxy in
                                
                                Spacer()
                                    
                                Text("$17,382.82").transition(AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing))).padding(.horizontal)
                                    .offset(x: self.scrollOffset >= 0 ? 100 : 100 * (1.0-self.headerPercentage))
                                    .offset(y: headerSize.height/3 * self.headerPercentage)
                                
                                
                            }
                        }
                        
                        
                        HStack(alignment: .center) {
                            Spacer()
                            //if self.scrollOffset >= 0 {
                            Text("1fRFgFkx7-Y9EKu7W9efmLalK_XFXqV10s5wTlZIp60").foregroundColor(.gray).font(.caption2)
                                .padding(.bottom, 4.0)
                                .transition(AnyTransition.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)).combined(with: .opacity))
                                .opacity(self.scrollOffset >= 0 ? 1.0 : 1.0-Double(self.headerPercentage))
                            //}
                            Spacer()
                        }
                        
                    }.padding(.top, topSafeArea)

                    Divider()
                }
                .background(Color(UIColor.secondarySystemBackground))
                .offset(y:-self.scrollOffset)
                .zIndex(1.0).background(GeometryReader { proxy -> Color in
                    let minY = proxy.frame(in: .global).minY
                    //print("header", proxy.frame(in: .global), proxy.frame(in: .local))
                    print(minY, self.headerPercentage, proxy.safeAreaInsets.top)
                    DispatchQueue.main.async {
                        //withAnimation {
                            self.scrollOffset = minY
                        //}
                    }
                    
                    return .clear
                })
                    
                    VStack {
                        Text("$17,382.82").font(.largeTitle).bold()
                        HStack {
                            Spacer()
                            Text("+$1,399.22").font(.title3).foregroundColor(.green)
                            Text("+13.3%").font(.title3).foregroundColor(.green).padding(4.0).background(Color.green.opacity(0.2)).cornerRadius(8.0)
                            Spacer()
                        }
                    }.padding()
                    .background(GeometryReader { proxy -> Color in
                        
                        DispatchQueue.main.async {
                            withAnimation {
                                priceSize = proxy.size
                            }
                        }
                        
                        return .clear
                    })
                    .opacity(self.scrollOffset >= 0 ? 1.0 : 1.0-Double(self.headerPercentage)).zIndex(0.0)
                    
                    ForEach(0..<10) { _ in
                        HStack(alignment: .center) {
                            
                            Image(systemName: "bitcoinsign.circle.fill").imageScale(.large)
                            
                            VStack(alignment: .leading) {
                                Text("Solana").font(.headline)
                                Text("3.14 SOL").foregroundColor(.gray).font(.callout)
                            }
                            Spacer()
                            VStack(alignment:.trailing) {
                                Text("$10,389.92")
                                Text("+1,399.22").foregroundColor(.green)
                            }.font(.subheadline)
                        }.padding().background(Color(UIColor.secondarySystemFill)).cornerRadius(8.0).padding([.horizontal])
                        
                    }
                }
                .ignoresSafeArea()
            VStack {
                Spacer()
                HStack {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        HStack {
                            Spacer()
                            Image(systemName: "tray.and.arrow.down")
                            Text("Recieve").bold()
                            Spacer()
                        }
                        
                    }).padding(8.0).background(Color(UIColor.secondarySystemBackground)).cornerRadius(8).overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(UIColor.separator), lineWidth: 1.0))
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        HStack {
                            Spacer()
                            Image(systemName: "paperplane")
                            Text("Send").bold()
                            Spacer()
                        }
                    }).padding(8.0).background(Color(UIColor.secondarySystemBackground)).cornerRadius(8).overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(UIColor.separator), lineWidth: 1.0))
                }.padding(.horizontal, 6.0).padding(.vertical)
            }
        }
    }
    
    
    var headerPercentage: CGFloat {
        if self.scrollOffset > 0 {
            return 0
        }
        
        return min(1.0, (abs(self.scrollOffset) / priceSize.height))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).preferredColorScheme(.dark)
        }
    }
}
