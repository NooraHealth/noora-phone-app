Template.multipleChoiceModule.events
  "click .image-choice": (event, template)->
    $(event.target).toggleClass "selected"

  "click [name^=submit_multiple_choice]": (event, template)->
    module = template.data
    nh_id = module.nh_id
    numPossibleCorrect = module.correct_answer.length
    
    #fade out all the containers of the incorrect options
    [responses, numIncorrect] = expandCorrectOptions(module)

    #Fade out the submit btn
    $(event.target).fadeOut()

    #play the audio depending on whether the user answered correctly or not
    if numIncorrect > 0
      handleFailedAttempt(module, responses )
      playAnswerAudio(event.target, module)
    else
      handleSuccessfulAttempt(module)
    showNextModuleBtn(module)


###
# HELPER FUNCTIONS
###

expandCorrectOptions = (module) ->
    nh_id = module.nh_id
    options = $("img[name=option#{nh_id}]")
    responses = []
    numIncorrect = 0
    for option in options
      
      if $(option).hasClass "selected"
        responses.push $(option).attr "name"

      if not $(option).hasClass "correct"
        $(option).addClass "faded"
      
      else
        $(option).addClass "expanded"
        
        if not $(option).hasClass "selected"
          numIncorrect++
          $(option).addClass "incorrectly_selected"

        else
         $(option).removeClass "selected"
         $(option).addClass "correctly_selected"

    return [responses, numIncorrect]

