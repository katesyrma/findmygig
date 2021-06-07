const initToggler = () => {
  console.log("hello")

const togglerThing = document.getElementById("toggler-thing");
const artistBtn = document.getElementById("artist-btn");
const playlistBtn = document.getElementById("playlist-btn");
const playlistList = document.getElementById("playlist-list");
const artistsList = document.getElementById("artists-list");
console.log(playlistList)

artistBtn.addEventListener('click', (event) => {

  artistBtn.classList.add("green-active")
  playlistBtn.classList.remove("green-active")
  playlistList.classList.add("hide")
  playlistList.classList.remove("show")
  artistsList.classList.add("show")
})

playlistBtn.addEventListener('click', (event) => {

  artistBtn.classList.remove("green-active")
  playlistBtn.classList.add("green-active")
  artistsList.classList.add("hide")
  artistsList.classList.remove("show")
  playlistList.classList.add("show")
})
}

export {initToggler}
