import places from 'places.js'

const initAlgolia = () => {
  // var places = require('places.js');   WE DON'T NEED IT ANYMORE
  var placesAutocomplete = places({
    // appId: "<YOUR_PLACES_APP_ID>",
    // apiKey: "<YOUR_PLACES_API_KEY>",
    container: document.querySelector('.algolia-box'),
    type: ['city']
  });
}

export { initAlgolia }
