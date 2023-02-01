//
//  SongCar.swift
//  TuneIn
//
//  Created by Hilly Yehoshua on 1/31/23.
//

import SwiftUI

struct SongCard: View {
    var body: some View {
        //1c293f
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("RoundRect"))
                .opacity(0.9)
                .frame(width: 330, height: 425)
            VStack{
                //Make the profile and name
                HStack (alignment: .bottom){
                    Image("corgi")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 40, height: 40)
                        .padding(.leading, 50)
                    VStack{
                        Text("Isabella Hood")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            //.padding(.trailing, 100)
                            //.multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity,alignment: .center)
                            .font(.custom("Poppins-SemiBold", size: 16))
                        Text("3 hrs late")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            //.padding(.trailing, 100)
                            //.multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity,alignment: .center)
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                    
                }
                // Add the song cover
                Image("lovestory")
                    .resizable()
                    .frame(width: 309, height: 309)
                    .padding(EdgeInsets(top: -25, leading: 0, bottom: 5, trailing: 0))
                    .cornerRadius(5)
                //song name
                Text("Love Story (Taylor's Version)")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: -5, leading: 45, bottom: 0, trailing: 0))
                    .frame(maxWidth: .infinity,alignment: .center)
                    .font(.custom("Poppins-SemiBold", size: 18))
                //artist
                Text("Taylor Swift")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 45, bottom: 5, trailing: 0))
                    //.padding(.trailing, 100)
                    //.multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .font(.custom("Poppins-Regular", size: 16))
            }
            

        }
        
            
    }
}

struct SongCard_Previews: PreviewProvider {
    static var previews: some View {
        SongCard()
    }
}


//struct ItemCardView: View, Identifiable {
//    @StateObject private var viewModel = ItemVM()
//    @EnvironmentObject var session: OnboardingVM
//    var tabSelection: Binding<Int>
//    let maxWidth = UIScreen.main.bounds.width
//    let maxHeight = UIScreen.main.bounds.height
//    var id: String
//
//    init(for id: String, tabSelection: Binding<Int>) {
//        self.id = id
//        self.tabSelection = tabSelection
//    }
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 5) {
//            // Clickable image card.
//            NavigationLink (destination: DetailView(tabSelection: tabSelection).environmentObject(viewModel)) {
//                if (viewModel.itemImage != nil) {   // render item image
//                    Image(uiImage: viewModel.itemImage!)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .clipShape(RoundedRectangle(cornerRadius: 25))
//                }
//                else { // No image found.
//                    Color("LightGrey")
//                        .frame(width: maxWidth/2.2, height: maxHeight/3, alignment: .center)
//                        .clipShape(RoundedRectangle(cornerRadius: 25))
//                }
//            }
//            PreviewItemInfo(for: id)
//        }
//        .environmentObject(viewModel)
//        .environmentObject(session)
//    }
//}
//
//// Structure that offers a preview of item listing details.
//struct PreviewItemInfo: View {
//    @EnvironmentObject private var viewModel: ItemVM
//    @EnvironmentObject var session: OnboardingVM
//    var id: String
//
//    init(for id: String) {
//        self.id = id
//    }
//
//    var body: some View {
//        GeometryReader { proxy in
//            // Information under the image (title, size, and price).
//            HStack(alignment: .top, spacing: 0) {
//                VStack(alignment: .leading) {
//                    Text(viewModel.item.title)
//                        .font(.system(size: 14, weight: .semibold))
//                        .foregroundColor(.black)
//                    Text("Size: \(viewModel.item.size)")
//                        .font(.system(size: 12, weight: .medium))
//                        .foregroundColor(.black)
//                }
//                .frame(maxWidth: proxy.size.width*0.6, alignment: .leading)
//                Spacer()
//                Text(String(format: "$%.2f", viewModel.item.price))
//                    .font(.system(size: 20, weight: .bold))
//                    .foregroundColor(Styles().themePink)
//                    .frame(maxWidth: proxy.size.width*0.4, alignment: .trailing)
//            }
//            .onAppear {
//                viewModel.fetchSeller(for: id, curUser: session.currentUser) {}
//            }
//            .padding(.leading)
//            .padding(.trailing)
//            .padding(.bottom)
//        }
//    }
//}
