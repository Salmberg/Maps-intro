//
//  ContentView.swift
//  Maps-intro
//
//  Created by David Salmberg on 2023-05-09.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var locationManager = LocationManager()
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3323341, longitude: -122.0312186), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    
   @State var places = [
        Place(name: "Nice place", latitude: 37.332, longitude:  -122.032),
        Place(name: "Good place", latitude: 37.332, longitude:  -122.03),
        Place(name: "Nice place", latitude: 37.332, longitude:  -122.029)

    ]
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region,
                interactionModes: [.all],
                showsUserLocation: true,
                userTrackingMode: .constant(.follow),
                annotationItems: places){ place in
                //MapMarker(coordinate: place.coordinate)
                MapAnnotation(coordinate: place.coordinate, anchorPoint:
                                CGPoint(x: 0.5, y: 0.5)){
                    MapPinView(place: place)
                }
            }
            Button(action: {
                addPin()
            }) {
                Text("Add pin")
            }
            Button(action: {
                locationManager.startLocationUpdates()
            }) {
                Text("Start updates")
            }

        }
    }
    func addPin() {
        //let newPlace = Place(name: "New place", latitude: 37.332, longitude: -122.027)
        
        if let location = locationManager.location {
            let newPlace = Place(name: "here", latitude: location.latitude, longitude: location.longitude)
            
            places.append(newPlace)

        }
            }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MapPinView: View {
    var place : Place
    
    var body: some View {
        VStack{
            Image(systemName: "house.fill")
                .resizable()
                .frame(width: 30, height: 30)
            Text(place.name)
        }
    }
    
}
