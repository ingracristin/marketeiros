//
//  OnboardingPageView.swift
//  Marketeiros
//
//  Created by João Guilherme on 26/08/21.
//

import SwiftUI

struct OnboardingPageView: View {
    @State private var selectedPage = 0
    init(){
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(red: 0.192, green: 0.18, blue: 0.408, alpha: 1)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        
        Color(#colorLiteral(red: 0.9798260331, green: 0.9811581969, blue: 0.9283676147, alpha: 1))
            .ignoresSafeArea()
            .overlay(
                
                TabView(selection: $selectedPage){
                    OnboardingP1(selection: $selectedPage).tag(0)
                    OnboardingP2(selection: $selectedPage).tag(1)
                    OnboardingP3(selection: $selectedPage).tag(2)
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                
                
            ).onAppear{
                UIScrollView.appearance().bounces = false
            }
            .onDisappear{
                UIScrollView.appearance().bounces = true
            }
    }
    
}

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView()
    }
}
