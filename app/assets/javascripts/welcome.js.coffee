# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  playlistHandler()

playlistHandler = ->
  totalTracks = $(".song").length
  audioElement = document.createElement('audio')

  $(".song").click ->
    browserFormatLogger()
    console.log($(this).attr('data-track'))
    if $(".mp3player").attr('data-current') == $(this).attr('data-track') && audioElement.paused == false
      console.log("clicked current track playing.  it should pause")
      turnOffSongImage()
      pausePlayer()
    else if $(".mp3player").attr('data-current') == $(this).attr('data-track')
      console.log("clicked current track playing.  it should unpause")
      turnOnSongImage($(this).attr('data-track'))
      unPausePlayer()
    else
      console.log("clicked track not playing.  should start playing")
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
    try
      audioElement.setAttribute('src', song + browserFormat())
      audioElement.load()
      audioElement.play()
      $(".mp3player").attr('data-current', track)
      turnOnSongImage(trackNumber)
    catch error
      alert("error!")
    return false

  turnOffSongImage = ->
    trackNumber = $(".mp3player").attr('data-current')
    trackNumber ||= "boom"
    $("img#" + trackNumber + ".play").attr('src', "/assets/play_button_black.png")

  turnOnSongImage = (trackNumber) ->
    $("img#" + trackNumber + ".play").attr('src', "/assets/play_button_white.png")

  pausePlayer = ->
    console.log("stoppin")
    audioElement.pause()

  unPausePlayer = ->
    console.log("playin")
    audioElement.play()

  browserFormat= ->
    if audioElement.canPlayType
      canPlayMp3 = !!audioElement.canPlayType && "" != audioElement.canPlayType('audio/mpeg');
      canPlayOgg = !!audioElement.canPlayType && "" != audioElement.canPlayType('audio/ogg; codecs="vorbis"');
      return ".mp3" if canPlayMp3
      return ".ogg" if canPlayOgg

  browserFormatLogger= ->
    if audioElement.canPlayType
      canPlayMp3 = !!audioElement.canPlayType && "" != audioElement.canPlayType('audio/mpeg');
      canPlayOgg = !!audioElement.canPlayType && "" != audioElement.canPlayType('audio/ogg; codecs="vorbis"');
      console.log("can play mp3? result:" + canPlayMp3)
      console.log("can play ogg? result:" + canPlayOgg)
      console.log("playing format: " + browserFormat())
    else
      console.log("canPlayType evaluator failed")

