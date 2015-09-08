class @Audio extends BaseNode
  constructor: (@src, @id)->
    super

    @.setOrigin .5, .5, .5
     .setAlign 0, 1, 0
     .setMountPoint 0, 1, 0
     .setSizeMode Node.RELATIVE_SIZE, Node.RELATIVE_SIZE
     .setProportionalSize 1, .1

    @.domElement = new DOMElement @,
      tagName: "audio"
      content: "Your browser does not support this audio file"

    @.setSrc @.src

  setSrc: (src)=>
    @.src = src
    #@.domElement.setContent "<audio src='#{src}' id='#{@.id}' controls> Your browser does not support this kind of audio file </audio>"
    @.domElement.setAttribute "id", @.id
    @.domElement.setAttribute "src", src
    console.log "Just set the src"
    console.log @.domElement
    
  getAudioElement: ()=>
    return $("##{@.id}")[0]
  
  play: ()=>
    @.domElement.setAttribute "controls", true
    audio = @.getAudioElement()
    if audio and audio.readyState == 4
      audio.play()
    else
      @.playWhenReady = true

  pause: ()->
    @.domElement.setAttribute "controls", false
    audio = @.getAudioElement()
    if audio and audio.pause
      audio.pause()
