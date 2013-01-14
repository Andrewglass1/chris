# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  playlistHandler()

playlistHandler = ->
  totalTracks = $(".song").length

  $(".song").click ->
    console.log($(this).attr('data-track'))
    if $(".mp3player").attr('data-current') == $(this).attr('data-track') && $(".mp3player")[0].paused == false
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
    title  = $("a[data-track=#{trackNumber}]").attr('data-title')
    $(".mp3player").attr('src', song + browserFormat() )
    alert("playing format: " + browserFormat())
    browserFormatLogger()
    $(".mp3player").attr('data-current', track)
    $(".mp3player")[0].play()
    turnOnSongImage(trackNumber)
    return false

  turnOffSongImage = ->
    trackNumber = $(".mp3player").attr('data-current')
    trackNumber ||= "boom"
    $("img#" + trackNumber + ".play").attr('src', "/assets/play_button_black.png")

  turnOnSongImage = (trackNumber) ->
    $("img#" + trackNumber + ".play").attr('src', "/assets/play_button_white.png")

  pausePlayer = ->
    console.log("stoppin")
    $(".mp3player")[0].pause()

  unPausePlayer = ->
    console.log("playin")
    $(".mp3player")[0].play()

  browserFormat= ->
    myAudio = document.createElement('audio'); 
    if myAudio.canPlayType
      canPlayMp3 = !!myAudio.canPlayType && "" != myAudio.canPlayType('audio/mpeg');
      canPlayOgg = !!myAudio.canPlayType && "" != myAudio.canPlayType('audio/ogg; codecs="vorbis"');
      return ".mp3" if canPlayMp3
      return ".ogg" if canPlayOgg

  browserFormatLogger= ->
    myAudio = document.createElement('audio'); 
    if myAudio.canPlayType
      canPlayMp3 = !!myAudio.canPlayType && "" != myAudio.canPlayType('audio/mpeg');
      canPlayOgg = !!myAudio.canPlayType && "" != myAudio.canPlayType('audio/ogg; codecs="vorbis"');
      alert("can play mp3? " + canPlayMp3)
      alert("can play ogg? " + canPlayOgg)