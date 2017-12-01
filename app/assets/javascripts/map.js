$(document).ready(function() {
  function initialize() {
    var earth = new WE.map('earth_div');
    WE.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(earth);
  }
}
