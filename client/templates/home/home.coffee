
Template.home.helpers {
  displayTrophy: ()->
    return Session.get "display trophy"
}
Template.chapterThumbnail.events {
  "click .card": (event, template) ->
    fview = FView.from(template)
}

Template.home.onRendered ()->
  cards = FView.byId "cardLayout"
  width = Session.get "chapter card width"
  cardsComplete = Object.keys(Session.get("chapters complete")).length
  cards.modifier.setTransform Transform.translate(-1 * width * cardsComplete ,0, 0), {duration: 2000, curve: "easeIn"}

Template.chapterThumbnail.onRendered ()->
  fview = FView.from this
  chapters = Session.get "chapters sequence"
  chaptersComplete = Session.get("chapters complete")
  numChaptersComplete = Object.keys(Session.get("chapters complete")).length
  console.log chaptersComplete
  console.log typeof chaptersComplete
  if numChaptersComplete.length > 0
    currentChapterId= chaptersComplete[numChaptersComplete -1]
  else
    currentChapterId = chapters[0].nh_id
  fview.id = this.data.nh_id
  console.log "Chapter thumbnail rendered!"
  console.log "This fview: ", fview.id
  console.log "Current chapter ID: ", currentChapterId
  console.log "Did I complete the chapter? ", completedChapter(currentChapterId)

  fview.modifier.setSize [400, 400]
  fview.modifier.setOrigin [.5, .5]
  fview.modifier.setAlign [.5, .5]
  
  surface = fview.surface or fview.view

  if fview.id == currentChapterId
    fview.modifier.setTransform Transform.scale(1.15, 1.15, 1.15), {duration: 1000, curve: "easeIn"}

  if fview.id == currentChapterId or completedChapter(fview.id)
    
    fview.modifier.setOpacity 1, {duration:500, curve: "easeIn"}
    surface.setProperties {zIndex: 10}

    surface.on "mouseout", ()->
      fview.modifier.halt()
      if fview.id== currentChapterId
        fview.modifier.setTransform Transform.scale(1.15, 1.15, 1.15), {duration: 500, curve: "easeIn"}
      else
        fview.modifier.setTransform Transform.scale(1, 1, 1), {duration: 500, curve: "easeIn"}
    
    surface.on "mouseover", ()->
      fview.modifier.halt()
      fview.modifier.setTransform Transform.scale(1.25, 1.25, 1.25), {duration: 500, curve: "easeIn"}

    surface.on "click", ()->
      console.log "going to the modules page"
      Router.go "ModulesSequence", {nh_id: fview.id}
  
  else
    fview.modifier.setOpacity .5

completedChapter = (nh_id)->
  for key in Object.keys(Session.get "chapters complete")
    id = Session.get("chapters complete")[key]
    if parseInt(id) == parseInt nh_id
      return true
  return false

