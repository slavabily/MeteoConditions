//
//  MapView.swift
//  MeteoConditions
//
//  Created by slava bily on 29/7/20.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  var latitude: Double
  var longitude: Double
  
  func makeUIView(context: Context) -> MKMapView {
    MKMapView(frame: .zero)
  }
  
  func updateUIView(_ view: MKMapView, context: Context) {
    let coordinate = CLLocationCoordinate2D(
      latitude: self.latitude, longitude: self.longitude)
    let span = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    view.setRegion(region, animated: true)
    view.mapType = .hybrid
    view.isScrollEnabled = false
  }
}

struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    MapView(latitude: 34.011286, longitude: -116.166868)
  }
}

