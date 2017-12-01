function init(args) {
  document.write(args);
  console.log(args);
  /*var m = {};

  start_(L, 'L');
  start_(WE, 'WE');

  function start_(API, suffix) {
    var mapDiv = 'map' + suffix;
    var map = API.map(mapDiv, {
      center: [51.505, -0.09],
      zoom: 4,
      dragging: true,
      scrollWheelZoom: true,
      proxyHost: 'http://srtm.webglearth.com/cgi-bin/corsproxy.fcgi?url='
    });
    m[suffix] = map;

    //Add baselayer
    API.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',{
      attribution: '© OpenStreetMap contributors'
    }).addTo(map);

    //Add TileJSON overlay
    var json = {"profile": "mercator", "name": "Grand Canyon USGS", "format": "png", "bounds": [-112.26379395, 35.98245136, -112.10998535, 36.13343831], "minzoom": 10, "version": "1.0.0", "maxzoom": 16, "center": [args[0][0], args[0][1], 13], "type": "overlay", "description": "", "basename": "grandcanyon", "tilejson": "2.0.0", "sheme": "xyz", "tiles": ["http://tileserver.maptiler.com/grandcanyon/{z}/{x}/{y}.png"]};
    if (API.tileLayerJSON) {
      var overlay2 = API.tileLayerJSON(json, map);
    } else {
      //If not able to display the overlay, at least move to the same location
      map.setView([args[0][0], args[0][1]], 13);
    }
	var marker;
    for (int i = 0; i < args.length; i++) {
    	var satrec = satellite.twoline2satrec(args[i][0], args[i][1]);
    	marker = API.marker().addTo(map);
    }
    marker.bindPopup(suffix, 50);
    marker.openPopup();

    //Print coordinates of the mouse
    map.on('mousemove', function(e) {
      document.getElementById('coords').innerHTML = e.latlng.lat + ', ' + e.latlng.lng;
    });
  }

  //Synchronize view
  m['L'].on('move', function(e) {
    var center = m['L'].getCenter();
    var zoom = m['L'].getZoom();
    m['WE'].setView([center['lat'], center['lng']], zoom);
  });*/
}
