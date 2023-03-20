import SwiftUI

struct ProfileCreationTimeZone: View {
    
    @EnvironmentObject var dataManager: DataManager
    @State private var selection = 0
    @State private var timeZoneUs = "Not Selected"
    @Binding var name: String
    @Binding var usernm: String
    @Binding var phoneNumber: String
    
    
    var body: some View {
        ZStack {
            Color("Dark Blue")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("TuneIn")
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .font(.custom("Poppins-SemiBold", size: 30))
                }
                
                Spacer ()
                    .frame(height: 45)
                
                HStack {
                    Text("Where do you live?")
                        .frame(alignment: .center)
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 16))
                    
                }
                
                Spacer()
                    .frame(height: 5)
                
                HStack (spacing: 30) {
                    Spacer()
                    Text("Knowing your time zone allows us to send you notifications at the right time!")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Regular", size: 16))
                        .opacity(0.8)
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 20)
                
                ZStack (alignment: .top){
                    
                    Picker(selection: $selection, label: Text("Pick a time zone")) {
                        Text("Select")
                            .font(.custom("Poppins-Regular", size: 20))
                            .foregroundColor(.white)
                            .tag(0)
                        
                        Text("America")
                            .font(.custom("Poppins-Regular", size: 20))
                            .foregroundColor(.white)
                            .tag(1)
                        
                        
                        Text("Europe")
                            .font(.custom("Poppins-Regular", size: 20))
                            .foregroundColor(.white)
                            .tag(2)
                        
                        
                        Text("East Asia")
                            .font(.custom("Poppins-Regular", size: 20))
                            .foregroundColor(.white)
                            .tag(3)
                        
                        
                        Text("West Asia")
                            .font(.custom("Poppins-Regular", size: 20))
                            .foregroundColor(.white)
                            .tag(4)
                        
                    }
                    .pickerStyle(WheelPickerStyle())
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                
                Spacer()
                
//                if (selection == 1){
//                    timeZoneUs = "America"
//                } else if (selection == 2){
//                    timeZoneUs = "Europe"
//                } else if (selection == 3){
//                    timeZoneUs = "East Asia"
//                } else if (selection == 4){
//                    timeZoneUs = "West Asia"
//                }
                
                if selection != 0 {
                    NavigationLink(destination: FeedEmpty()){
                        HStack{
                            Text("Next")
                                .foregroundColor(.white)
                                .font(.custom("Poppins-Regular", size: 16))
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(width: 230, height: 50)
                                .background(RoundedRectangle(cornerRadius: 30).fill(Color ("Blue")).shadow(radius: 3))
                        }
                    }
                } else {
                    VStack {
                        Text("Next")
                            .foregroundColor(.white)
                            .font(.custom("Poppins-Regular", size: 16))
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 230, height: 50)
                            .background(RoundedRectangle(cornerRadius: 30).fill(Color ("Grey")).shadow(radius: 3))
                    }
                }
            }
        }.onDisappear {
            dataManager.addUser(name: name, username: usernm, phone: phoneNumber, timezone: String(selection))
        }
    }
}

struct ProfileCreationTimeZone_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCreationTimeZone(name: .constant("John Doe"), usernm: .constant("username"), phoneNumber: .constant("1234567890"))
    }
}



//
//import SwiftUI
//
//struct ProfileCreationTimeZone: View {
//
//    @EnvironmentObject var dataManager: DataManager
//    @State private var selection = 0
//    @State private var timeZoneUs = "Not Selected"
//    @Binding var name: String
//    @Binding var usernm: String
//    @Binding var phoneNumber: String
//
//
//    var body: some View {
//        ZStack {
//            Color("Dark Blue")
//                .edgesIgnoringSafeArea(.all)
//
//            VStack {
//                HStack {
//                    Text("TuneIn")
//                        .frame(alignment: .center)
//                        .foregroundColor(.white)
//                        .font(.custom("Poppins-SemiBold", size: 30))
//                }
//
//                Spacer ()
//                    .frame(height: 45)
//
//                HStack {
//                    Text("Where do you live?")
//                        .frame(alignment: .center)
//                        .foregroundColor(.white)
//                        .font(.custom("Poppins-Regular", size: 16))
//
//                }
//
//                Spacer()
//                    .frame(height: 5)
//
//                HStack (spacing: 30) {
//                    Spacer()
//                    Text("Knowing your time zone allows us to send you notifications at the right time!")
//                        .multilineTextAlignment(.center)
//                        .foregroundColor(.white)
//                        .font(.custom("Poppins-Regular", size: 16))
//                        .opacity(0.8)
//                    Spacer()
//                }
//
//                Spacer()
//                    .frame(height: 20)
//
//                ZStack (alignment: .top){
//
//                    Picker(selection: $selection, label: Text("Pick a time zone")) {
//                        Text("Select")
//                            .font(.custom("Poppins-Regular", size: 20))
//                            .foregroundColor(.white)
//                            .tag(0)
//
//                        Text("America")
//                            .font(.custom("Poppins-Regular", size: 20))
//                            .foregroundColor(.white)
//                            .tag(1)
//
//
//                        Text("Europe")
//                            .font(.custom("Poppins-Regular", size: 20))
//                            .foregroundColor(.white)
//                            .tag(2)
//
//
//                        Text("East Asia")
//                            .font(.custom("Poppins-Regular", size: 20))
//                            .foregroundColor(.white)
//                            .tag(3)
//
//
//                        Text("West Asia")
//                            .font(.custom("Poppins-Regular", size: 20))
//                            .foregroundColor(.white)
//                            .tag(4)
//
//
//                    }
//                    .pickerStyle(WheelPickerStyle())
//                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
//
//
//                }
//
//                Spacer()
//
//                if (select == 1){
//                    timeZoneUs = "America"
//                }else if (select == 2){
//                    timeZoneUs = "Europe"
//                }else if (select == 3){
//                    timeZoneUs = "East Asia"
//                }else if (select == 4){
//                    timeZoneUs = "West Asia"
//                }
//
//                if selection != 0 {
//                    NavigationLink(destination: FeedEmpty()){
//                        HStack{
//                            Text("Next")
//                                .foregroundColor(.white)
//                                .font(.custom("Poppins-Regular", size: 16))
//                                .fixedSize(horizontal: false, vertical: true)
//                                .multilineTextAlignment(.center)
//                                .padding()
//                                .frame(width: 230, height: 50)
//                                .background(RoundedRectangle(cornerRadius: 30).fill(Color ("Blue")).shadow(radius: 3))
//                        }
//                    }
//                }else{
//                    VStack {
//                        Text("Next")
//                            .foregroundColor(.white)
//                            .font(.custom("Poppins-Regular", size: 16))
//                            .fixedSize(horizontal: false, vertical: true)
//                            .multilineTextAlignment(.center)
//                            .padding()
//                            .frame(width: 230, height: 50)
//                            .background(RoundedRectangle(cornerRadius: 30).fill(Color ("Grey")).shadow(radius: 3))
//                    }
//                }
//            }
//        }.onDisappear {
//            dataManager.addUser(name: name, username: usernm, phone: phoneNumber, timezone: timeZoneUs)
//        }
//    }
//}
//
//struct ProfileCreationTimeZone_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileCreationTimeZone(name: .constant("John Doe"), usernm: .constant("username"), phoneNumber: .constant("1234567890"))
//    }
//}
