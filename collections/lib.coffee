
Meteor.getContentSrc = ()->
  console.log "Getting the content src in the Meteor.getContetn "
  #return "http://grass-roots-science.info/"
  if Meteor.isClient or Meteor.isCordova
    if Session.get "content src"
      return Session.get "content src"
    else
      return ""
  if Meteor.isServer
    return Meteor.call "contentEndpoint"
