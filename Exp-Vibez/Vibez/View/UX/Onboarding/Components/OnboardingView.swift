//
//  OnboardingView.swift
//  Vibez
//
//  Created by Sidney Okine on 04/06/2023.
//

import SwiftUI

struct OnboardingView: View {
    let image : String
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 200,height: 325)
                .cornerRadius(8)
           
                
        }
    }
}

struct OnboardingViewLabel: View {
    let header : String
    let label : String
    
    var body: some View {
        VStack(alignment: .center, spacing: 10){
            Text(header)
                .font(.custom(Strings.appFontBold, size: 24))
                .foregroundColor(Color(Strings.appColor))

            Text(label)
                .font(.custom(Strings.appFontRegular, size: 16))
                .foregroundColor(Color(Strings.onboardingLabelColour))
                .multilineTextAlignment(.center)
                .frame(width: UIScreen.main.bounds.width - 100)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(image: Strings.onboardingCardImage1)
        OnboardingViewLabel(header: Strings.onboardingHeader1, label: Strings.onboardingLabel1)
    }
}




struct OnboardingViewModel: Identifiable {
    let name: String
    let header: String
    let description: String
    let id = UUID()
}

struct OnboardingViewItems {
    static let displays: [OnboardingViewModel] = [
        OnboardingViewModel(name: Strings.onboardingCardImage1, header: Strings.onboardingHeader1, description: Strings.onboardingLabel1),
        OnboardingViewModel(name: Strings.onboardingCardImage2, header: Strings.onboardingHeader2, description: Strings.onboardingLabel2),
        OnboardingViewModel(name: Strings.onboardingCardImage3, header: Strings.onboardingHeader3, description: Strings.onboardingLabel3)
    ]
}
