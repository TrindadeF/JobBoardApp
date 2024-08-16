// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery3
//= require popper
//= require bootstrap
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import "../stylesheets/application"
import "../custom/jobs"
import "channels"

document.addEventListener("turbolinks:load", function() {
    const flashMessage = document.querySelector('.alert');
    if (flashMessage) {
      setTimeout(function() {
        flashMessage.remove();
      }, 5000);
    }
  });


document.addEventListener("DOMContentLoaded", function() {
  var timeLeft = 30 * 60;

  function startTimer() {
    var timerInterval = setInterval(function() {
      var minutes = Math.floor(timeLeft / 60);
      var seconds = timeLeft % 60;
      seconds = seconds < 10 ? '0' + seconds : seconds;
      document.getElementById('time-left').textContent = minutes + ':' + seconds;
      
      if (timeLeft <= 0) {
        clearInterval(timerInterval);
        alert("Sua sessão expirou!");
        window.location.href = '/users/sign_out';
      } else {
        timeLeft--;
      }
    }, 1000);
  }

  startTimer();
});

  