//
//  OnboardingPage.swift
//  Vibez
//
//  Created by Sidney Okine on 04/06/2023.
//

import SwiftUI

struct OnboardingPage: View {
    @State private var activeTab = 0
    let tabCount = 3
    let minDragTranslationForSwipe: CGFloat = 50
    @State private var showSignin = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                withAnimation{
                    TabView(selection: $activeTab) {
                        ForEach(0..<OnboardingViewItems.displays.count, id: \.self) { index in
                            VStack(alignment: .center) {
                                OnboardingView(image: OnboardingViewItems.displays[index].name)
                                OnboardingViewLabel(header: OnboardingViewItems.displays[index].header, label: OnboardingViewItems.displays[index].description)
                            }
                            .highPriorityGesture(DragGesture().onEnded { value in
                                withAnimation{
                                    self.handleSwipe(translation: value.translation.width)
                                }
                            })
                            .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.height/2.0)
                }
                .animation(.easeIn)

                VStack(spacing: 25) {
                    HStack(spacing: 10) {
                        ForEach(0..<3, id: \.self) { index in
                            Rectangle()
                                .fill(index == self.activeTab ? Color(Strings.appColor) : Color(Strings.gray))
                                .frame(width: 10, height: 10)
                                .cornerRadius(10)
                                .animation(.linear)
                        }
                    }
                    ZStack {
                        ForEach(0..<3, id: \.self) { index in
                            Capsule()
                                .fill(Color(Strings.appColor))
                                .frame(width: self.activeTab != 2 ? 65 : 230, height: 50)
                                .animation(.easeIn)
                        }
                        Button(action: {
                            if self.activeTab != 2 {
                                self.activeTab = self.activeTab + 1
                            } else {
                                
                            }
                        }) {
                            Text(self.activeTab != 2 ? "\(Image(systemName: "chevron.right"))" : "Create an account")
                                .font(.custom(self.activeTab != 2 ? Strings.appFontRegular : Strings.appFontBold, size: self.activeTab != 2 ? 28:20))
                                .foregroundColor(Color.white)
                                .animation(.easeIn)
                           
                        }
                    }
                    HStack{
                            Text("Already have an account?")
                                .font(.custom(Strings.appFontRegular, size: 18))
                                .foregroundColor(Color(Strings.onboardingLabelColour))
                        Button(action: {
                            
                        }) {
                            Text("Sign In")
                                .font(.custom(Strings.appFontBold, size: 18))
                                .foregroundColor(Color(Strings.appColor))
                        }
                    }
                    .padding(.top,10)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private func handleSwipe(translation: CGFloat) {
        if translation > minDragTranslationForSwipe && activeTab > 0 {
            activeTab -= 1
        } else  if translation < -minDragTranslationForSwipe && activeTab < tabCount-1 {
            activeTab += 1
        }
    }
}
struct OnboardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPage()
    }
}

