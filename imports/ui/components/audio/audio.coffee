require './audio.html'

Template.Audio.onCreated ->
  console.log "Creating an audio"

  @autorun =>
    @data = Template.currentData()
    new SimpleSchema({
      "attributes.src": {type: String}
      playing: {type: Boolean}
      replay: {type: Boolean, optional: true}
      afterReplay: {type: Function, optional: true}
      whenFinished: {type: Function, optional: true}
      whenPaused: {type: Function, optional: true}
    }).validate @data

  @autorun =>
    data = Template.currentData()
    shouldReplay = data.replay
    if shouldReplay
      console.log "Replaying"
      @sound?.stop()
      @sound?.play()
      data.afterReplay()

  @autorun =>
    data = Template.currentData()
    shouldPlay = data.playing
    alreadyPlaying = @sound?.playing()
    if shouldPlay and not alreadyPlaying
      console.log "About to play"
      @sound ?= new Howl {
        src: [data.attributes.src]
        onloaderror: (id, error)->
          console.log "LOADERROR #{data.attributes.src}"
          console.log error
          console.trace()
        onend: @data.whenFinished
        onpause: @data.whenPaused
        onplay: ()->
          console.log "begun playing #{data.attributes.src}"
        #html5: true
      }
      @sound.play()
      console.log "Is playing now??"
      console.log @sound.playing()
    else if not shouldPlay and alreadyPlaying and @sound?
      @sound.pause()

Template.Audio.onDestroyed ->
  instance = Template.instance()
  #isPlaying = instance.state.get "playing"
  #if isPlaying
    #instance.sound?.pause()
  console.log "Is the sound playing"
  console.log "On onDestroyed"
  console.log instance
  console.log instance.sound?.playing()
  if instance.sound and instance.sound.playing()
    instance.sound.stop()
  instance.sound?.unload()
