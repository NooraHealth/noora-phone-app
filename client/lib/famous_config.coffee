#SpringTransition = famous.transitions.SpringTransition
#EasingTransition = famous.transitions.Easing
#Transitionable = famous.transitions.Transitionable
#Transitionable.registerMethod('spring', SpringTransition)

Transform = null

FView.ready ()->
  this.Transform = famous.core.Transform
  this.Surface = famous.core.Surface
  this.Lightbox = famous.views.Lightbox
  this.Scroller = famous.views.Scroller
  this.EventHandler = famous.core.EventHandler
  this.SpringTransition = famous.transitions.SpringTransition
  famous.polyfills
  famous.core.famous
  console.log famous
