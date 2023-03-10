import StationMap from "./station-map";

let Hooks = {};

Hooks.StationMap = {

  mounted() {
    this.map = new StationMap(this.el, [51.5, -123.5], event => {
      const stationInfo = {
        stationId: event.target.options.stationId
        // structureType: event.target.options.structType
      }
      
      
      this.pushEvent("marker-clicked", stationInfo, (reply, ref) => {
        console.log(reply.station.id);
      });
    });

    this.pushEvent("get-stations", {}, (reply, ref) => {
      reply.stations.forEach(station => {
        this.map.addMarker(station);
      });
    }); 
 

    // approach to adding markers if using a data attribute
    // const incidents = JSON.parse(this.el.dataset.incidents);

    // incidents.forEach(incident => {
    //   this.map.addMarker(incident);
    // })

    

    // this.handleEvent("highlight-marker", station => {
    //   this.map.highlightMarker(station.id);
    // })

    // this.handleEvent("add-marker", incident => {
    //   this.map.addMarker(incident);
    //   this.map.highlightMarker(incident);
    //   this.scrollTo(incident.id)
    // })
  }

  

}
export default Hooks;
