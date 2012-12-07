# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  playlistHandler()

playlistHandler = ->
  totalTracks = $(".song").length

  $(".song").click ->
    if $(".mp3player").attr('data-current') == $(this).attr('data-track') && $(".mp3player")[0].paused == false
      turnOffSongImage()
      pausePlayer()
    else if $(".mp3player").attr('data-current') == $(this).attr('data-track')
      turnOnSongImage($(this).attr('data-track'))
      unPausePlayer()
    else
      turnOffSongImage()
      playSong($(this).attr('data-track'))
  
  $(".mp3player").bind "ended", ->
    turnOffSongImage()
    currentTrack = $(".mp3player").attr('data-current')
    newTrack = +currentTrack+1
    if newTrack <= totalTracks
      playSong(newTrack)

  playSong = (trackNumber) ->
    song   = $("a[data-track=#{trackNumber}]").attr('data-song')
    track  = $("a[data-track=#{trackNumber}]").attr('data-track')
    title  = $("a[data-track=#{trackNumber}]").attr('data-title')
    $(".mp3player").attr('src', song)
    $(".mp3player").attr('data-current', track)
    $(".mp3player").attr('autoplay', "true")
    turnOnSongImage(trackNumber)
    return false

  turnOffSongImage = ->
    trackNumber = $(".mp3player").attr('data-current')
    $("img[id=#{trackNumber}]").attr('src', "/assets/play_button_black.png")

  turnOnSongImage = (trackNumber) ->
    $("img[id=#{trackNumber}]").attr('src', "/assets/play_button_white.png")

  pausePlayer = ->
    $(".mp3player")[0].pause();

  unPausePlayer = ->
    $(".mp3player")[0].play();


