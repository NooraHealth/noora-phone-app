
{ ContentInterface } = require('../../api/content/ContentInterface.coffee')
{ ContentDownloader } = require('../../api/cordova/ContentDownloader.coffee')
{ Curriculums } = require("meteor/noorahealth:mongo-schemas")
{ Lessons } = require("meteor/noorahealth:mongo-schemas")
{ AppState } = require('../../api/AppState.coffee')

# TEMPLATE
require './home.html'

# COMPONENTS
require '../../ui/components/shared/navbar.html'
require '../../ui/components/home/footer.html'
require '../../ui/components/home/thumbnail.coffee'
require '../../ui/components/home/menu/menu.coffee'
require '../../ui/components/home/menu/list_item.coffee'
require '../../ui/components/audio/audio.coffee'
require '../../ui/components/shared/loading.coffee'

Template.Home_page.onCreated ->

  @onLevelSelected = ( levelName ) ->
    console.log "Level selected!!", levelName
    FlowRouter.go "level", { level: levelName }

  @autorun =>
   if Meteor.isCordova and Meteor.status().connected
    @subscribe "curriculums.all"
    @subscribe "lessons.all"
    @subscribe "modules.all"

Template.Home_page.helpers
  curriculumsReady: ->
    instance = Template.instance()
    return instance.subscriptionsReady()

  menuArgs: ->
    console.log "Getting the menu args"
    instance = Template.instance()
    return {
      onLanguageSelected: instance.onLanguageSelected
      languages: ['English', 'Hindi', 'Kannada']
    }

  thumbnailArgs: (level ) ->
    instance = Template.instance()
    isCurrentLevel = ( AppState.get().getLevel() == level.name )
    return {
      level: level
      onLevelSelected: instance.onLevelSelected
      isCurrentLevel: isCurrentLevel
    }

  levels: ->
    return AppState.get().getLevels()

Template.Home_page.events
  'click #open_side_panel': (e, template) ->
    #hackaround Framework7 bugs on ios where active state is not removed
    active = template.find(".active-state")
    if active? then $(active).removeClass "active-state"
